CREATE PROCEDURE [dbo].[BOOKMAKERS_QUERY_OR_INSERT]
	@bookMakerKey NVARCHAR(32),
	@bookMakerTitle NVARCHAR(32),
	@bookMakerId int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT @bookMakerId = bookMakerId
	FROM BookMakers
	WHERE bookieKey = @bookMakerKey;
	
	if (@bookMakerId IS NULL)
		BEGIN
			INSERT INTO BookMakers (bookieKey, bookieTitle)
			VALUES (@bookMakerKey, @bookMakerTitle);

			SELECT @bookMakerId = SCOPE_IDENTITY();
		END
END
