﻿CREATE TABLE [dbo].[OrgUsers]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[OrgID] int FOREIGN KEY REFERENCES Organizations([Id]) NOT NULL,
	[UserID] int FOREIGN KEY REFERENCES Users([Id]) NOT NULL
)
