CREATE TABLE [dbo].[Games](
	[gameId] [int] IDENTITY(1,1) NOT NULL,
	[visitingTeam] [int] NOT NULL,
	[homeTeam] [int] NOT NULL,
	[stadium] [bit] NOT NULL,
	[datePlayed] [date] NOT NULL,
	[dayOfWeekPlayed] [smallint] NOT NULL,
	[visitorScore] [smallint] NULL,
	[homeScore] [smallint] NULL,
	[scheduleYear] [smallint] NULL,
	[scheduleWeek] [smallint] NOT NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[gameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]