CREATE TABLE [dbo].[Organizations]
(
	[orgID] INT NOT NULL PRIMARY KEY, 
    [name] NCHAR(50) NOT NULL, 
    [category] NCHAR(10) NULL
)
