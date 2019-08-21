CREATE TABLE [dbo].[OrgUserChallenges]
(
	[OrgUserChallengeID] INT NOT NULL PRIMARY KEY,
	[OrgUserID] int FOREIGN KEY REFERENCES OrgUsers([OrgUserID]),
	[UserID] int FOREIGN KEY REFERENCES Users([UserID])
)
