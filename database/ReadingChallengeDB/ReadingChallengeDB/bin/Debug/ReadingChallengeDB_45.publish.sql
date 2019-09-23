﻿/*
Deployment script for ReadingChallengeDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ReadingChallengeDB"
:setvar DefaultFilePrefix "ReadingChallengeDB"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Rename refactoring operation with key d924baf2-1325-4662-8853-58962ef86b61 is skipped, element [dbo].[OrgUsers].[ChallengeID] (SqlSimpleColumn) will not be renamed to UserID';


GO
PRINT N'Rename refactoring operation with key e1d3c492-3d98-429e-b126-198a28d493d4 is skipped, element [dbo].[OrgUserChallenges].[UserID] (SqlSimpleColumn) will not be renamed to ChallengeID';


GO
PRINT N'Creating [dbo].[OrgUserChallenges]...';


GO
CREATE TABLE [dbo].[OrgUserChallenges] (
    [Id]          INT IDENTITY (1, 1) NOT NULL,
    [OrgUserID]   INT NOT NULL,
    [ChallengeID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[OrgUsers]...';


GO
CREATE TABLE [dbo].[OrgUsers] (
    [Id]     INT IDENTITY (1, 1) NOT NULL,
    [OrgID]  INT NOT NULL,
    [UserID] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges] WITH NOCHECK
    ADD FOREIGN KEY ([OrgUserID]) REFERENCES [dbo].[OrgUsers] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges] WITH NOCHECK
    ADD FOREIGN KEY ([ChallengeID]) REFERENCES [dbo].[Challenges] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers] WITH NOCHECK
    ADD FOREIGN KEY ([OrgID]) REFERENCES [dbo].[Organizations] ([Id]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers] WITH NOCHECK
    ADD FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([Id]);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd924baf2-1325-4662-8853-58962ef86b61')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d924baf2-1325-4662-8853-58962ef86b61')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e1d3c492-3d98-429e-b126-198a28d493d4')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e1d3c492-3d98-429e-b126-198a28d493d4')

GO

GO
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
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.OrgUserChallenges'), OBJECT_ID(N'dbo.OrgUsers'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO