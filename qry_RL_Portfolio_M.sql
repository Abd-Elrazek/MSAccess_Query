SELECT DM_Mapping.SM AS 1SM, 
DM_Mapping.SM_NAME AS 1SM_NAME, 
DM_Mapping.M AS 1M, 
DM_Mapping.M_NAME AS 1M_NAME, 
DM_Mapping.DM, 
DM_Mapping.DM_NAME, 
qry_RL_Portfolio.*
FROM qry_RL_Portfolio LEFT JOIN DM_Mapping 
     ON qry_RL_Portfolio.AMSup=DM_Mapping.AMSup;
