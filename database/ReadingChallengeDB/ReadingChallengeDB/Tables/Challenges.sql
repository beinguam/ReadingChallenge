CREATE TABLE [dbo].[Challenges]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NOT NULL, 
    [BeginDate] DATE NOT NULL, 
    [EndDate] DATE NOT NULL, 
    [Type] int FOREIGN KEY REFERENCES ChallengeTypes([Id]) NOT NULL,
    [NumGoal] INT NOT NULL,
	[OrgID] int FOREIGN KEY REFERENCES Organizations([Id]) NOT NULL
)
