SELECT 
MIS_CC_OS_Data_2016.SM, 
MIS_CC_OS_Data_2016.SM_NAME, 
MIS_CC_OS_Data_2016.M, 
MIS_CC_OS_Data_2016.M_NAME, 
MIS_CC_OS_Data_2016.AMSup, 
MIS_CC_OS_Data_2016.[AMSup NAME], 
MIS_CC_OS_Data_2016.TL_Code, 
MIS_CC_OS_Data_2016.TL_Name, 
MIS_CC_OS_Data_2016.Agent_Code, 
MIS_CC_OS_Data_2016.Agent_Name, 
MIS_CC_OS_Data_2016.Result, 
MIS_CC_OS_Data_2016.Month, 
MIS_CC_OS_Data_2016.Criteria_Code, 
MIS_CC_OS_Data_2016.[New/Exist], 
MIS_CC_OS_Data_2016.Branch_Code,
'CC' AS Product,
IIf([Result] In ('A','R','D','C'),1,0) AS Finalized, 
IIf([Result] in ('A','R','D'),1,0) AS Resolved, 
IIf([Result]='A',1,0) AS Appr, 
IIf(([Result]='A' And [Criteria_Code]='0000'),1,0) AS ApprNew, 
IIf(([Result]='A' And [Criteria_Code]='0000'),[Approve_Amount],0) AS Credit_Limit, 
IIf(([Result]='A' And [Criteria_Code]='0000' And [No_Transaction_Date]<=60),1,0) AS Quality60
FROM MIS_CC_OS_Data_2016;
 
UNION ALL SELECT 
MIS_RL_OS_Data_60_2016.SM, 
MIS_RL_OS_Data_60_2016.SM_NAME, 
MIS_RL_OS_Data_60_2016.M, 
MIS_RL_OS_Data_60_2016.M_NAME, 
MIS_RL_OS_Data_60_2016.AMSup, 
MIS_RL_OS_Data_60_2016.[AMSup NAME], 
MIS_RL_OS_Data_60_2016.TL_Code, 
MIS_RL_OS_Data_60_2016.TL_Name, 
MIS_RL_OS_Data_60_2016.Agent_Code, 
MIS_RL_OS_Data_60_2016.Agent_Name, 
MIS_RL_OS_Data_60_2016.Result, 
MIS_RL_OS_Data_60_2016.Month, 
MIS_RL_OS_Data_60_2016.Criteria_Code,
'' AS [New/Exist],
MIS_RL_OS_Data_60_2016.Branch_Code,
'RL' AS Product,
IIf([Result] In ('A','R','D','C'),1,0) AS Finalized, 
IIf([Result] in ('A','R','D'),1,0) AS Resolved, 
IIf([Result]='A',1,0) AS Appr, 
IIf([Result]='A' And [Criteria_Code]='0000',1,0) AS ApprNew, 
IIf([Result]='A',[Approve_Amount],0) AS Credit_Limit,
IIf((([Result]='A' And [blk_Code]='VX' And [DAY_CLOSE]<=60) Or ([Result]='A' And [blk_Code]<>'VX' And [BALANCE]<=1 And [DAY_CLOSE]<=60)),1,0) AS Quality60
FROM MIS_RL_OS_Data_60_2016;

e, 
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
