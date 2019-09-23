CREATE TABLE [dbo].[OrgUserChallenges]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[OrgUserID] int FOREIGN KEY REFERENCES OrgUsers([Id]) NOT NULL,
	[ChallengeID] int FOREIGN KEY REFERENCES Challenges([Id]) NOT NULL
)
