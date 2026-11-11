CREATE FUNCTION [dbo].[GET_SPREAD_RESULTS]
(
	@SCHEDULE_YEAR INT,
	@SCHEDULE_WEEK INT,
	@SPREAD DECIMAL
)
RETURNS @Results table
(
	titleIdx int NOT NULL,
	bookMakerId int NOT NULL,
	resultAmt INT NULL
)

AS BEGIN
	
	WITH RESULTS_FUN 
	(title, titleIdx, bookMakerId, resultAmt)
	AS (
		select 'Home team favored' AS title, 1 as titleIdx, lines.bookMakerId as bookMakerId, sum(result) AS resultAmt
		from LinesByTeam lines
			join Games g on g.gameId = lines.gameId
		where lines.teamId = g.homeTeam and lines.betType = 'spreads'
			and g.scheduleYear = @SCHEDULE_YEAR
			and g.scheduleWeek = @SCHEDULE_WEEK
			and spread < 0 - @SPREAD
			AND lines.datePublished in
			(
				select max(datePublished) 
				from LinesByTeam lines 
				join games g on g.gameId = lines.gameId
				where g.scheduleYear = @SCHEDULE_YEAR and g.scheduleWeek = @SCHEDULE_WEEK
			)
		group by lines.bookMakerId, g.scheduleWeek
		
		UNION
	
		select 'Visiting team favored' AS title, 2 as titleIdx, lines.bookMakerId, sum(result) AS resultAmt
		from LinesByTeam lines
			join Games g on g.gameId = lines.gameId
		where lines.teamId = g.homeTeam and lines.betType = 'spreads'
			and g.scheduleYear = @SCHEDULE_YEAR
			and g.scheduleWeek = @SCHEDULE_WEEK
			and spread < 0 - @SPREAD
			AND lines.datePublished in
			(
				select max(datePublished) 
				from LinesByTeam lines 
				join games g on g.gameId = lines.gameId
				where g.scheduleYear = @SCHEDULE_YEAR and g.scheduleWeek = @SCHEDULE_WEEK
			)
		group by lines.bookMakerId, g.scheduleWeek

	UNION

	select 'Home team underdog' AS title, 3 as titleIdx, lines.bookMakerId, sum(result) AS resultAmt
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		where lines.teamId = g.homeTeam and lines.betType = 'spreads'
			and g.scheduleYear = @SCHEDULE_YEAR
			and g.scheduleWeek = @SCHEDULE_WEEK
			and spread < 0 - @SPREAD
			AND lines.datePublished in
			(
				select max(datePublished) 
				from LinesByTeam lines 
				join games g on g.gameId = lines.gameId
				where g.scheduleYear = @SCHEDULE_YEAR and g.scheduleWeek = @SCHEDULE_WEEK
			)
		group by lines.bookMakerId, g.scheduleWeek

	UNION
	
	select 'Visiting team underdog' AS title, 4 as titleIdx, lines.bookMakerId, sum(result) AS resultAmt
	from LinesByTeam lines
		join Games g on g.gameId = lines.gameId
		where lines.teamId = g.homeTeam and lines.betType = 'spreads'
			and g.scheduleYear = @SCHEDULE_YEAR
			and g.scheduleWeek = @SCHEDULE_WEEK
			and spread < 0 - @SPREAD
			AND lines.datePublished in
			(
				select max(datePublished) 
				from LinesByTeam lines 
				join games g on g.gameId = lines.gameId
				where g.scheduleYear = @SCHEDULE_YEAR and g.scheduleWeek = @SCHEDULE_WEEK
			)
		group by lines.bookMakerId, g.scheduleWeek
	)

	insert into @Results
	select titleIdx, bookMakerId, resultAmt
	from RESULTS_FUN;
	RETURN;
END