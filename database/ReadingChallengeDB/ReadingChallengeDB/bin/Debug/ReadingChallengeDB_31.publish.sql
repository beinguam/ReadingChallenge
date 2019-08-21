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
    [AuthorID] INT           NOT NULL,
    [Name]     NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([AuthorID] ASC)
);


GO
PRINT N'Creating [dbo].[Books]...';


GO
CREATE TABLE [dbo].[Books] (
    [BookID] INT            NOT NULL,
    [Title]  NVARCHAR (MAX) NULL,
    [Author] NVARCHAR (MAX) NULL,
    [Pages]  INT            NULL,
    PRIMARY KEY CLUSTERED ([BookID] ASC)
);


GO
PRINT N'Creating [dbo].[Challenges]...';


GO
CREATE TABLE [dbo].[Challenges] (
    [ChallengeID] INT           NOT NULL,
    [Name]        NVARCHAR (50) NOT NULL,
    [BeginDate]   DATE          NOT NULL,
    [EndDate]     DATE          NOT NULL,
    [Type]        INT           NULL,
    [NumGoal]     INT           NOT NULL,
    [OrgID]       INT           NULL,
    PRIMARY KEY CLUSTERED ([ChallengeID] ASC)
);


GO
PRINT N'Creating [dbo].[ChallengeTypes]...';


GO
CREATE TABLE [dbo].[ChallengeTypes] (
    [ChallengeTypeID] INT           IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([ChallengeTypeID] ASC)
);


GO
PRINT N'Creating [dbo].[Genres]...';


GO
CREATE TABLE [dbo].[Genres] (
    [GenreID] INT            NOT NULL,
    [Name]    NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([GenreID] ASC)
);


GO
PRINT N'Creating [dbo].[OrganizationCategories]...';


GO
CREATE TABLE [dbo].[OrganizationCategories] (
    [OrganizationCategoryID] INT           IDENTITY (1, 1) NOT NULL,
    [Name]                   NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([OrganizationCategoryID] ASC)
);


GO
PRINT N'Creating [dbo].[Organizations]...';


GO
CREATE TABLE [dbo].[Organizations] (
    [OrgID]    INT           NOT NULL,
    [Name]     NVARCHAR (50) NOT NULL,
    [Category] INT           NULL,
    PRIMARY KEY CLUSTERED ([OrgID] ASC)
);


GO
PRINT N'Creating [dbo].[OrgUserChallenges]...';


GO
CREATE TABLE [dbo].[OrgUserChallenges] (
    [OrgUserChallengeID] INT NOT NULL,
    [OrgUserID]          INT NULL,
    [UserID]             INT NULL,
    PRIMARY KEY CLUSTERED ([OrgUserChallengeID] ASC)
);


GO
PRINT N'Creating [dbo].[OrgUsers]...';


GO
CREATE TABLE [dbo].[OrgUsers] (
    [OrgUserID]   INT NOT NULL,
    [OrgID]       INT NULL,
    [ChallengeID] INT NULL,
    PRIMARY KEY CLUSTERED ([OrgUserID] ASC)
);


GO
PRINT N'Creating [dbo].[UserBooks]...';


GO
CREATE TABLE [dbo].[UserBooks] (
    [UserBookID] INT NOT NULL,
    [BookID]     INT NULL,
    [UserID]     INT NULL,
    PRIMARY KEY CLUSTERED ([UserBookID] ASC)
);


GO
PRINT N'Creating [dbo].[Users]...';


GO
CREATE TABLE [dbo].[Users] (
    [UserID]    INT           NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [LastName]  NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Challenges]...';


GO
ALTER TABLE [dbo].[Challenges]
    ADD FOREIGN KEY ([Type]) REFERENCES [dbo].[ChallengeTypes] ([ChallengeTypeID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Challenges]...';


GO
ALTER TABLE [dbo].[Challenges]
    ADD FOREIGN KEY ([OrgID]) REFERENCES [dbo].[Organizations] ([OrgID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges]
    ADD FOREIGN KEY ([OrgUserID]) REFERENCES [dbo].[OrgUsers] ([OrgUserID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUserChallenges]...';


GO
ALTER TABLE [dbo].[OrgUserChallenges]
    ADD FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers]
    ADD FOREIGN KEY ([OrgID]) REFERENCES [dbo].[Organizations] ([OrgID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[OrgUsers]...';


GO
ALTER TABLE [dbo].[OrgUsers]
    ADD FOREIGN KEY ([ChallengeID]) REFERENCES [dbo].[Challenges] ([ChallengeID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[UserBooks]...';


GO
ALTER TABLE [dbo].[UserBooks]
    ADD FOREIGN KEY ([BookID]) REFERENCES [dbo].[Books] ([BookID]);


GO
PRINT N'Creating unnamed constraint on [dbo].[UserBooks]...';


GO
ALTER TABLE [dbo].[UserBooks]
    ADD FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


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
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c53d8125-f462-4207-b904-03b0b4cb8675')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c53d8125-f462-4207-b904-03b0b4cb8675')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c55675b8-206f-44e1-9557-af09f20b6256')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c55675b8-206f-44e1-9557-af09f20b6256')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9bc9ec4a-1f4f-4659-973c-99a0d45ce279')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9bc9ec4a-1f4f-4659-973c-99a0d45ce279')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e0e493b6-746b-4709-8f53-8f04a50ec07a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e0e493b6-746b-4709-8f53-8f04a50ec07a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '83cf047b-664d-4386-ab1e-0ae215af4cd1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('83cf047b-664d-4386-ab1e-0ae215af4cd1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '017e3336-28bb-45e0-b278-03b1a62a2c03')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('017e3336-28bb-45e0-b278-03b1a62a2c03')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '70899428-4409-475d-9f44-6cfdc070eec8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('70899428-4409-475d-9f44-6cfdc070eec8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9b50611c-3d22-4a62-96cd-a1b902bc8ae6')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9b50611c-3d22-4a62-96cd-a1b902bc8ae6')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '70a4a076-967b-4163-9d8e-d7a3c908b135')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('70a4a076-967b-4163-9d8e-d7a3c908b135')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e61a6d2a-5ff1-4776-a02d-6f588438a649')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e61a6d2a-5ff1-4776-a02d-6f588438a649')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8594d051-af8f-4de2-87e8-b97ca940bb16')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8594d051-af8f-4de2-87e8-b97ca940bb16')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '360c44d1-099d-42e1-95d4-4a3642aac6f3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('360c44d1-099d-42e1-95d4-4a3642aac6f3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '066b5d62-895d-48c1-b19e-8124ec364240')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('066b5d62-895d-48c1-b19e-8124ec364240')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '49d336c8-3d19-4e9d-8eda-aec488f87427')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('49d336c8-3d19-4e9d-8eda-aec488f87427')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e7ffe963-662e-4b31-bf9a-c3105002e138')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e7ffe963-662e-4b31-bf9a-c3105002e138')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7f9e9d26-a4a6-4f84-b4c1-05eecd5eba31')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7f9e9d26-a4a6-4f84-b4c1-05eecd5eba31')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1e18f629-3f90-483b-ab14-5a3c863033ff')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1e18f629-3f90-483b-ab14-5a3c863033ff')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f8f83097-375f-4ebd-9013-f07e99ab2a7b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f8f83097-375f-4ebd-9013-f07e99ab2a7b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e7dc33d1-9fd2-427c-9dd3-09ff41a33899')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e7dc33d1-9fd2-427c-9dd3-09ff41a33899')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'e59940c2-ab40-40c7-9439-0d9a4ca97dc9')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('e59940c2-ab40-40c7-9439-0d9a4ca97dc9')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4ada1e06-32b1-429f-9e48-addf382e4ccd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4ada1e06-32b1-429f-9e48-addf382e4ccd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'beb273f1-81bf-4b32-a301-f934f64714ce')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('beb273f1-81bf-4b32-a301-f934f64714ce')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '300724f7-d38e-479d-9d20-e2ea4a99924a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('300724f7-d38e-479d-9d20-e2ea4a99924a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a15a2676-229d-495d-a96f-0ff9705961b2')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a15a2676-229d-495d-a96f-0ff9705961b2')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a90b81ae-4557-4d69-a352-35fe041497bc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a90b81ae-4557-4d69-a352-35fe041497bc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a7a5613e-13e7-4fdc-b005-1bb40f9da167')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a7a5613e-13e7-4fdc-b005-1bb40f9da167')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c426a7e6-9078-4b43-b865-14b143e04feb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c426a7e6-9078-4b43-b865-14b143e04feb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f90b15c1-b08f-4e98-98a5-570c060a1805')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f90b15c1-b08f-4e98-98a5-570c060a1805')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '73414a0c-f7cc-4c7f-91d2-5b3e5dfa7aea')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('73414a0c-f7cc-4c7f-91d2-5b3e5dfa7aea')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '319db392-8aa9-48cb-a2c4-e38853786f3d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('319db392-8aa9-48cb-a2c4-e38853786f3d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '54c01669-6208-4364-8c45-3bd29df45843')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('54c01669-6208-4364-8c45-3bd29df45843')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0f3cdea4-2b8c-4e9a-86b7-93004f3b6925')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0f3cdea4-2b8c-4e9a-86b7-93004f3b6925')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9946a99d-6475-499e-8599-2712a2e3164d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9946a99d-6475-499e-8599-2712a2e3164d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '956e5487-8c8f-4eed-b318-c68981a29bcd')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('956e5487-8c8f-4eed-b318-c68981a29bcd')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '65e1cb4d-9d1e-4692-bd65-4adee28f696b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('65e1cb4d-9d1e-4692-bd65-4adee28f696b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b0eba59a-dba1-42b0-9e90-64fdae1b27f3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b0eba59a-dba1-42b0-9e90-64fdae1b27f3')

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
AS Source (challengeTypeID, name) 
ON Target.challengeTypeID = Source.challengeTypeID 

WHEN MATCHED THEN 
UPDATE SET name = Source.name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (challengeTypeID, name) 
VALUES (challengeTypeID, name);

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
AS Source (OrganizationCategoryID, name) 
ON Target.OrganizationCategoryID = Source.OrganizationCategoryID 

WHEN MATCHED THEN 
UPDATE SET name = Source.name

WHEN NOT MATCHED BY TARGET THEN 
INSERT (OrganizationCategoryID, name) 
VALUES (OrganizationCategoryID, name);

SET IDENTITY_INSERT OrganizationCategories OFF 
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
