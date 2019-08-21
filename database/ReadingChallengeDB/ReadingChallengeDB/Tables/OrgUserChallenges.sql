CREATE TABLE [dbo].[OrgUserChallenges]
(
	[OrgUserChallengeID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[OrgUserID] int FOREIGN KEY REFERENCES OrgUsers([OrgUserID]) NOT NULL,
	[UserID] int FOREIGN KEY REFERENCES Users([UserID]) NOT NULL
)
