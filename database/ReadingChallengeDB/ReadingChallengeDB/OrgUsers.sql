CREATE TABLE [dbo].[OrgUsers]
(
	[orgUserID] INT NOT NULL PRIMARY KEY,
	[orgID] int FOREIGN KEY REFERENCES Organizations(orgID),
	[challengeID] int FOREIGN KEY REFERENCES Challenges(challengeID)
)
