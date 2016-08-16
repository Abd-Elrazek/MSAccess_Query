SELECT qry_CC_KPI_step1.*, 
  
IIf([Result] In ('A','R','D','C'),1,0) AS Finalized, 
IIf([Result] In ('A','R','D'),1,0) AS Resolved, 
IIf([Result]='A',1,0) AS ApprCC, 
IIf(([Result]='A' And [Criteria_Code]='0000'),1,0) AS NewCC, 
IIf(([Result]='A' And [Criteria_Code]='0000'),[Approve_Amount],0) AS Credit_Limit_New, 
IIf(([Result]='A' And [Criteria_Code]='0000' And [Act_status]='Yes'),1,0) AS Activate, 
IIf(([Result]='A' And [Criteria_Code]='0000' And [No_Transaction_Date]<=60),1,0) AS Active60, 
   
Switch(
(AGE>=10 And AGE<=19),'10-19',
(AGE>=20 And AGE<=26),'20-26',
(AGE>=27 And AGE<=30),'27-30',
(AGE>=31 And AGE<=40),'31-40',
(AGE>=41 And AGE<=50),'41-50',
(AGE>=51 And AGE<=60),'51-60',
(AGE>=61 And AGE<=90),'61-90') AS Cus_Age_Range, 
  
  
Switch(
Agent_Code Not Like '7*' And TL_Code Like '4*','Indv_TL',
Agent_Code Not Like '7*' And TL_Code Like '5*' And Source_Code In ('OGS','OSS'),'KeyAccount_TL',
Agent_Code Not Like '7*' And TL_Code Like '5*' And Source_Code Like 'OCS','New_Corp_TL',
Agent_Code Not Like '7*' And Source_Code Like 'AXA','AXA',
Agent_Code Like '7*','Tele') AS Channel, 

  
Switch(
AMSup In ('3734','3001','T1390','3371','1142') And [Source_Code] Not Like 'AXA','Booth-BKK',
AMSup In ('1535','3354','2178') And [Source_Code] Not Like 'AXA','Booth-UPC',
AMSup Like 'T1511' And Month In ('201603','201604','201605','201606','201607','201608','201609','201610','201611','201612') And [Source_Code] Not Like 'AXA','Booth-UPC',
AMSup Like '1509' And Month In ('201601','201602','201603') And [Source_Code] Not Like 'AXA','Booth-UPC') AS Booth, 
IIf([TL_Code] in (SELECT DISTINCT [TL_Code] FROM [Telesales Office]), 1, NULL) AS TS_Office, 
  

Switch(  
([Channel_Sub_step_1] IS NOT NULL), [Channel_Sub_step_1],
([Channel_Sub_step_1] IS NULL AND [TS_Office]=1),'TS_Office',
([Channel_Sub_step_1] IS NULL AND [Booth]='Booth-BKK'),'Booth-BKK',
([Channel_Sub_step_1] IS NULL AND [Booth]='Booth-UPC'),'Booth-UPC',
[Channel_Sub_step_1] IS NULL ,'Direct') AS Channel_Sub, 
  

Switch(
(Credit_Limit_New>=20000 And Credit_Limit_New<=39999),'20k-39k',
(Credit_Limit_New>=40000 And Credit_Limit_New<=59999),'40k-59k',
(Credit_Limit_New>=60000 And Credit_Limit_New<=79999),'60k-79k',
(Credit_Limit_New>=80000 And Credit_Limit_New<=99999),'80k-99k',
(Credit_Limit_New>=100000 And Credit_Limit_New<=119999),'100k-119k',
(Credit_Limit_New>=120000 And Credit_Limit_New<=139999),'120k-139k',
(Credit_Limit_New>=140000 And Credit_Limit_New<=159999),'140k-159k',
(Credit_Limit_New>=160000),'>160k') AS Credit_Limit_New_Range, 
  
Switch(
(AGE<=26 And Income_Range='30,000 up'),'FJ&Inc>=30k',
(AGE<=26 And Income_Range<>'30,000 up'),'First Jobber',
(AGE>26 And Income_Range='30,000 up'),'Inc>=30k',
True,'Mass') AS CC_Segment, 

IIf(Work_Place Like '*แอมเวย์*' Or Work_Place Like '*amway*' Or Flag_Test Like '*amway*' Or Flag_Test Like '*แอมเวย์*',1,0) AS Amway, 
Switch(
(Work_Place Like '*เอไอเอ*' Or Work_Place Like '*AIA*' Or Work_Place Like '*เอ ไอ เอ*' Or Work_Place Like '*เอ.ไอ.เอ*'),'AIA',
(Work_Place Like '*แอกซ่า*' Or Work_Place Like '*AXA*' Or Work_Place Like '*แอ็กซ่า*'),'AXA',
(Work_Place Like '*ไทยประกัน*' And Work_Place Not Like '*ไทยสมุทร*' And Work_Place Not Like '*เมือง*'),'ThaiLife',
(Work_Place Like "*ประกัน*" And Work_Place Not Like "*สังคม*"),'OthIns') AS Insurance, 

IIf((Amway Is Not Null Or Insurance Is Not Null Or Occupation_Code='33'),1,0) AS ComEarner, 
Occupation_Code_Frontend.Desc, 
Region_KTC.Province_Eng, 
Region_KTC.Region_Eng
FROM (qry_CC_KPI_step1 LEFT JOIN Occupation_Code_Frontend ON qry_CC_KPI_step1.Occupation_Code=Occupation_Code_Frontend.Code) LEFT JOIN Region_KTC ON LEFT(qry_CC_KPI_step1.ZipCode,2)=Region_KTC.Left2_Zipcode;
