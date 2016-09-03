SELECT 
DataAllTypeTeam_201601.SM, 
DataAllTypeTeam_201601.M, 
DataAllTypeTeam_201601.AMSup, 
DataAllTypeTeam_201601.TL_Code, 
DataAllTypeTeam_201601.TL_Code_Type, 
DataAllTypeTeam_201601.Agent_Code, 
DataAllTypeTeam_201601.Source_Code, 
DataAllTypeTeam_201601.OpenDate, 
'201601' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201601.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201601.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201601
WHERE DataAllTypeTeam_201601.Status='N';

UNION ALL

SELECT 
DataAllTypeTeam_201602.SM, 
DataAllTypeTeam_201602.M, 
DataAllTypeTeam_201602.AMSup, 
DataAllTypeTeam_201602.TL_Code, 
DataAllTypeTeam_201602.TL_Code_Type, 
DataAllTypeTeam_201602.Agent_Code, 
DataAllTypeTeam_201602.Source_Code, 
DataAllTypeTeam_201602.OpenDate, 
'201602' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201602.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201602.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201602
WHERE DataAllTypeTeam_201602.Status='N';


UNION ALL 

SELECT 
DataAllTypeTeam_201603.SM, 
DataAllTypeTeam_201603.M, 
DataAllTypeTeam_201603.AMSup, 
DataAllTypeTeam_201603.TL_Code, 
DataAllTypeTeam_201603.TL_Code_Type, 
DataAllTypeTeam_201603.Agent_Code, 
DataAllTypeTeam_201603.Source_Code, 
DataAllTypeTeam_201603.OpenDate, 
'201603' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201603.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201603.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201603
WHERE DataAllTypeTeam_201603.Status='N';



UNION ALL 

SELECT 
DataAllTypeTeam_201604.SM, 
DataAllTypeTeam_201604.M, 
DataAllTypeTeam_201604.AMSup, 
DataAllTypeTeam_201604.TL_Code, 
DataAllTypeTeam_201604.TL_Code_Type, 
DataAllTypeTeam_201604.Agent_Code, 
DataAllTypeTeam_201604.Source_Code, 
DataAllTypeTeam_201604.OpenDate, 
'201604' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201604.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201604.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201604
WHERE DataAllTypeTeam_201604.Status='N';

UNION ALL


SELECT 
DataAllTypeTeam_201605.SM, 
DataAllTypeTeam_201605.M, 
DataAllTypeTeam_201605.AMSup, 
DataAllTypeTeam_201605.TL_Code, 
DataAllTypeTeam_201605.TL_Code_Type, 
DataAllTypeTeam_201605.Agent_Code, 
DataAllTypeTeam_201605.Source_Code, 
DataAllTypeTeam_201605.OpenDate, 
'201605' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201605.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201605.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201605
WHERE DataAllTypeTeam_201605.Status='N';

UNION ALL 


SELECT 
DataAllTypeTeam_201606.SM, 
DataAllTypeTeam_201606.M, 
DataAllTypeTeam_201606.AMSup, 
DataAllTypeTeam_201606.TL_Code, 
DataAllTypeTeam_201606.TL_Code_Type, 
DataAllTypeTeam_201606.Agent_Code, 
DataAllTypeTeam_201606.Source_Code, 
DataAllTypeTeam_201606.OpenDate, 
'201606' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201606.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201606.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201606
WHERE DataAllTypeTeam_201606.Status='N';


UNION ALL SELECT 
DataAllTypeTeam_201607.SM, 
DataAllTypeTeam_201607.M, 
DataAllTypeTeam_201607.AMSup, 
DataAllTypeTeam_201607.TL_Code, 
DataAllTypeTeam_201607.TL_Code_Type, 
DataAllTypeTeam_201607.Agent_Code, 
DataAllTypeTeam_201607.Source_Code, 
DataAllTypeTeam_201607.OpenDate, 
'201607' AS Month, 
1 AS N_Flag, 
IIf((YEAR(DataAllTypeTeam_201607.OpenDate) = LEFT(Month,4)) AND 
	(FORMAT(MONTH(DataAllTypeTeam_201607.OpenDate),"00") = RIGHT(Month,2)),1,0) AS Open_Flag
FROM DataAllTypeTeam_201607
WHERE DataAllTypeTeam_201607.Status='N';