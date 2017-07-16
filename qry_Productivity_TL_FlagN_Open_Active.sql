SELECT A.SM,
       A.M,
       A.AMSup,
       A.TL_Code_Type,
       A.Agent_Code AS TL_Code,
       A.Source_Code,
       A.Status,
       A.NFlag,
       A.MONTH,
       A.OpenDate,
       A.OpenFlag,
       1 AS FlagActive
FROM qry_DataAllTeam_FlagN_Open AS A
LEFT JOIN
  (SELECT DISTINCT TL_Code,
                   MONTH
   FROM quni_CC_RL_2016_2017_Performance
   WHERE RESULT='A') AS Z ON A.Agent_Code=Z.TL_Code
WHERE (((A.MONTH)=[Z].[MONTH]));
