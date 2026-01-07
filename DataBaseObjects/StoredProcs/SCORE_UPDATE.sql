CREATE PROCEDURE [dbo].[SCORE_UPDATE]
	@gameId int,
	@visitingTeamScore int,
	@homeTeamScore int
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE [dbo].[Games]
	SET visitorScore=@visitingTeamScore, homeScore=@homeTeamScore
	WHERE gameId=@gameId;

END