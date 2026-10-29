CREATE TABLE [dbo].[ScheduleWeeks](
	[ScheduleYear] [int] NOT NULL,
	[ScheduleWeek] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_ScheduleWeek] PRIMARY KEY CLUSTERED 
(
	[ScheduleYear] ASC,
	[ScheduleWeek] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]