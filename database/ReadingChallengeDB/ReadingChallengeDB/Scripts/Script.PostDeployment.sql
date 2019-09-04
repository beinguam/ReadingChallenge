/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--Insert default challenge types
SET IDENTITY_INSERT ChallengeTypes ON 
GO     

MERGE INTO ReadingChallengeDB.dbo.ChallengeTypes AS Target 
USING (VALUES 
  (1, N'Text'), 
  (2, N'Audio'), 
  (3, N'Video')
) 
AS Source (Id, Name) 
ON Target.Id = Source.Id 

WHEN MATCHED THEN 
UPDATE SET Name = Source.Name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (Id, Name) 
VALUES (Id, Name);

SET IDENTITY_INSERT ChallengeTypes OFF 
GO

--Insert default Organization Categories
SET IDENTITY_INSERT OrganizationCategories ON 
GO     


MERGE INTO ReadingChallengeDB.dbo.OrganizationCategories AS Target 
USING (VALUES 
  (1, N'Church'), 
  (2, N'Company'), 
  (3, N'Organization'),
  (4, N'Group'),
  (5, N'Library'),
  (6, N'School')
) 
AS Source (Id, Name) 
ON Target.Id = Source.Id 

WHEN MATCHED THEN 
UPDATE SET Name = Source.Name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (Id, Name) 
VALUES (Id, Name);

SET IDENTITY_INSERT OrganizationCategories OFF 
GO

--Insert default Genres
SET IDENTITY_INSERT Genres ON 
GO     


MERGE INTO ReadingChallengeDB.dbo.Genres AS Target 
USING (VALUES 
  (1, N'Nonfiction'), 
  (2, N'Fiction')  
) 
AS Source (Id, Name) 
ON Target.Id = Source.Id 

WHEN MATCHED THEN 
UPDATE SET Name = Source.Name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (Id, Name) 
VALUES (Id, Name);

SET IDENTITY_INSERT Genres OFF 
GO

--***************COMMENT THIS OUT FOR PRODUCTION AS THIS IS JUST TEST DATAQ)*****************--
