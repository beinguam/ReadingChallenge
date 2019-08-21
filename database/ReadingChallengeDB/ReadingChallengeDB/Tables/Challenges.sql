CREATE TABLE [dbo].[Challenges]
(
	[ChallengeID] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [BeginDate] DATE NOT NULL, 
    [EndDate] DATE NOT NULL, 
    [Type] int FOREIGN KEY REFERENCES ChallengeTypes([ChallengeTypeID]),
    [NumGoal] INT NOT NULL,
	[OrgID] int FOREIGN KEY REFERENCES Organizations([OrgID])
)
