-- Drop the database if it already exists (optional)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Virtual_ArtGallery')
BEGIN
    ALTER DATABASE Virtual_ArtGallery SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Virtual_ArtGallery;
END
GO

-- Creating the Virtual_ArtGallery database with file paths
CREATE DATABASE [Virtual_ArtGallery]  
ON PRIMARY  
(  
    NAME = N'Virtual_ArtGallery',  
    FILENAME = N'D:\Virtual_ArtGallery.mdf',  -- Main database file
    SIZE = 10MB,  
    MAXSIZE = 50MB,  
    FILEGROWTH = 5MB  
)  
LOG ON  
(  
    NAME = N'Virtual_ArtGallery_log',  
    FILENAME = N'D:\Virtual_ArtGallery.ldf',  -- Log file
    SIZE = 5MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 5MB  
)  
COLLATE SQL_Latin1_General_CP1_CI_AS;
GO

-- Use the newly created database
USE Virtual_ArtGallery;
GO

-- Creating a Schema
CREATE SCHEMA Gallery;
GO

-- Creating an Artists Table
CREATE TABLE Gallery.Artists (
    ArtistID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50),
    BirthYear INT
);
GO

-- Creating an Artworks Table
CREATE TABLE Gallery.Artworks (
    ArtworkID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL,
    ArtistID INT NOT NULL,
    YearCreated INT,
    Medium NVARCHAR(50),
    Price DECIMAL(10,2),
    FOREIGN KEY (ArtistID) REFERENCES Gallery.Artists(ArtistID)
);
GO

-- Creating a Users Table
CREATE TABLE Gallery.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'Artist', 'Viewer')) NOT NULL
);
GO

-- Creating a Transactions Table
CREATE TABLE Gallery.Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ArtworkID INT NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Gallery.Users(UserID),
    FOREIGN KEY (ArtworkID) REFERENCES Gallery.Artworks(ArtworkID)
);
GO
