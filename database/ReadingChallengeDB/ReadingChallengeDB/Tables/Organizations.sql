CREATE TABLE [dbo].[Organizations]
(
	[OrgID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [Category] INT FOREIGN KEY REFERENCES OrganizationCategories(OrganizationCategoryID) NULL
)
