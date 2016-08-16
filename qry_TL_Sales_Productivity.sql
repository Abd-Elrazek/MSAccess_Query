SELECT qry_AllTeam_FlagN_FlagOpen.*, 
qry_ALLProduct_SummarySales.TT_Appr, 
IIf(qry_ALLProduct_SummarySales.TT_Appr>0,1,0) AS ActiveSales_Flag, 
Switch(
    qry_AllTeam_FlagN_FlagOpen.Agent_Code NOT LIKE '7*' AND qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '4*','Indv_TL',
    qry_AllTeam_FlagN_FlagOpen.Agent_Code NOT LIKE '7*' AND qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '5*' AND qry_AllTeam_FlagN_FlagOpen.Source_Code in ('OGS','OSS'),'KeyAccount_TL',
    qry_AllTeam_FlagN_FlagOpen.Agent_Code NOT LIKE '7*' AND qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '5*' AND qry_AllTeam_FlagN_FlagOpen.Source_Code LIKE 'OCS','New_Corp_TL',
    qry_AllTeam_FlagN_FlagOpen.Agent_Code NOT LIKE '7*' AND qry_AllTeam_FlagN_FlagOpen.Source_Code LIKE 'AXA','AXA',
    qry_AllTeam_FlagN_FlagOpen.Agent_Code LIKE '7*', 'Tele') AS Channel_Group
FROM qry_AllTeam_FlagN_FlagOpen 
LEFT JOIN qry_ALLProduct_SummarySales 
    ON (qry_AllTeam_FlagN_FlagOpen.Month = qry_ALLProduct_SummarySales.Month) 
        AND (qry_AllTeam_FlagN_FlagOpen.Agent_Code = qry_ALLProduct_SummarySales.Agent_Code)
WHERE qry_AllTeam_FlagN_FlagOpen.TL_Code <> '-1';