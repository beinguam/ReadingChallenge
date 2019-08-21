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

MERGE INTO ReadingChallengeDB.dbo.ChallengeTypes AS Target 
USING (VALUES 
  (1, N'Text'), 
  (2, N'Audio'), 
  (3, N'Video')
) 
AS Source (challengeTypeID, name) 
ON Target.challengeTypeID = Source.challengeTypeID 

WHEN MATCHED THEN 
UPDATE SET name = Source.name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (challengeTypeID, name) 
VALUES (challengeTypeID, name);