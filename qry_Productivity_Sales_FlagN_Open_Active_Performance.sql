SELECT A.SM,
       A.M,
       A.AMSup,
       A.TL_Code,
       A.Agent_Code,
       A.Source_Code,
       A.Status,
       A.NFlag,
       A.MONTH,
       A.OpenDate,
       A.OpenFlag,
       1 AS FlagActive,
       Z.CCN,
       Z.RL,
       Z.Total
FROM qry_DataAllTeam_FlagN_Open AS A
LEFT JOIN
  (SELECT Agent_Code,
          MONTH,
          SUM(IIF(Product="CC"
                  AND ApprNew=1, 1, 0)) AS CCN,
          SUM(IIF(Product="RL"
                  AND Appr=1, 1, 0)) AS RL,
          CCN+RL AS Total
   FROM quni_CC_RL_2016_2017_Performance
   WHERE RESULT='A'
   GROUP BY Agent_Code,
            MONTH) AS Z ON A.Agent_Code=Z.Agent_Code
WHERE A.MONTH=Z.MONTH;
