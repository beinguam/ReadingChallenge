﻿CREATE TABLE [dbo].[UserBooks]
(
	[UserBookID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[BookID] int FOREIGN KEY REFERENCES Books([BookID]) NOT NULL,
	[UserID] int FOREIGN KEY REFERENCES Users([UserID]) NOT NULL
)
