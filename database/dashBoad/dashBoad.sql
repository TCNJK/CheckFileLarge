INSERT INTO dbo.Role
(
    RoleID,
    RoleName
)
VALUES
(   'Lock', -- RoleID - varchar(11)
    '1895'  -- RoleName - varchar(30)
    )
INSERT INTO dbo.Role
(
    RoleID,
    RoleName
)
VALUES
(   'DELETED', -- RoleID - varchar(11)
    '4489'  -- RoleName - varchar(30)
    )
--------------------------------------------------
go
CREATE VIEW PostSummaryByMonth AS
SELECT
    MONTH(TimePost) AS Month,
    YEAR(TimePost) AS Year,
    (
        (SELECT COUNT(*) FROM POST WHERE MONTH(TimePost) = MONTH(p.TimePost) AND YEAR(TimePost) = YEAR(p.TimePost)) +
        (SELECT COUNT(*) FROM POSTSHARE WHERE MONTH(TimeShare) = MONTH(p.TimePost) AND YEAR(TimeShare) = YEAR(p.TimePost))
    ) AS TotalPosts
FROM
    POST p
GROUP BY
    MONTH(TimePost),
    YEAR(TimePost);
go
CREATE TABLE MonthlyUsage (
    MonthDate DATE PRIMARY KEY,
    UsageTime BIGINT
);
go
CREATE TABLE ReportPost (
	ID INT IDENTITY(1,1) NOT NULL,
	ReportID AS 'RPID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
    PostID VARCHAR(11),
    UserID VARCHAR(11),
	UserID2 VARCHAR(11),
    IsPost BIT DEFAULT 1,
	Status BIT DEFAULT 1,
    CONSTRAINT FK_ReportPost_User FOREIGN KEY (UserID) REFERENCES UserInfor(UserID),
	CONSTRAINT FK_ReportPost_User2 FOREIGN KEY (UserID2) REFERENCES UserInfor(UserID),
    CONSTRAINT UQ_Post_User UNIQUE (PostID, UserID)
);
GO 
CREATE VIEW ReportPostView AS
SELECT 
    RP.PostID,
    RP.IsPost,
	MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.ImagePost
        ELSE P2.ImagePost
    END) AS ImagePost,
    MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.Content
        ELSE PS.Content
    END) AS Content,
	COUNT(RP.UserID) AS UserCount,
    MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.TimePost
        ELSE PS.TimeShare
    END) AS TimePost,
	RP.UserID2 AS UserID,
	MAX(CAST(RP.Status AS INT)) AS Status
FROM 
    ReportPost RP
    LEFT JOIN POST P ON RP.PostID = P.PostID AND RP.IsPost = 1
    LEFT JOIN POSTSHARE PS ON RP.PostID = PS.ShareID AND RP.IsPost = 0
    LEFT JOIN POST P2 ON PS.PostID = P2.PostID
GROUP BY 
    RP.PostID,
    RP.IsPost,
	RP.UserID2;
GO 
CREATE TABLE ReportComment1686 (
	ID INT IDENTITY(1,1) NOT NULL,
	ReportID AS 'RPID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
    CommentID VARCHAR(11),
    UserID VARCHAR(11),
	UserID2 VARCHAR(11),
	IsPost BIT DEFAULT 1,
	Status BIT DEFAULT 1,
    CONSTRAINT FK_ReportComment_User FOREIGN KEY (UserID) REFERENCES UserInfor(UserID),
	CONSTRAINT FK_ReportComment_User2 FOREIGN KEY (UserID2) REFERENCES UserInfor(UserID),
    CONSTRAINT UQ_Comment_User UNIQUE (CommentID, UserID,IsPost)
);
GO 
CREATE VIEW ReportCommentView AS
SELECT 
    RP.CommentID,
    RP.IsPost,
	MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.ImageComment
        ELSE PS.ImageComment
    END) AS ImageComment,
    MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.Content
        ELSE PS.Content
    END) AS Content,
	COUNT(RP.UserID) AS UserCount,
    MAX(CASE 
        WHEN RP.IsPost = 1 THEN P.TimeComment
        ELSE PS.TimeComment
    END) AS TimeComment,
	RP.UserID2 AS UserID,
	MAX(CAST(RP.Status AS INT)) AS Status
FROM 
    dbo.ReportComment1686 RP
    LEFT JOIN dbo.COMMENT P ON RP.CommentID = P.CmtID AND RP.IsPost = 1
    LEFT JOIN dbo.COMMENTSHARE		 PS ON RP.CommentID = PS.CmtID AND RP.IsPost = 0
    LEFT JOIN COMMENT P2 ON PS.ShareID = P2.PostID
GROUP BY 
    RP.CommentID,
    RP.IsPost,
	RP.UserID2;
GO 

CREATE TABLE ReportUser1686 (
	ID INT IDENTITY(1,1) NOT NULL,
	ReportID AS 'RPID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
    UserID VARCHAR(11),
    UserIDRP VARCHAR(11),
	Status BIT DEFAULT 1,
    CONSTRAINT FK_ReportUser_User FOREIGN KEY (UserID) REFERENCES UserInfor(UserID),
	CONSTRAINT FK_ReportUser_User2 FOREIGN KEY (UserIDRP) REFERENCES UserInfor(UserID),
    CONSTRAINT UQ_User_User UNIQUE (UserID,UserIDRP)
);



GO 
CREATE TABLE UserLock (
	UserID VARCHAR(11),
	-- datetime admin lock
	LockTime DATETIME,
	-- lock bn ngay
    LockDurationDay INT,
	-- lock bn gio
    LockDurationHour INT,
	-- lock phut
    LockDurationMinute INT,
    PRIMARY KEY (UserID),
    FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID)
);

GO 
CREATE VIEW UserReportSummary
AS
SELECT
    u.UserID,
    u.ImageUser,
    u.FullName,
    u.Account,
    u.Mail,
    u.PhoneNumber,
    u.Address,
    (SELECT COUNT(*) FROM ReportComment1686 WHERE UserID2 = u.UserID) AS NumCommentReported,
    (SELECT COUNT(*) FROM ReportPost WHERE UserID2 = u.UserID) AS NumPostReported,
	(SELECT COUNT(DISTINCT UserIDRP) FROM ReportUser1686 WHERE UserID = u.UserID AND Status = 1) AS NumReportedByUsers
FROM
    UserInfor u
WHERE
    u.UserID IN (SELECT UserID FROM ReportUser1686 WHERE Status = 1);
GO 
	CREATE VIEW UserView AS
SELECT UserID, ImageUser, FullName, Address, Mail, Account, PhoneNumber, Dob, Nation, RoleID
FROM UserInfor;

