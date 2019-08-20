CREATE TABLE [dbo].[Challenges]
(
	[challengeID] INT NOT NULL PRIMARY KEY, 
    [name] NVARCHAR(50) NOT NULL, 
    [beginDate] DATE NOT NULL, 
    [endDate] DATE NOT NULL, 
    [type] NVARCHAR(50) NOT NULL, 
    [numGoal] INT NOT NULL,
	[orgID] int FOREIGN KEY REFERENCES Organizations(orgID)
)
