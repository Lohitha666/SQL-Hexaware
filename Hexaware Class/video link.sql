CREATE TABLE VideoFiles (
    VideoID INT PRIMARY KEY IDENTITY(1,1),
    VideoName NVARCHAR(255),
    VideoPath NVARCHAR(500)  
);

INSERT INTO VideoFiles (VideoName, VideoPath)
VALUES ('SQL Tutorial Video', 'https://www.youtube.com/watch?v=yD6FHjZ7F-c');


SELECT * FROM VideoFiles;
