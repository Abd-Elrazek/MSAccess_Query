SELECT
  A.*, 
  1 AS FlagActive
FROM qry_Productivity_TL_Sales_FlagN_Open AS A 
      LEFT JOIN (SELECT DISTINCT Agent_Code, 
                                 MONTH 
                 FROM quni_ALLProducts_step_1 WHERE Result='A')  AS Z 
       ON A.Agent_Code=Z.Agent_Code
WHERE A.MONTH=Z.MONTH;
