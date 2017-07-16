SELECT quni_DataAllTeam_2016_2017.*, 1 AS NFlag, 
IIf((Year(OpenDate)=Left(Month,4) And Month(OpenDate)=Val(Right(Month,2))),1,0) AS OpenFlag
FROM quni_DataAllTeam_2016_2017
WHERE ((([quni_DataAllTeam_2016_2017].Source_Code)<>'AXA'));

