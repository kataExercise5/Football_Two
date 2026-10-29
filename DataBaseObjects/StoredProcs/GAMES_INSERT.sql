CREATE PROCEDURE [dbo].[GAMES_INSERT]
	@homeTeamName NVARCHAR(32),
	@visitorTeamName NVARCHAR(32),
	@datePlayed date,
	@dayOfWeekPlayed smallint,
	@gameId int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @homeTeamId int, @visitorTeamId int;
	select @homeTeamId = teamId from Teams where teamName = @homeTeamName;
	select @visitorTeamId = teamId from Teams where teamName = @visitorTeamName;

	DECLARE @scheduleWeek smallint = -1;
	declare @scheduleYear smallint = -1;
	select @scheduleYear=sw.ScheduleYear, @scheduleWeek = sw.ScheduleWeek from scheduleweeks sw
	where @datePlayed between sw.startdate and sw.enddate;


	
	INSERT INTO [dbo].[Games]
	(
		visitingTeam, homeTeam, stadium, datePlayed, dayOfWeekPlayed, 
		visitorScore, homeScore, scheduleYear, scheduleWeek
	)
	VALUES
	(
		@visitorTeamId, @homeTeamId, 0, @datePlayed, @dayOfWeekPlayed,
		null, null, @scheduleYear, @scheduleWeek
	)

	SELECT @gameId = SCOPE_IDENTITY();

END