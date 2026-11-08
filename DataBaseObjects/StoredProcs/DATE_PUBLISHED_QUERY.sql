CREATE PROCEDURE [dbo].[DATE_PUBLISHED_QUERY]
	@scheduleYear int,
	@scheduleWeek int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT(datePublished) as datePub
	FROM games g
		JOIN LinesByTeam lines ON lines.gameId = g.gameId
	WHERE g.scheduleYear = @scheduleYear and g.scheduleWeek = @scheduleWeek
	ORDER BY datePublished

END