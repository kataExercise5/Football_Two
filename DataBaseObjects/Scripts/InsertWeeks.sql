declare @season_year int = 2026;
declare @season_start_date date = '2026-09-10';
declare @week int = 1;
declare @endWeek int = 17;
declare @scheduleWeekStartDate date;

delete ScheduleWeeks where ScheduleYear = @season_year;

set @scheduleWeekStartDate = @season_start_date;
while @week <= @endWeek
	begin
		insert into ScheduleWeeks (ScheduleYear, ScheduleWeek, StartDate, EndDate)
			values (@season_year, @week, @scheduleWeekStartDate, DATEADD(day, 4, @scheduleWeekStartDate));
		set @week = @week + 1;
		set @scheduleWeekStartDate = DATEADD(day, 7, @scheduleWeekStartDate);
	end