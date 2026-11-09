CREATE PROCEDURE [dbo].[SPREAD_RESULTS_BY_BOOKIE]
	@scheduledYear int,
	@scheduledWeek int,
	@datePublished Date,
	@spread int = 0
AS
BEGIN
	SET NOCOUNT ON;

	select 'Home team favored' AS title, 1 as titleIdx, b.bookieTitle as bookMaker, sum(result) AS result 
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		join BookMakers b on b.bookMakerId = lines.bookMakerId
	where g.scheduleYear = 2026 and g.scheduleWeek = 8
		and lines.teamId = g.homeTeam and lines.betType = 'spreads'
		and spread > @spread
	group by b.bookieTitle

	UNION
	
	select 'Visiting team favored' AS title, 2 as titleIdx, b.bookieTitle as bookMaker, sum(result) AS result
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		join BookMakers b on b.bookMakerId = lines.bookMakerId
	where g.scheduleYear = 2026 and g.scheduleWeek = 8
		and lines.teamId = g.visitingTeam and lines.betType = 'spreads'
		and spread > @spread
	group by b.bookieTitle

	UNION

	select 'Home team underdog' AS title, 3 as titleIdx, b.bookieTitle as bookMaker, sum(result) AS result
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		join BookMakers b on b.bookMakerId = lines.bookMakerId
	where g.scheduleYear = 2026 and g.scheduleWeek = 8
		and lines.teamId = g.homeTeam and lines.betType = 'spreads'
		and spread < @spread
	group by b.bookieTitle

	UNION
	
	select 'Visiting team underdog' AS title, 4 as titleIdx, b.bookieTitle as bookMaker, sum(result) AS result
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		join BookMakers b on b.bookMakerId = lines.bookMakerId
	where g.scheduleYear = 2026 and g.scheduleWeek = 8
		and lines.teamId = g.visitingTeam and lines.betType = 'spreads'
		and spread < @spread
	group by b.bookieTitle

	order by  bookMaker, titleIdx

END