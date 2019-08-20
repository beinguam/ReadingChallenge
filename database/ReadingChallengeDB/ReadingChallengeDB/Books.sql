CREATE TABLE [dbo].[Books]
(
	[bookID] INT NOT NULL PRIMARY KEY, 
    [title] NVARCHAR(MAX) NULL, 
    [author] NVARCHAR(MAX) NULL, 
    [pages] INT NULL
)
