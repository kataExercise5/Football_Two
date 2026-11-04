CREATE PROCEDURE [dbo].[ODDS_QUERY_BY_GAME]
	@gameId int,
	@teamId int = 0,
	@bookMakerId int = 0,
	@datePublished date = '1900-01-01',
	@betType varchar(20) = ''
AS
BEGIN
	SET NOCOUNT ON;
	select lines.linesByTeamId, lines.teamId, t.teamName
	,lines.bookMakerId ,B.bookieTitle ,lines.datePublished
	,lines.price ,lines.spread ,lines.betType
	,g.homeTeam, ISNULL(g.homeScore, 0) AS homeScore, g.visitingTeam, ISNULL(g.visitorScore, 0) AS visitorScore
	,ISNULL(lines.result, 0) as result
from games g
	join LinesByTeam lines on lines.gameId = g.gameId
	join teams t on t.teamId = lines.teamId
	JOIN BookMakers B ON B.bookMakerId = lines.bookMakerId
where g.gameId = @gameId
	and ((@teamId > 0 and lines.teamId = @teamId ) OR (@teamId = 0))
	and ((@bookMakerId > 0 and lines.bookMakerId = @bookMakerId ) OR (@bookMakerId = 0))
	and ((@datePublished > '1900-01-01' and lines.datePublished = @datePublished ) OR (@datePublished = '1900-01-01'))
	and ((@betType > '' and lines.betType = @betType ) OR (@betType = ''))
order by lines.teamId, lines.bookMakerId, lines.betType, lines.datePublished

END