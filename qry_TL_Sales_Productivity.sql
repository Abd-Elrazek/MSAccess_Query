SELECT qry_AllTeam_FlagN_FlagOpen.*, 
qry_ALLProduct_SummarySales.TT_Appr, 
IIf(qry_AllTeam_FlagN_FlagOpen.[TL_Code] in (SELECT DISTINCT [TL_Code] FROM [Telesales Office]), 1, NULL) AS TS_Office, 
Switch(
	TS_Office = 1,'TS_Office',
	qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '4*','Indv_TL',
	qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '5*' AND qry_AllTeam_FlagN_FlagOpen.Source_Code IN ('OGS','OSS'),'KeyAccount_TL',
	qry_AllTeam_FlagN_FlagOpen.TL_Code LIKE '5*' AND qry_AllTeam_FlagN_FlagOpen.Source_Code LIKE 'OCS','New_Corp_TL',
	qry_AllTeam_FlagN_FlagOpen.Source_Code LIKE 'AXA','AXA',
	qry_AllTeam_FlagN_FlagOpen.Agent_Code LIKE '7*', 'Tele') AS Channel_Group,
IIf(qry_ALLProduct_SummarySales.TT_Appr>0,1,0) AS ActiveSales_Flag
FROM qry_AllTeam_FlagN_FlagOpen 
LEFT JOIN qry_ALLProduct_SummarySales 
    ON (qry_AllTeam_FlagN_FlagOpen.Month = qry_ALLProduct_SummarySales.Month) 
    AND (qry_AllTeam_FlagN_FlagOpen.Agent_Code = qry_ALLProduct_SummarySales.Agent_Code)
WHERE qry_AllTeam_FlagN_FlagOpen.TL_Code <> '-1';es 
    ON (qry_AllTeam_FlagN_FlagOpen.Month = qry_ALLProduct_SummarySales.Month) 
    AND (qry_AllTeam_FlagN_FlagOpen.Agent_Code = qry_ALLProduct_SummarySales.Agent_Code)
WHERE qry_AllTeam_FlagN_FlagOpen.TL_Code <> '-1';