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
/*
The type for column lname in table [dbo].[Users] is currently  NCHAR (50) NULL but is being changed to  NUMERIC (18) NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Users])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering [dbo].[Authors]...';


GO
ALTER TABLE [dbo].[Authors] ALTER COLUMN [name] NVARCHAR (50) NULL;


GO
PRINT N'Altering [dbo].[Books]...';


GO
ALTER TABLE [dbo].[Books] ALTER COLUMN [author] NVARCHAR (MAX) NULL;

ALTER TABLE [dbo].[Books] ALTER COLUMN [title] NVARCHAR (MAX) NULL;


GO
PRINT N'Altering [dbo].[Challenges]...';


GO
ALTER TABLE [dbo].[Challenges] ALTER COLUMN [name] NVARCHAR (50) NOT NULL;

ALTER TABLE [dbo].[Challenges] ALTER COLUMN [type] NVARCHAR (50) NOT NULL;


GO
PRINT N'Altering [dbo].[Genres]...';


GO
ALTER TABLE [dbo].[Genres] ALTER COLUMN [name] NVARCHAR (MAX) NULL;


GO
PRINT N'Altering [dbo].[Users]...';


GO
ALTER TABLE [dbo].[Users] ALTER COLUMN [fname] NVARCHAR (50) NOT NULL;

ALTER TABLE [dbo].[Users] ALTER COLUMN [lname] NUMERIC (18) NULL;


GO
PRINT N'Update complete.';


GO
