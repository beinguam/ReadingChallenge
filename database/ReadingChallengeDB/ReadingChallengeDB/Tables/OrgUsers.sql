CREATE TABLE [dbo].[OrgUsers]
(
	[OrgUserID] INT NOT NULL PRIMARY KEY,
	[OrgID] int FOREIGN KEY REFERENCES Organizations([OrgID]),
	[ChallengeID] int FOREIGN KEY REFERENCES Challenges([ChallengeID])
)
