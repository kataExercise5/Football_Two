CREATE PROCEDURE [dbo].[GAME_QUERY]
	@scheduleYear int,
	@scheduleWeek int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		G.gameId, 
		G.visitingTeam as visitingTeamId, TV.teamName visitingTeamName,
		G.homeTeam as homeTeamId, TH.teamName as homeTeamName,
		G.stadium, G.datePlayed, G.dayOfWeekPlayed, 
		G.visitorScore as visitingTeamScore, G.homeScore as homeTeamScore
	FROM games g
		JOIN teams TH ON TH.teamId = g.homeTeam
		JOIN teams TV ON TV.teamId = g.visitingTeam
	WHERE g.scheduleYear = @scheduleYear and G.scheduleWeek = @scheduleWeek

END