CREATE TABLE [dbo].[Organizations]
(
	[orgID] INT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(50) NOT NULL, 
    [category] NVARCHAR(50) NULL
)
