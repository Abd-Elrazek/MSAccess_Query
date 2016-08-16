SELECT qry_RL_KPI_step_1.*, 

IIf([Result] In ('A','R','D','C'),1,0) AS Finalized, 
IIf([Result] In ('A','R','D'),1,0) AS Resolved, 
IIf([Result]='A',1,0) AS ApprRL, 
IIf([Result]='A' And [Criteria_Code]='9977',1,0) AS ExistingRL, 
IIf([Result]='A' And [Criteria_Code]='0000',1,0) AS NewRL, 
IIf(([Result]='A' And [blk_Code]='VX' And [DAY_CLOSE]<=60),1,0) AS VX60, 
IIf(([Result]='A' And [blk_Code]<>'VX' And [BALANCE]<=1 And [DAY_CLOSE]<=60),1,0) AS [Bal<=0_60], 
IIf(([Result]='A' And [blk_Code]<>'VX' And [BALANCE]<=1 And [DAY_CLOSE]<=30),1,0) AS [Bal<=0_1-30], 
IIf(([Result]='A' And [blk_Code]<>'VX' And [BALANCE]<=1 And [DAY_CLOSE]>30 And [DAY_CLOSE]<=60),1,0) AS [Bal<=0_31-60], 
IIf((VX60=1 Or [Bal<=0_60]=1),1,0) AS VXAndEarly60, 
IIf([Result]='A',[Approve_Amount],0) AS Credit_Limit, 

Switch(
	(Credit_Limit>=20000 And Credit_Limit<=39999),'20k-39k',
	(Credit_Limit>=40000 And Credit_Limit<=59999),'40k-59k',
	(Credit_Limit>=60000 And Credit_Limit<=79999),'60k-79k',
	(Credit_Limit>=80000 And Credit_Limit<=99999),'80k-99k',
	(Credit_Limit>=100000 And Credit_Limit<=119999),'100k-119k',
	(Credit_Limit>=120000 And Credit_Limit<=139999),'120k-139k',
	(Credit_Limit>=140000 And Credit_Limit<=159999),'140k-159k',
	(Credit_Limit>=160000),'>160k') AS Credit_Limit_Range, 
	
IIf([Result]='A',[Money_Transfer],0) AS FDD, 

Switch(
	(FDD=5000),'5k',
	(FDD=10000),'10k',
	(FDD>=10000 And FDD<=14999),'10k-14k',
	(FDD>=15000 And FDD<=19999),'15k-19k',
	(FDD>=20000 And FDD<=24999),'20k-24k',
	(FDD>=25000 And FDD<=29999),'25k-29k',
	(FDD>=30000),'>=30k') AS FDD_Range, 
	
Switch(
	Agent_Code Not Like '7*' And TL_Code Like '4*','Indv_TL',
	Agent_Code Not Like '7*' And TL_Code Like '5*' And Source_Code In ('OGS','OSS'),'KeyAccount_TL',
	Agent_Code Not Like '7*' And TL_Code Like '5*' And Source_Code Like 'OCS','New_Corp_TL',
	Agent_Code Not Like '7*' And Source_Code Like 'AXA','AXA',
	Agent_Code Like '7*', 'Tele') AS Channel, 
	
Switch(
	AMSup in ('3734', '3001', 'T1390', '3371', '1142') AND [Source_Code] NOT LIKE 'AXA', 'Booth-BKK',
	AMSup in ('1535', '3354', '2178') AND [Source_Code] NOT LIKE 'AXA', 'Booth-UPC',
	AMSup Like 'T1511' AND Month in ('201603','201604','201605','201606','201607','201608','201609','201610','201611','201612') AND [Source_Code] NOT LIKE 'AXA', 'Booth-UPC',
	AMSup Like '1509' AND Month in ('201601','201602','201603') AND [Source_Code] NOT LIKE 'AXA', 'Booth-UPC',) AS Booth, 
	
IIf([TL_Code] in (SELECT DISTINCT [TL_Code] FROM [Telesales Office]), 1, NULL) AS TS_Office, Switch(
	[TS_Office] = 1, 'TS_Office',
	[Booth] = 'Booth-BKK', 'Booth-BKK',
	[Booth] = 'Booth-UPC', 'Booth-UPC',
	Agent_Code Like '7*' And [Branch_Code] = 'TAP', 'Tap',
	Agent_Code Like '7*' And [Branch_Code] = 'DIY', 'DIY',
	Agent_Code Like '7*' And [Branch_Code] = 'WEB', 'WEB',
	Agent_Code Like '7*' And [Branch_Code] = 'INT', 'InterSpace',
	Agent_Code Like '7*' And [Branch_Code] = 'SUP', 'SupCard',
	Agent_Code Like '7*' And [Branch_Code] = 'REJ','Reject',
	Agent_Code Like '7*' And [Branch_Code] = 'E2J','E2J',
	Agent_Code Like '7*' And [Branch_Code] = 'TSO','TSO',
	Agent_Code Like '7*' And [Branch_Code] = '000' And [Source_Code]='OSB','Reject',
	Agent_Code Like '7*' ,'TS_Oth',
	TRUE, 'Direct') AS Channel_Sub, 
	
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
	(AGE>26 And Income_Range='30,000 up'),'Inc>=30k',True,'Mass') AS RL_Segment, IIf(Work_Place Like '*แอมเวย์*' Or Work_Place Like '*amway*' Or Flag_Test Like '*amway*' Or Flag_Test Like '*แอมเวย์*',"Amway") AS Amway, 

Switch(
	(Work_Place Like '*เอไอเอ*' Or Work_Place Like '*AIA*' Or Work_Place Like '*เอ ไอ เอ*' Or Work_Place Like '*เอ.ไอ.เอ*'),'AIA',
	(Work_Place Like '*แอกซ่า*' Or Work_Place Like '*AXA*' Or Work_Place Like '*แอ็กซ่า*'),'AXA',
	(Work_Place Like '*ไทยประกัน*' And Work_Place Not Like '*ไทยสมุทร*' And Work_Place Not Like '*เมือง*'),'ThaiLife',
	(Work_Place Like "*ประกัน*" And Work_Place Not Like "*สังคม*"),'OthIns') AS Insurance, 
IIf((Amway Is Not Null Or Insurance Is Not Null Or Occupation_Code='33'),1) AS ComEarner, 
Occupation_Code_Frontend.Desc, Region_KTC.Province_Eng, Region_KTC.Region_Eng

FROM (qry_RL_KPI_step_1 LEFT JOIN Occupation_Code_Frontend ON qry_RL_KPI_step_1.Occupation_Code=Occupation_Code_Frontend.Code) LEFT JOIN Region_KTC ON LEFT(qry_RL_KPI_step_1.ZipCode,2) =  Region_KTC.Left2_Zipcode;
