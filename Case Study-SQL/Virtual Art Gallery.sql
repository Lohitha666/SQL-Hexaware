-- Drop the database if it exists (optional)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Virtual_ArtGallery')
BEGIN
    ALTER DATABASE Virtual_ArtGallery SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Virtual_ArtGallery;
END
GO

-- Creating the Virtual_ArtGallery database
CREATE DATABASE Virtual_ArtGallery  
ON PRIMARY  
(  
    NAME = N'Virtual_ArtGallery',  
    FILENAME = N'D:\Virtual_ArtGallery.mdf',  -- Ensure this path is accessible  
    SIZE = 10MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 5MB  
)  
LOG ON  
(  
    NAME = N'Virtual_ArtGallery_log',  
    FILENAME = N'D:\Virtual_ArtGallery.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 5MB  
)  
COLLATE SQL_Latin1_General_CP1_CI_AS;
GO

-- Use the created database
USE Virtual_ArtGallery;
GO

-- Create Schema
CREATE SCHEMA Gallery;
GO

-- Artist Table
CREATE TABLE gallery.Artists (
    ArtistID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Biography NVARCHAR(MAX),
    BirthDate DATE,
    Nationality NVARCHAR(50),
    Website NVARCHAR(100),
    ContactInfo NVARCHAR(100)
);
GO

-- Artwork Table
CREATE TABLE gallery.Artwork (
    ArtworkID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CreationDate DATE,
    Medium NVARCHAR(50),
    ImageURL NVARCHAR(255),
    ArtistID INT NOT NULL,
    FOREIGN KEY (ArtistID) REFERENCES gallery.Artists(ArtistID) ON DELETE CASCADE
);
GO

-- User Table
CREATE TABLE gallery.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    [Password] NVARCHAR(100) NOT NULL, -- Used square brackets to avoid keyword conflict
    Email NVARCHAR(100) UNIQUE NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    ProfilePicture VARBINARY(MAX)
);
GO

-- Gallery Table
CREATE TABLE gallery.Gallery (
    GalleryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Location geography,
    CuratorID INT NULL,  
    OpeningHours NVARCHAR(100),
    UserID INT NULL, 
    Type NVARCHAR(20) CHECK (Type IN ('Physical', 'Virtual')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CuratorID) REFERENCES gallery.Artists(ArtistID) ON DELETE SET NULL,
    FOREIGN KEY (UserID) REFERENCES gallery.Users(UserID) ON DELETE SET NULL
);
GO

-- Junction Table: User_Favorite_Artwork
CREATE TABLE gallery.User_Favorite_Artwork (
    UserID INT NOT NULL,
    ArtworkID INT NOT NULL,
    PRIMARY KEY (UserID, ArtworkID),
    FOREIGN KEY (UserID) REFERENCES gallery.Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ArtworkID) REFERENCES gallery.Artwork(ArtworkID) ON DELETE CASCADE
);
GO

-- Junction Table: Artwork_Gallery
CREATE TABLE gallery.Artwork_Gallery (
    ArtworkID INT NOT NULL,
    GalleryID INT NOT NULL,
    PRIMARY KEY (ArtworkID, GalleryID),
    FOREIGN KEY (ArtworkID) REFERENCES gallery.Artwork(ArtworkID) ON DELETE CASCADE,
    FOREIGN KEY (GalleryID) REFERENCES gallery.Gallery(GalleryID) ON DELETE CASCADE
);
GO

---------------------Creating Indexing-------------------
-- Index for Fast User-Based Virtual Gallery Searches
CREATE INDEX IDX_Gallery_User ON gallery.Gallery (GalleryID, CuratorID);
GO

-- Index for Fast Artwork Retrieval in Virtual Galleries
CREATE INDEX IDX_Artwork_Gallery ON gallery.Artwork_Gallery (GalleryID, ArtworkID);
GO

-----------------------------------------Views for Quick Data Access--------------------------------------

-- Retrieve All Virtual Galleries with User Details
GO
CREATE VIEW gallery.VirtualGalleries AS
SELECT G.GalleryID, G.Name AS GalleryName, G.Description, G.CreatedAt, 
       U.UserID, U.Username, U.Email
FROM gallery.Gallery G
LEFT JOIN gallery.Users U ON G.UserID = U.UserID
WHERE G.Type = 'Virtual';
GO

-- Retrieve Artworks in a Virtual Gallery
GO
CREATE VIEW gallery.VirtualGallery_Artworks AS
SELECT AG.GalleryID, G.Name AS GalleryName, A.ArtworkID, A.Title, A.Medium, A.ImageURL
FROM gallery.Artwork_Gallery AG
JOIN gallery.Gallery G ON AG.GalleryID = G.GalleryID
JOIN gallery.Artwork A ON AG.ArtworkID = A.ArtworkID
WHERE G.Type = 'Virtual';
GO

------------------------------------------Stored Procedures----------------------------------------

-- Create a Virtual Gallery
GO
CREATE PROCEDURE gallery.CreateVirtualGallery
    @UserID INT,
    @GalleryName NVARCHAR(100),
    @Description NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO gallery.Gallery (Name, Description, Type, UserID)
    VALUES (@GalleryName, @Description, 'Virtual', @UserID);
END;
GO

-- Add an Artwork to a Virtual Gallery
GO
CREATE PROCEDURE gallery.AddArtworkToGallery
    @GalleryID INT,
    @ArtworkID INT
AS
BEGIN
    INSERT INTO gallery.Artwork_Gallery (GalleryID, ArtworkID)
    VALUES (@GalleryID, @ArtworkID);
END;
GO

-- Remove an Artwork from a Virtual Gallery
GO
CREATE PROCEDURE gallery.RemoveArtworkFromGallery
    @GalleryID INT,
    @ArtworkID INT
AS
BEGIN
    DELETE FROM gallery.Artwork_Gallery
    WHERE GalleryID = @GalleryID AND ArtworkID = @ArtworkID;
END;
GO

-- Delete a Virtual Gallery (Only Creator Can Delete)
GO
CREATE PROCEDURE gallery.DeleteVirtualGallery
    @GalleryID INT,
    @UserID INT
AS
BEGIN
    DELETE FROM gallery.Gallery 
    WHERE GalleryID = @GalleryID AND UserID = @UserID AND Type = 'Virtual';
END;
GO

-- Fetch User's Virtual Galleries
GO
CREATE PROCEDURE gallery.GetUserVirtualGalleries
    @UserID INT
AS
BEGIN
    SELECT GalleryID, Name, Description, CreatedAt 
    FROM gallery.Gallery 
    WHERE UserID = @UserID AND Type = 'Virtual';
END;
GO
