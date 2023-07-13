--CreateTable.sql
﻿--create database SocialNetwork
--------------------------------------------------------------UserInfor------------------------------------------------------------------
CREATE TABLE UserInfor(
	ID INT IDENTITY(1,1) NOT NULL,
	UserID AS 'UID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	Account VARCHAR(155) UNIQUE,
	Password VARCHAR(155),
	FullName NVARCHAR(255),
	Address NVARCHAR(255),
	Mail VARCHAR(255),
	PhoneNumber VARCHAR(15),
	Dob DATE,
	Gender BIT,
	-- 0: girl
	-- 1: man
	Nation NVARCHAR(255),
	ImageUser NVARCHAR(255),
	ImageBackGround NVARCHAR(255),
	NumFriend INT DEFAULT 0,
	NumPost INT DEFAULT 0,
	TimeCreate DATETIME DEFAULT GETDATE(),
	isAdmin BIT DEFAULT 0
	-- 0 khong phai admin
	-- 1 chinh  la  admin
);





--------------------------------------------------------------DBO.POST------------------------------------------------------------------
CREATE TABLE POST(
	ID INT IDENTITY(1,1) NOT NULL,
	PostID AS 'PID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboPOST FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	Content NVARCHAR(MAX),
	ImagePost NVARCHAR(255),
	TimePost DATETIME DEFAULT GETDATE(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	NumShare INT DEFAULT 0, 
	PublicPost BIT,
)



--------------------------------------------------------------DBO.COMMENT------------------------------------------------------------------
CREATE TABLE COMMENT(
	ID INT IDENTITY(1,1) NOT NULL,
	CmtID AS 'CID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboCOMMENT FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	PostID VARCHAR(11),
	CONSTRAINT fk_post_id_dboCOMMENT FOREIGN KEY (PostID) REFERENCES dbo.POST(PostID),
	Content NVARCHAR(MAX),
	TimeComment DATETIME DEFAULT GETDATE(),
	ImageComment varchar(255),
	NumInterface INT DEFAULT 0,
)




--------------------------------------------------------------DBO.USERRELATION------------------------------------------------------------------
CREATE TABLE USERRELATION(
	UserID1 VARCHAR(11),
	CONSTRAINT fk_user_id1_dboUSERRELATION FOREIGN KEY (UserID1) REFERENCES dbo.UserInfor(UserID),
	UserID2 VARCHAR(11),
	CONSTRAINT fk_user_id2_dboUSERRELATION FOREIGN KEY (UserID2) REFERENCES dbo.UserInfor(UserID),
	PRIMARY KEY(UserID1, UserID2),
	CHECK (UserID1>UserID2),
	-- rang buoc UserID1 luc nao cung lon hon UserID2
	--Request BIT DEFAULT NULL,
	U1RequestU2 BIT DEFAULT 0,
	U2RequestU1 BIT DEFAULT 0,
	isFriend BIT DEFAULT 0,
	-- 0: da ket ban
	-- 1: chua ket ban
)
	


--------------------------------------------------------------DBO.CHATCONTENT------------------------------------------------------------------
CREATE TABLE CHATCONTENT(
	ID INT IDENTITY(1,1) NOT NULL,
	ChatID AS 'ChatID' + RIGHT('000000000000' + CAST(ID AS VARCHAR(12)), 12) PERSISTED PRIMARY KEY,
	UserID1 VARCHAR(11),
	constraint fk_user_id1_dboCHATCONTENT foreign key (UserID1) references dbo.UserInfor(UserID),
	UserID2 varchar(11),
	constraint fk_user_id2_dboCHATCONTENT foreign key (UserID2) references dbo.UserInfor(UserID),
	check (UserID1>UserID2),
	Mess NVARCHAR(500),
	ofUser1 BIT,
	--ofUser1 đúng thì đây sẽ là đoạn chat của user1
	--ofUser1 sai thì đây sẽ là đoạn chat của user2 
	CreateAt DATETIME DEFAULT GETDATE(),
	-- rang buoc UserID1 luc nao cung lon hon UserID2
)
--------------------------------------------------------------DBO.SHARE------------------------------------------------------------------
--tao them 1 table share nua


CREATE TABLE POSTSHARE(
ID INT IDENTITY(1,1) NOT NULL,
	ShareID AS 'SID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) persisted PRIMARY KEY,
	UserID varchar(11),
	constraint fk_user_id_dboPOSTSHARE foreign key (UserID) references dbo.UserInfor(UserID),
	PostID varchar(11),
	constraint fk_post_id_dboPOSTSHARE foreign key (PostID) references dbo.POST(PostID),
	Content nvarchar(max),
	TimeShare DATETIME DEFAULT getDate(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	PublicPost BIT,
)

Create table COMMENTSHARE(
	ID INT IDENTITY(1,1) NOT NULL,
	CmtID AS 'CID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) persisted PRIMARY KEY,
	UserID varchar(11),
	constraint fk_user_id_dboCOMMENTSHARE foreign key (UserID) references dbo.UserInfor(UserID),
	ShareID varchar(11),
	constraint fk_post_id_dboCOMMENTSHARE FOREIGN key (ShareID) references dbo.POSTSHARE(ShareID),
	Content nvarchar(max),
	TimeComment datetime DEFAULT getDate(),
	ImageComment varchar(255),
	NumInterface INT DEFAULT 0,
)

CREATE TABLE MAIL(
	Mail VARCHAR(255) PRIMARY KEY NOT NULL,
	code CHAR(10),
)

INSERT INTO dbo.POST
(
    UserID,
    Content,
    ImagePost,
    TimePost,
    NumInterface,
    NumComment,
    NumShare,
    PrivacyID
)
VALUES
(   NULL,    -- UserID - varchar(11)
    NULL,    -- Content - nvarchar(max)
    NULL,    -- ImagePost - nvarchar(255)
    DEFAULT, -- TimePost - datetime
    DEFAULT, -- NumInterface - int
    DEFAULT, -- NumComment - int
    DEFAULT, -- NumShare - int
    DEFAULT  -- PrivacyID - varchar(11)
    )

	Update POST
    set Content= ? , ImagePost= ? , PrivacyID= ?
where PostID= ?;

INSERT INTO dbo.POSTSHARE
(
    UserID,
    PostID,
    Content,
    TimeShare,
    NumInterface,
    NumComment,
    PrivacyID
)
VALUES
(   NULL,    -- UserID - varchar(11)
    NULL,    -- PostID - varchar(11)
    NULL,    -- Content - nvarchar(max)
    DEFAULT, -- TimeShare - datetime
    DEFAULT, -- NumInterface - int
    DEFAULT, -- NumComment - int
    DEFAULT  -- PrivacyID - varchar(11)
    )

	SELECT PostID, UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName
	FROM dbo.POST
	INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID
	WHERE PostID= ?

	SELECT POST.ID, PostID, POST.UserID, Content,
                		ImagePost, TimePost, NumInterface, NumComment, 
                		NumShare, PrivacyName, FullName, ImageUser
	FROM dbo.POST 
	INNER JOIN dbo.UserInfor ON POST.UserID = UserInfor.UserID
	 INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID
	 WHERE POST.UserID= ? 
	 ORDER BY POST.TimePost DESC

	 SELECT PostID, POST.UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName, FullName, ImageUser
            FROM dbo.POST
            INNER JOIN dbo.UserInfor ON UserInfor.UserID = POST.UserID
			INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID

	SELECT c.UserID, c.FullName, c.ImageUser, 
            b.TimePost, b.Content, a.PostID, a.ShareID, a.UserID, 
            d.FullName, d.ImageUser,a.Content,
            a.TimeShare, a.NumInterface, a.NumComment, e.PrivacyName, b.ImagePost
            FROM dbo.POSTSHARE a
            INNER JOIN dbo.POST b ON b.PostID = a.PostID
            INNER JOIN dbo.UserInfor c ON b.UserID= c.UserID
            INNER JOIN dbo.UserInfor d ON d.UserID= a.UserID
			INNER JOIN dbo.Privacy e ON e.PrivacyID = a.PrivacyID
            WHERE a.UserID= ? 

	SELECT PostID, POST.UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName, FullName, ImageUser
            FROM dbo.POST
            INNER JOIN dbo.UserInfor ON UserInfor.UserID = POST.UserID
			INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID
            WHERE POST.UserID= ? 

	DECLARE @InsertedIDs TABLE (ShareID VARCHAR(11));
            	INSERT INTO dbo.POSTSHARE
            (
            	    UserID,
            	    PostID,
            	    Content,
            	    TimeShare,
            	    NumInterface,
            	    NumComment,
            	    PrivacyID
            	)
            	OUTPUT Inserted.ShareID INTO @InsertedIDs
            	VALUES
            	(   'UID00000001' ,    -- UserID - varchar(11)
            	    'PID00000001' ,    -- PostID - varchar(11)
            	    'ÁDF' ,    -- Content - nvarchar(max)
            	    DEFAULT, -- TimeShare - datetime
            	    DEFAULT, -- NumInterface - int
            	    DEFAULT, -- NumComment - int
            	    'FRIEND'  -- PrivacyID - varchar(11)
            	    )
            SELECT ShareID FROM @InsertedIDs;

			SELECT UserID, FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, 
			ImageUser, ImageBackGround FROM  dbo.UserInfor WHERE UserID = 'UID00000003'
			U2RequestU1
			U1RequestU2

			
