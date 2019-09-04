CREATE TABLE [dbo].[Organizations]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [Category] INT FOREIGN KEY REFERENCES OrganizationCategories([Id]) NULL
)
