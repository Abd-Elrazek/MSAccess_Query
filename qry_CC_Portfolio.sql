SELECT qry_CC_Channel.*,
       IIf([Result] IN ('A','R','D','C'),1,0) AS Finalized,
       IIf([Result] IN ('A','R','D'),1,0) AS FinalizedNetCancel,
       IIf([Result]='A',1,0) AS Appr,
       IIf(([Result]='A' AND Left([New/Exist],1)='N'),1,0) AS ApprNew,
       IIf(([Result]='A' AND Left([New/Exist],1)='N'),[Approve_Amount],0) AS Credit_Limit_New,
       IIf(([Result]='A' AND Left([New/Exist],1)='N' AND [Act_status]='Yes'),1,0) AS Activate,
       IIf(([Result]='A' AND Left([New/Exist],1)='N' AND [No_Transaction_Date]<=60),1,0) AS Active60,
       Switch(
              (Credit_Limit_New>=20000 AND Credit_Limit_New<=39999),'20k-39k',
              (Credit_Limit_New>=40000 AND Credit_Limit_New<=59999),'40k-59k',
              (Credit_Limit_New>=60000 AND Credit_Limit_New<=79999),'60k-79k',
              (Credit_Limit_New>=80000 AND Credit_Limit_New<=99999),'80k-99k',
              (Credit_Limit_New>=100000 AND Credit_Limit_New<=119999),'100k-119k',
              (Credit_Limit_New>=120000 AND Credit_Limit_New<=139999),'120k-139k',
              (Credit_Limit_New>=140000 AND Credit_Limit_New<=159999),'140k-159k',
              (Credit_Limit_New>=160000),'>160k') AS Credit_Limit_New_Range,
       Switch((AGE>=10 AND AGE<=19),'10-19',
              (AGE>=20 AND AGE<=26),'20-26',
              (AGE>=27 AND AGE<=30),'27-30',
              (AGE>=31 AND AGE<=40),'31-40',
              (AGE>=41 AND AGE<=50),'41-50',
              (AGE>=51 AND AGE<=60),'51-60',
              (AGE>=61 AND AGE<=90),'61-90') AS Cus_Age_Range,
       Switch((AGE<=26 AND Income_Range='30,000 up'),'FJ&Inc>=30k',
              (AGE<=26 AND Income_Range<>'30,000 up'),'First Jobber',
              (AGE>26 AND Income_Range='30,000 up'),'Inc>=30k',TRUE,'Mass') AS Cus_Segment,
       IIf(Work_Place LIKE '*แอมเวย์*'
           OR Work_Place LIKE '*amway*'
           OR Flag_Test LIKE '*amway*'
           OR Flag_Test LIKE '*แอมเวย์*',1,0) AS Amway,
       Switch((Work_Place LIKE '*เอไอเอ*'
               OR Work_Place LIKE '*AIA*'
               OR Work_Place LIKE '*เอ ไอ เอ*'
               OR Work_Place LIKE '*เอ.ไอ.เอ*'),'AIA',
              (Work_Place LIKE '*แอกซ่า*' 
               OR Work_Place LIKE '*AXA*'
               OR Work_Place LIKE '*แอ็กซ่า*'),'AXA',
              (Work_Place LIKE '*ไทยประกัน*'
               AND Work_Place NOT LIKE '*ไทยสมุทร*'
               AND Work_Place NOT LIKE '*เมือง*'),'ThaiLife',
              (Work_Place LIKE "*ประกัน*"
               AND Work_Place NOT LIKE "*สังคม*"),'OthIns') AS Insurance,
       IIf((Amway IS NOT NULL
            OR Insurance IS NOT NULL
            OR Occupation_Code='33'),1,0) AS ComEarner,
       occupation_code_frontend.Desc,
       province_code_ktc.Province,
       province_code_ktc.Sub_Region,
       province_code_ktc.Sub_Region2,
       province_code_ktc.BKK_UPC,
       province_code_ktc.strategic
FROM (qry_CC_Channel
      LEFT JOIN occupation_code_frontend ON qry_CC_Channel.occupation_code = occupation_code_frontend.code)
      LEFT JOIN province_code_ktc ON qry_CC_Channel.zipcode = province_code_ktc.zip_code;
