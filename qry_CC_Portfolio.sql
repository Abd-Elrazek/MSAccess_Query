SELECT MIS_CC_OS_Data_2017.*,

Switch(
	[Source_Code] IN ('TSO','OSB','OSN','PXC','PXD','SRN','SRS','TCS','E2J'), 'Tele',
	TRUE,'OSS') AS Channel,

Switch(
	Channel = 'Tele' AND Branch_Code In ('REJ','SUP','CTC','MGP','PCC','CCP','000'), 'Offline_Tele',
	Channel = 'Tele', 'Online_Tele'
	) AS Media_Type,
	
Switch(
	[Media_Type] = 'Online_Tele' AND Branch_Code In ('WEB','DIY','TAP','TAB','CMK','MMK','FBB','FBC','DBB'), 'Own_Media',
	[Media_Type] = 'Online_Tele' AND Branch_Code In ('FBA','FBP','GGP','SSP','INT','MAS','WPK','RAB','MAF'), 'Paid_Media',
	True, Null
	) AS Media_Cost,
	
Switch(
	[Media_Type] = 'Online_Tele' AND Branch_Code In ('WEB','DIY','TAP','TAB','CMK','MMK','FBB','FBC','DBB','FBA','FBP'), 'KTC_Media',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'GGP','GoogleSearch',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'SSP','Silkspan',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'INT','Interspace',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'MAS','Masii',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'WPK','WebPak',
	[Media_Type] = 'Online_Tele' AND Branch_Code = 'RAB','Rabbit',
	True, Null
	) AS Media_Owner,
	
Switch(
	[Media_Owner] = 'KTC_Media' AND Branch_Code = 'WEB','KTC_Web',
	[Media_Owner] = 'KTC_Media' AND Branch_Code = 'DIY','DIY',
	[Media_Owner] = 'KTC_Media' AND Branch_Code In ('TAP','TAB'), 'Tap',
	[Media_Owner] = 'KTC_Media' AND Branch_Code = 'CMK','QR-CC',
	[Media_Owner] = 'KTC_Media' AND Branch_Code = 'MMK','QR-Merchant',
	[Media_Owner] = 'KTC_Media' AND Branch_Code = 'DBB','QR-Touch',
	[Media_Owner] = 'KTC_Media' AND Branch_Code In ('FBB','FBC','FBA','FBP'), 'KTC_Facebook'
	) AS KTC_Media_Type,

Switch(
	[Media_Type] = 'Offline_Tele' AND Branch_Code IN ('REJ','000'),'Lead_Rej',
	[Media_Type] = 'Offline_Tele' AND Branch_Code = 'SUP','SupCard',
	[Media_Type] = 'Offline_Tele' AND Branch_Code = 'CTC','Lead_CS',
	[Media_Type] = 'Offline_Tele' AND Branch_Code = 'MGP','Lead_MGM',
	[Media_Type] = 'Offline_Tele' AND Branch_Code IN ('PCC','CCP'),'Lead_XSell'
	) AS Offline_Proj,

IIf([TL_Code] in (SELECT DISTINCT [TL_Code] FROM [Telesales Office]), 1, NULL) AS TS_Office, 
	
Switch(
	Channel = 'OSS' And [TS_Office] = 1,'OSS_Tele',
	Channel = 'OSS','Direct',
	Channel = 'Tele','Telesales') AS Channel_Sub,
	
Switch(
	[Channel_Sub] = 'Direct' And TL_Code Like '4*','Indv_TL',
	[Channel_Sub] = 'Direct' And TL_Code Like '5*' And Source_Code Like 'OCS','New_Corp_TL',
	[Channel_Sub] = 'Direct' And TL_Code Like '5*' ,'KeyAccount_TL',
	[Channel_Sub] = 'Direct' And Source_Code Like 'AXA','AXA',
	[Channel_Sub] = 'OSS_Tele', 'OSS_Tele', 
	[Channel_Sub] = 'Telesales', 'Telesales') AS TL_Type

	
FROM MIS_CC_OS_Data_2017;
