CREATE TABLE [dbo].[Challenges]
(
	[challengeID] INT NOT NULL PRIMARY KEY, 
    [name] NCHAR(10) NOT NULL, 
    [beginDate] DATE NOT NULL, 
    [endDate] DATE NOT NULL, 
    [type] NCHAR(10) NOT NULL, 
    [numGoal] INT NOT NULL,
	[orgID] int FOREIGN KEY REFERENCES Organizations(orgID)
)
