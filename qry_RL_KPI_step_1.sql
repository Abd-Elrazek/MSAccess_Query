SELECT MIS_RL_OS_Data_60_2016.*, 
Switch(
Agent_Code Like '7*' And [Branch_Code]='TAP','Tap',
Agent_Code Like '7*' And [Branch_Code]='DIY','DIY',
Agent_Code Like '7*' And [Branch_Code]='WEB','WEB',
Agent_Code Like '7*' And [Branch_Code]='INT','InterSpace',
Agent_Code Like '7*' And [Branch_Code]='SUP','SupCard',
Agent_Code Like '7*' And [Branch_Code]='REJ','Reject',
Agent_Code Like '7*' And [Branch_Code]='MAS','Masi',
Agent_Code Like '7*' And [Branch_Code]='WPK','Webpak',

Agent_Code Like '7*' And [Source_Code]='E2J','E2J',
Agent_Code Like '7*' And [Source_Code]='TSO','TSO',

Agent_Code Like '7*' And [Branch_Code]='000' And [Source_Code]='OSB','Reject',
Agent_Code Like '7*','TS_Oth',
True,NULL) AS Channel_Sub_step_1
FROM MIS_RL_OS_Data_60_2016;