CREATE TABLE [dbo].[Challenges]
(
	[challengeID] INT NOT NULL PRIMARY KEY, 
    [name] NCHAR(10) NOT NULL, 
    [beginDate] NCHAR(10) NOT NULL, 
    [endDate] NCHAR(10) NOT NULL, 
    [type] NCHAR(10) NOT NULL, 
    [numGoal] NCHAR(10) NOT NULL,
	[orgID] int FOREIGN KEY REFERENCES Organizations(orgID)
)
