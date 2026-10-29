CREATE TABLE [dbo].[LinesByTeam](
	[linesByTeamId] [int] IDENTITY(1,1) NOT NULL,
	[teamId] [int] NOT NULL,
	[gameId] [int] NOT NULL,
	[bookMakerId] [int] NOT NULL,
	[datePublished] [date] NOT NULL,
	[price] [smallint] NOT NULL,
	[spread] [decimal](3, 1) NULL,
	[betType] [varchar](20) NULL,
 CONSTRAINT [PK_LinesByTeam] PRIMARY KEY CLUSTERED 
(
	[linesByTeamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LinesByTeam] ADD  DEFAULT ('unknown') FOR [betType]
GO