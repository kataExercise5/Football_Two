CREATE TABLE [dbo].[Games2](
	[gameId] [int] IDENTITY(1,1) NOT NULL,
	[stadium] [bit] NOT NULL,
	[datePlayed] [date] NOT NULL,
	[dayOfWeekPlayed] [smallint] NOT NULL,
	[scheduleYear] [smallint] NULL,
	[scheduleWeek] [smallint] NOT NULL,
 CONSTRAINT [PK_Games2] PRIMARY KEY CLUSTERED 
(
	[gameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]