CREATE PROCEDURE [dbo].[GAME_QUERY_BY_ID]
	@gameId int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		G.gameId, 
		G.visitingTeam as visitingTeamId, TV.teamName visitingTeamName,
		G.homeTeam as homeTeamId, TH.teamName as homeTeamName,
		G.stadium, G.datePlayed, G.dayOfWeekPlayed, 
		G.scheduleYear, G.scheduleWeek,
		G.visitorScore as visitingTeamScore, G.homeScore as homeTeamScore
	FROM games g
		JOIN teams TH ON TH.teamId = g.homeTeam
		JOIN teams TV ON TV.teamId = g.visitingTeam
	WHERE g.gameId = @gameId

END