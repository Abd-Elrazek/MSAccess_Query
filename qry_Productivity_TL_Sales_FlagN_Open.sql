SELECT 
  quni_DataAllTeam_step_1.*, 
  1 AS NFlag, 
  IIf((Year(OpenDate)=Left(Month,4) And Month(OpenDate)=Val(Right(Month,2))),1,0) AS OpenFlag
FROM quni_DataAllTeam_step_1
WHERE (((quni_DataAllTeam_step_1.[Source_Code])<>'AXA'));
