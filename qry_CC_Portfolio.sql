SELECT qry_CC_Channel.*, 

IIf([Result] In ('A','R','D','C'),1,0) AS Finalized, 
IIf([Result] In ('A','R','D'),1,0) AS FinalizedNetCancel, 
IIf([Result]='A',1,0) AS Appr, 
IIf(([Result]='A' And LEFT([New/Exist],1)='N'),1,0) AS ApprNew, 
IIf(([Result]='A' And LEFT([New/Exist],1)='N'),[Approve_Amount],0) AS Credit_Limit_New, 
IIf(([Result]='A' And LEFT([New/Exist],1)='N' And [Act_status]='Yes'),1,0) AS Activate, 
IIf(([Result]='A' And LEFT([New/Exist],1)='N' And [No_Transaction_Date]<=60),1,0) AS Active60, 

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
	
IIf(Work_Place Like '*แอมเวย์*' Or Work_Place Like '*amway*' Or Flag_Test Like '*amway*' Or Flag_Test Like '*แอมเวย์*',1,0) AS Amway, 

Switch(
	(Work_Place Like '*เอไอเอ*' Or Work_Place Like '*AIA*' Or Work_Place Like '*เอ ไอ เอ*' Or Work_Place Like '*เอ.ไอ.เอ*'),'AIA',
	(Work_Place Like '*แอกซ่า*' Or Work_Place Like '*AXA*' Or Work_Place Like '*แอ็กซ่า*'),'AXA',
	(Work_Place Like '*ไทยประกัน*' And Work_Place Not Like '*ไทยสมุทร*' And Work_Place Not Like '*เมือง*'),'ThaiLife',
	(Work_Place Like "*ประกัน*" And Work_Place Not Like "*สังคม*"),'OthIns') AS Insurance, 

IIf((Amway Is Not Null Or Insurance Is Not Null Or Occupation_Code='33'),1,0) AS ComEarner, 

Occupation_Code_Frontend.Desc, 

Province_Code_KTC.*

FROM   (qry_cc_Channel 
        LEFT JOIN occupation_code_frontend 
               ON [qry_cc_Channel].occupation_code = 
                  occupation_code_frontend.code) 
       LEFT JOIN province_code_ktc 
              ON [qry_cc_Channel].zipcode = province_code_ktc.zip_code; 
