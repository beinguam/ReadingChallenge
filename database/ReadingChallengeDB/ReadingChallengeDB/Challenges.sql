CREATE TABLE [dbo].[Challenges]
(
	[challengeID] INT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(50) NOT NULL, 
    [beginDate] DATE NOT NULL, 
    [endDate] DATE NOT NULL, 
    [type] int FOREIGN KEY REFERENCES ChallengeTypes(challengeTypeID),
    [numGoal] INT NOT NULL,
	[orgID] int FOREIGN KEY REFERENCES Organizations(orgID)
)
