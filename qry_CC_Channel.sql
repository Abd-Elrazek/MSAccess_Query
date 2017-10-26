SELECT quni_CC_2016_2017.*,
       Switch([Source_Code] IN ('OBB','OBS','OBU','OCB','OCS','OES','OGS','OSI','OSS','OSU','AXA'), 'OSS', 
              TRUE,'Tele') AS Channel,
       Switch(Channel = 'Tele'
              AND Branch_Code IN ('REJ','SUP','CTC','MGP','PCC','CCP','000'), 'Offline_Tele', Channel = 'Tele', 'Online_Tele') AS Media_Type,
       Switch([Media_Type] = 'Online_Tele'
              AND Branch_Code IN ('WEB','DIY','TAP','TAB','CMK','MMK','FBB','FBC','DBB'), 'Own_Media', [Media_Type] = 'Online_Tele'
              AND Branch_Code IN ('FBA','FBP','GGP','SSP','INT','MAS','WPK','RAB','MAF'), 'Paid_Media', TRUE, NULL) AS Media_Cost,
       Switch([Media_Type] = 'Online_Tele'
              AND Branch_Code IN ('WEB','DIY','TAP','TAB','CMK','MMK','FBB','FBC','DBB','FBA','FBP'), 'KTC_Media', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'GGP','GoogleSearch', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'SSP','Silkspan', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'INT','Interspace', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'MAS','Masii', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'WPK','WebPak', [Media_Type] = 'Online_Tele'
              AND Branch_Code = 'RAB','Rabbit', TRUE, NULL) AS Media_Owner,
       Switch([Media_Owner] = 'KTC_Media'
              AND Branch_Code = 'WEB','KTC_Web', [Media_Owner] = 'KTC_Media'
              AND Branch_Code = 'DIY','DIY', [Media_Owner] = 'KTC_Media'
              AND Branch_Code IN ('TAP','TAB'), 'Tap', [Media_Owner] = 'KTC_Media'
              AND Branch_Code = 'CMK','QR-CC', [Media_Owner] = 'KTC_Media'
              AND Branch_Code = 'MMK','QR-Merchant', [Media_Owner] = 'KTC_Media'
              AND Branch_Code = 'DBB','QR-Touch', [Media_Owner] = 'KTC_Media'
              AND Branch_Code IN ('FBB','FBC','FBA','FBP'), 'KTC_Facebook') AS KTC_Media_Type,
       Switch([Media_Type] = 'Offline_Tele'
              AND Branch_Code IN ('REJ','000'),'Lead_Rej', [Media_Type] = 'Offline_Tele'
              AND Branch_Code = 'SUP','SupCard', [Media_Type] = 'Offline_Tele'
              AND Branch_Code = 'CTC','Lead_CS', [Media_Type] = 'Offline_Tele'
              AND Branch_Code = 'MGP','Lead_MGM', [Media_Type] = 'Offline_Tele'
              AND Branch_Code IN ('PCC','CCP'),'Lead_XSell') AS Offline_Proj,
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
FROM quni_CC_2016_2017;
