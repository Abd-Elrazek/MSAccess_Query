SELECT quni_CC_RL_2016_2017_Performance.*,
       Switch([Source_Code] IN ('TSO','OSB','OSN','PXC','PXD','SRN','SRS','TCS','E2J'), 'Tele', TRUE,'OSS') AS Channel,
       IIf([TL_Code] IN
             (SELECT DISTINCT [TL_Code]
              FROM [Telesales Office]), 1, NULL) AS TS_Office,
       Switch(Channel = 'OSS'
              AND [TS_Office] = 1,'OSS_Tele', Channel = 'OSS','Direct', Channel = 'Tele','Telesales') AS Channel_Sub,
       Switch([Channel_Sub] = 'Direct'
              AND TL_Code LIKE '4*','Indv_TL', [Channel_Sub] = 'Direct'
              AND TL_Code LIKE '5*'
              AND Source_Code LIKE 'OCS','New_Corp_TL', [Channel_Sub] = 'Direct'
              AND TL_Code LIKE '5*','KeyAccount_TL', [Channel_Sub] = 'Direct'
              AND Source_Code LIKE 'AXA','AXA', [Channel_Sub] = 'OSS_Tele', 'OSS_Tele', [Channel_Sub] = 'Telesales', 'Telesales') AS TL_Type
FROM quni_CC_RL_2016_2017_Performance;
