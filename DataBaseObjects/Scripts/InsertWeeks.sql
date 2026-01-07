USE [Football]
GO

--DELETE SCHEDULEWEEKS

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 10, '2025-11-06', '2025-11-10')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 11, '2025-11-13', '2025-11-17')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 12, '2025-11-20', '2025-11-24')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 13, '2025-11-27', '2025-11-10')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 14, '2025-12-04', '2025-12-08')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 15, '2025-12-11', '2025-12-15')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 16, '2025-12-18', '2025-12-23')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 17, '2025-12-25', '2025-12-30')

INSERT INTO [dbo].[ScheduleWeeks]
	([ScheduleYear], [ScheduleWeek], [StartDate], [EndDate])
VALUES (2025, 18, '2026-01-01', '2026-01-05')

SELECT * FROM SCHEDULEWEEKS


