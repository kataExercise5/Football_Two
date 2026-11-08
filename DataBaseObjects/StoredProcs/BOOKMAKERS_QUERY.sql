CREATE PROCEDURE [dbo].[BOOKMAKERS_QUERY]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT bookMakerId, bookieKey, bookieTitle
	FROM BookMakers
	ORDER BY bookieTitle;
END