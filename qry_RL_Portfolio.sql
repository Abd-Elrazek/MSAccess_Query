SELECT qry_RL_Portfolio_step_1.*, 

IIF([Result] IN ( 'A', 'R', 'D', 'C' ), 1, 0) AS Finalized, 
IIF([Result] IN ( 'A', 'R', 'D' ), 1, 0) AS FinalizedNetCancel, 
IIF([Result] = 'A', 1, 0) AS Appr, 
IIF([Result] = 'A' AND [Criteria_Code] = '0000', 1, 0) AS ApprNew, 

IIF(( [Result] = 'A' AND [blk_Code] = 'VX' AND [DAY_CLOSE] <= 60 ), 1, 0) AS VX60, 
IIF(( [Result] = 'A' AND [blk_Code] <> 'VX' AND [BALANCE] <= 1 AND [DAY_CLOSE] <= 60 ), 1, 0) AS [Bal<=0_60], 
IIF(( [Result] = 'A' AND [blk_Code] <> 'VX' AND [BALANCE] <= 1 AND [DAY_CLOSE] <= 30 ), 1, 0) AS [Bal<=0_1-30], 
IIF(( [Result] = 'A' AND [blk_Code] <> 'VX' AND [BALANCE] <= 1 AND [DAY_CLOSE] > 30 AND [DAY_CLOSE] <= 60 ), 1, 0) AS [Bal<=0_31-60], 
IIF(( VX60 = 1 OR [Bal<=0_60] = 1 ), 1, 0) AS VXAndEarly60, 

IIF([Result] = 'A', [Approve_Amount], 0) AS Credit_Limit, 
SWITCH(
( Credit_Limit >= 20000 AND Credit_Limit <= 39999 ), '20k-39k', 
( Credit_Limit >= 40000 AND Credit_Limit <= 59999 ), '40k-59k', 
( Credit_Limit >= 60000 AND Credit_Limit <= 79999 ), '60k-79k', 
( Credit_Limit >= 80000 AND Credit_Limit <= 99999 ), '80k-99k', 
( Credit_Limit >= 100000 AND Credit_Limit <= 119999 ), '100k-119k', 
( Credit_Limit >= 120000 AND Credit_Limit <= 139999 ), '120k-139k', 
( Credit_Limit >= 140000 AND Credit_Limit <= 159999 ), '140k-159k', 
( Credit_Limit >= 160000 ), '>160k') AS Credit_Limit_Range, 

IIF([Result] = 'A', [Money_Transfer], 0) AS FDD, 

IIF([Result] = 'A', [FDD]/[Credit_Limit]*100, NULL) as per_FDDbyCreditLimit,
  
SWITCH(
	( FDD = 5000 ), '5k', 
	( FDD = 10000 ), '10k', 
	( FDD >= 10000 AND FDD <= 14999 ), '10k-14k', 
	( FDD >= 15000 AND FDD <= 19999 ), '15k-19k', 
	( FDD >= 20000 AND FDD <= 24999 ), '20k-24k', 
	( FDD >= 25000 AND FDD <= 29999 ), '25k-29k', 
	( FDD >= 30000 ), '>=30k') AS FDD_Range, 

Switch(
	(AGE>=10 And AGE<=19),'10-19',
	(AGE>=20 And AGE<=26),'20-26',
	(AGE>=27 And AGE<=30),'27-30',
	(AGE>=31 And AGE<=40),'31-40',
	(AGE>=41 And AGE<=50),'41-50',
	(AGE>=51 And AGE<=60),'51-60',
	(AGE>=61 And AGE<=90),'61-90') AS Cus_Age_Range, 

Switch(
	(AGE<=26 And Income_Range='30,000 up'),'FJ&Inc>=30k',
	(AGE<=26 And Income_Range<>'30,000 up'),'First Jobber',
	(AGE>26 And Income_Range='30,000 up'),'Inc>=30k',True,'Mass') AS Cus_Segment,

IIF(Work_Place LIKE '*แอมเวย์*' 
	OR Work_Place LIKE '*amway*' 
	OR Flag_Test LIKE '*amway*' 
	OR Flag_Test LIKE '*แอมเวย์*', "Amway") AS Amway, 
	
SWITCH(
( Work_Place LIKE '*เอไอเอ*'  OR Work_Place LIKE '*AIA*' OR Work_Place LIKE '*เอ ไอ เอ*' OR Work_Place LIKE '*เอ.ไอ.เอ*' ), 'AIA', 
( Work_Place LIKE '*แอกซ่า*' OR Work_Place LIKE '*AXA*' OR Work_Place LIKE '*แอ็กซ่า*' ) , 'AXA' , 
( Work_Place LIKE '*ไทยประกัน*' AND Work_Place NOT LIKE '*ไทยสมุทร*' AND Work_Place NOT LIKE '*เมือง*' ), 'ThaiLife', 
( Work_Place LIKE "*ประกัน*" AND Work_Place NOT LIKE "*สังคม*" ),'OthIns') AS Insurance, 

IIF(( Amway IS NOT NULL OR Insurance IS NOT NULL OR Occupation_Code = '33' ), 1) AS ComEarner, 

Occupation_Code_Frontend.Desc, 
Region_KTC.Province_Eng, 
Region_KTC.Region_Eng 

FROM   (qry_RL_Portfolio_step_1 
LEFT JOIN Occupation_Code_Frontend 
	   ON qry_RL_Portfolio_step_1.Occupation_Code = Occupation_Code_Frontend.Code) 
LEFT JOIN Region_KTC 
	  ON LEFT(qry_RL_Portfolio_step_1.ZipCode, 2) = Region_KTC.Left2_Zipcode; 
