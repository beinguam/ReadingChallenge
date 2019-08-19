CREATE TABLE [dbo].[UserBooks]
(
	[userBookID] INT NOT NULL PRIMARY KEY,
	[bookID] int FOREIGN KEY REFERENCES Books(bookID),
	[userID] int FOREIGN KEY REFERENCES Users(userID)
)
