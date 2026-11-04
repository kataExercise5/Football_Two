CREATE PROCEDURE [dbo].[RESULTS_UPDATE_BY_LINE]
	@linesByTeamId int,
	@result decimal
AS
BEGIN

	SET NOCOUNT ON;

	UPDATE LinesByTeam set result = @result 
	WHERE linesByTeamId = @linesByTeamId;

END