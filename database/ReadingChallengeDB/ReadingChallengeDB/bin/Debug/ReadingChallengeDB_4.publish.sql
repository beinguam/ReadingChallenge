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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Authors]...';


GO
CREATE TABLE [dbo].[Authors] (
    [authorID] INT        NOT NULL,
    [name]     NCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([authorID] ASC)
);


GO
PRINT N'Creating [dbo].[Books]...';


GO
CREATE TABLE [dbo].[Books] (
    [bookID] INT         NOT NULL,
    [title]  NCHAR (255) NULL,
    [author] NCHAR (255) NULL,
    [pages]  INT         NULL,
    PRIMARY KEY CLUSTERED ([bookID] ASC)
);


GO
PRINT N'Creating [dbo].[Challenges]...';


GO
CREATE TABLE [dbo].[Challenges] (
    [challengeID] INT        NOT NULL,
    [name]        NCHAR (10) NOT NULL,
    [beginDate]   DATE       NOT NULL,
    [endDate]     DATE       NOT NULL,
    [type]        NCHAR (10) NOT NULL,
    [numGoal]     INT        NOT NULL,
    [orgID]       INT        NULL,
    PRIMARY KEY CLUSTERED ([challengeID] ASC)
);


GO
PRINT N'Creating [dbo].[Genres]...';


GO
CREATE TABLE [dbo].[Genres] (
    [genreID] INT         NOT NULL,
    [name]    NCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([genreID] ASC)
);


GO
PRINT N'Creating [dbo].[Organizations]...';


GO
CREATE TABLE [dbo].[Organizations] (
    [orgID]    INT        NOT NULL,
    [name]     NCHAR (50) NOT NULL,
    [category] NCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([orgID] ASC)
);


GO
PRINT N'Creating [dbo].[OrgUserChallenges]...';


GO
CREATE TABLE [dbo].[OrgUserChallenges] (
    [orgUserChallengeID] INT NOT NULL,
    [orgUserID]          INT NULL,
    [userID]             INT NULL,
    PRIMARY KEY CLUSTERED ([orgUserChallengeID] ASC)
);


GO
PRINT N'Creating [dbo].[OrgUsers]...';


GO
CREATE TABLE [dbo].[OrgUsers] (
    [orgUserID]   INT NOT NULL,
    [orgID]       INT NULL,
    [challengeID] INT NULL,
    PRIMARY KEY CLUSTERED ([orgUserID] ASC)
);


GO
PRINT N'Creating [dbo].[UserBooks]...';


GO
CREATE TABLE [dbo].[UserBooks] (
    [userBookID] INT NOT NULL,
    [bookID]     INT NULL,
    [userID]     INT NULL,
    PRIMARY KEY CLUSTERED ([userBookID] ASC)
);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [userID] INT        NOT NULL,
    [fname]  NCHAR (50) NOT NULL,
    [lname]  NCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([userID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Challenges]...';


GO
ALTER TABLE [dbo].[Challenges]
    ADD FOREIGN KEY ([orgID]) REFERENCES [dbo].[Organizations] ([orgID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges]
    ADD FOREIGN KEY ([orgUserID]) REFERENCES [dbo].[OrgUsers] ([orgUserID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges]
    ADD FOREIGN KEY ([userID]) REFERENCES [dbo].[Users] ([userID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers]
    ADD FOREIGN KEY ([orgID]) REFERENCES [dbo].[Organizations] ([orgID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers]
    ADD FOREIGN KEY ([challengeID]) REFERENCES [dbo].[Challenges] ([challengeID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[UserBooks]...';


GO
ALTER TABLE [dbo].[UserBooks]
    ADD FOREIGN KEY ([bookID]) REFERENCES [dbo].[Books] ([bookID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[UserBooks]...';


GO
ALTER TABLE [dbo].[UserBooks]
    ADD FOREIGN KEY ([userID]) REFERENCES [dbo].[Users] ([userID]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ac66c300-da11-480a-b15b-560ec066a0d1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ac66c300-da11-480a-b15b-560ec066a0d1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '111a1262-e469-460d-b73f-674725806e46')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('111a1262-e469-460d-b73f-674725806e46')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd053d45c-4ab2-46be-88a0-abf757c97844')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d053d45c-4ab2-46be-88a0-abf757c97844')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9692f8f4-eb51-4de8-9243-3587f9af88a9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9692f8f4-eb51-4de8-9243-3587f9af88a9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '99504e63-b01f-4803-bbf1-4d3501f5bba1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('99504e63-b01f-4803-bbf1-4d3501f5bba1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3d72cf47-f1c5-4607-9242-de0e28732944')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3d72cf47-f1c5-4607-9242-de0e28732944')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '50e78c4d-4701-4ce9-affc-c0dd5c068ac9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('50e78c4d-4701-4ce9-affc-c0dd5c068ac9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e7f8ceda-76c3-4b08-9200-586f635ea696')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e7f8ceda-76c3-4b08-9200-586f635ea696')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO