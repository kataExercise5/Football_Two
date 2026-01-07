CREATE PROCEDURE [dbo].[GAME_QUERY]
	@scheduleWeek int = 99
AS
BEGIN
	SET NOCOUNT ON;
	--selects all games for the selected week #
	SELECT
		G.gameId, 
		G.visitingTeam as visitingTeamId, TV.teamName visitingTeamName,
		G.homeTeam as homeTeamId, TH.teamName as homeTeamName,
		G.stadium, G.datePlayed, G.dayOfWeek, 
		G.visitorScore as visitingTeamScore, G.homeScore as homeTeamScore,
		G.week as scheduleWeek
	FROM games g
		JOIN teams TH ON TH.teamId = g.homeTeam
		JOIN teams TV ON TV.teamId = g.visitingTeam
	WHERE G.week = @scheduleWeek

END
