CREATE PROCEDURE [dbo].[ODDS_QUERY_BY_GAME]
	@gameId int
AS
BEGIN
	SET NOCOUNT ON;
	select lines.linesByTeamId, lines.teamId, t.teamName
	,lines.bookMakerId ,B.bookieTitle ,lines.datePublished
	,lines.price ,lines.spread ,lines.betType
from games g
	join LinesByTeam lines on lines.gameId = g.gameId
	join teams t on t.teamId = lines.teamId
  JOIN BookMakers B ON B.bookMakerId = lines.bookMakerId
where g.gameId = @gameId
order by lines.teamId, lines.bookMakerId, lines.betType, lines.datePublished

END