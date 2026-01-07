CREATE PROCEDURE [dbo].[SCHEDULE_WEEKS_QUERY]
	@scheduleYear int = 0
AS
BEGIN
	SET NOCOUNT ON;

	IF (@scheduleYear = 0)
		BEGIN
			SELECT @scheduleYear = DATEPART(year, getdate());
		END

	SELECT SW.ScheduleYear, SW.ScheduleWeek, SW.StartDate, SW.EndDate
	FROM ScheduleWeeks SW
	WHERE SW.ScheduleYear = @scheduleYear
	ORDER BY SW.ScheduleWeek

END
