CREATE PROCEDURE [dbo].[HEAD_2_HEAD_RESULTS_BY_BOOKIE]
	@scheduledYear int,
	@scheduledWeek int,
	@datePublished Date,
	@price int = 0
AS
BEGIN
	SET NOCOUNT ON;

select 'H2H Home team' as title, 1 as titleIdx, b.bookieTitle as bookieName, sum(result) AS result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.homeTeam and lines.betType = 'h2h'
	and lines.datePublished = @datePublished
group by b.bookieTitle

UNION

select 'H2H Visiting team' as title, 2 as titleIdx, b.bookieTitle as bookieName, sum(result) as result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.visitingTeam and lines.betType = 'h2h'
	and lines.datePublished = @datePublished
group by b.bookieTitle

UNION

select 'H2H Home team favored' as title, 3 as titleIdx, b.bookieTitle as bookieName, sum(result) as result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.homeTeam and lines.betType = 'h2h'
	and price > @price
	and lines.datePublished = @datePublished
group by b.bookieTitle

UNION

select 'H2H Visiting team favored' as title, 4 as titleIdx, b.bookieTitle as bookieName, sum(result) as result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.visitingTeam and lines.betType = 'h2h'
	and price > @price
	and lines.datePublished = @datePublished
group by b.bookieTitle

UNION

select 'H2H Home team underdog' as title, 5 as titleIdx, b.bookieTitle as bookieName, sum(result) as result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.homeTeam and lines.betType = 'h2h'
	and price < @price
	and lines.datePublished = @datePublished
group by b.bookieTitle

UNION

select 'H2H Visiting team underdog' as title, 6 as titleIdx, b.bookieTitle as bookieName, sum(result) as result
from LinesByTeam lines
join Games g on g.gameId = lines.gameId
join BookMakers b on b.bookMakerId = lines.bookMakerId
where g.scheduleYear = @scheduledYear and g.scheduleWeek = @scheduledWeek
	and lines.teamId = g.visitingTeam and lines.betType = 'h2h'
	and price < @price
	and lines.datePublished = @datePublished
group by b.bookieTitle

order by bookieName, titleIdx

END