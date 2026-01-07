CREATE PROCEDURE [dbo].[GAME_QUERY_BY_TEAMS_AND_DATE]
	@visitingTeam NVARCHAR(32),
	@homeTeam NVARCHAR(32),
	@datePlayed date
AS
BEGIN
	SET NOCOUNT ON;

	SELECT G.gameId
	FROM games g
		JOIN teams th ON th.teamId = g.homeTeam
		JOIN teams tv ON tv.teamId = g.visitingTeam
	WHERE g.datePlayed = @datePlayed
		AND th.teamName = @homeTeam
		AND tv.teamName = @visitingTeam

END
