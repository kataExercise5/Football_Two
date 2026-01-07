CREATE PROCEDURE [dbo].[LINES_BY_TEAM_INSERT]
	@gameId int,
	@bookMakerId int,
	@betType NVARCHAR(16),
	@teamName NVARCHAR(32),
	@datePublished date,
	@price smallint,
	@spread decimal(3,1)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @teamId int;
	select @teamId = teamId from Teams where teamName = @teamName;

	DECLARE @betTypeCode smallint = 1;

	
	INSERT INTO [dbo].[LinesByTeam]
	(
		[teamId]
		,[gameId]
		,[bookMakerId]
		,[betType]
		,[datePublished]
		,[price]
		,[spread]
	)
	VALUES
	(
		@teamId,
		@gameId,
		@bookMakerId,
		@betTypeCode,
		@datePublished,
		@price,
		@spread
	)

END
