CREATE TABLE [dbo].[orgUserChallenges]
(
	[orgUserChallengeID] INT NOT NULL PRIMARY KEY,
	[orgUserID] int FOREIGN KEY REFERENCES OrgUsers(orgUserID),
	[userID] int FOREIGN KEY REFERENCES Users(userID)
)
