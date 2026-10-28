CREATE PROCEDURE [dbo].[SCHEDULE_WEEKS_QUERY]
	@scheduleYear int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT SW.ScheduleYear, SW.ScheduleWeek, SW.StartDate, SW.EndDate
	FROM ScheduleWeeks SW
	WHERE SW.ScheduleYear = @scheduleYear
	ORDER BY SW.ScheduleWeek

END