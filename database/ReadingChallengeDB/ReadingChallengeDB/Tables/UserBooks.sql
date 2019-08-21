CREATE TABLE [dbo].[UserBooks]
(
	[UserBookID] INT NOT NULL PRIMARY KEY,
	[BookID] int FOREIGN KEY REFERENCES Books([BookID]),
	[UserID] int FOREIGN KEY REFERENCES Users([UserID])
)
