CREATE PROCEDURE [dbo].[SPREAD_RESULTS_BY_BOOKIE_BY_WEEK]
	@scheduledYear int=2026,
	@scheduledWeekStart int = 8,
	@scheduledWeekEnd int = 9,
	@spread int = 0
AS
BEGIN
	SET NOCOUNT ON;

	declare @queryWeek int = @scheduledWeekStart;

	delete Results;

	while (@queryWeek <= @scheduledWeekEnd)
	begin
		insert into Results (titleIdx, bookMakerId, scheduledWeek, result)
		SELECT titleIdx, a.bookMakerId, @queryWeek, resultAmt
		FROM DBO.GET_SPREAD_RESULTS(@scheduledYear, @queryWeek, @spread) a
		join BookMakers b on b.bookMakerId = a.bookMakerId
		set @queryWeek = @queryWeek + 1;
	end

	select r.titleIdx, b.bookieTitle, scheduledWeek, result
	from results r
	join BookMakers b on b.bookMakerId = r.bookMakerId
	order by titleIdx, b.bookieTitle, scheduledWeek

END