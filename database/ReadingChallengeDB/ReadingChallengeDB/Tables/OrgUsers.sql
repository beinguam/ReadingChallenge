﻿CREATE TABLE [dbo].[OrgUsers]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[OrgID] int FOREIGN KEY REFERENCES Organizations([Id]) NOT NULL,
	[ChallengeID] int FOREIGN KEY REFERENCES Challenges([Id]) NOT NULL
)
