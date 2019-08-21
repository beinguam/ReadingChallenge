CREATE TABLE [dbo].[OrgUsers]
(
	[OrgUserID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[OrgID] int FOREIGN KEY REFERENCES Organizations([OrgID]) NOT NULL,
	[ChallengeID] int FOREIGN KEY REFERENCES Challenges([ChallengeID]) NOT NULL
)
