﻿--CREATE DATABASE Socia
--------------------------------------------------------------UserInfor------------------------------------------------------------------
--phan quyen nguoi dung
go 
CREATE TABLE Role(
	RoleID VARCHAR(11) PRIMARY KEY NOT NULL,
	RoleName VARCHAR(30),
	-- User - User
	-- Admin - Admin
	-- Master_Admin - Master Admin
	-- Business - Business
);

INSERT INTO dbo.Role
VALUES
(   'USER', 'User' ),
(   'ADMIN', 'Admin' ),
(   'MASTERADMIN', 'Master Admin' ),
(   'BUSINESSS', 'Business' );
-- search INSERT INTO dbo.UserInfor
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
	RoleID VARCHAR(11) DEFAULT 'USER',
	intro nvarchar(300),
	CONSTRAINT fk_RoleID_UserInfor FOREIGN KEY (RoleID) REFERENCES dbo.Role(RoleID),
);





--------------------------------------------------------------DBO.POST------------------------------------------------------------------
--Phaan quyen rieng tu bai post INSERT INTO dbo.POST
CREATE TABLE Privacy(
	PrivacyID VARCHAR(11) PRIMARY KEY NOT NULL,
	PrivacyName VARCHAR(30),
)
INSERT INTO dbo.Privacy
VALUES
(   'PUBLIC', 'Public'),
(   'FRIEND', 'Friend'),
(   'PRIVATE', 'Private');

CREATE TABLE POST(
	ID INT IDENTITY(1,1) NOT NULL,
	PostID AS 'PID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboPOST FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID) ON DELETE CASCADE,
	Content NVARCHAR(MAX),
	ImagePost NVARCHAR(255),
	TimePost DATETIME DEFAULT GETDATE(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	NumShare INT DEFAULT 0, 
	PrivacyID VARCHAR(11) DEFAULT 'PUBLIC',
	CONSTRAINT fk_PrivacyID_POST FOREIGN KEY (PrivacyID) REFERENCES dbo.Privacy(PrivacyID),
);

--------------------------------------------------------------DBO.COMMENT------------------------------------------------------------------
CREATE TABLE COMMENT(
	ID INT IDENTITY(1,1) NOT NULL,
	CmtID AS 'CID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboCOMMENT FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	PostID VARCHAR(11),
	Content NVARCHAR(MAX),
	TimeComment DATETIME DEFAULT GETDATE(),
	ImageComment varchar(255),
	NumInterface INT DEFAULT 0,
);



CREATE TABLE COMMENTCHILD(
	ID INT IDENTITY(1,1) NOT NULL,
	ChildID AS 'ILD' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboCOMMENTCHILD FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	CmtID VARCHAR(11),
	CONSTRAINT fk_post_id_dboCOMMENTCHILD FOREIGN KEY (CmtID) REFERENCES dbo.COMMENT(CmtID) ON DELETE CASCADE,
	Content NVARCHAR(MAX),
	TimeComment DATETIME DEFAULT GETDATE(),
	ImageComment varchar(255),
	NumInterface INT DEFAULT 0,
);


--------------------------------------------------------------DBO.MAIL------------------------------------------------------------------
CREATE TABLE MAIL(
	Mail VARCHAR(255) PRIMARY KEY NOT NULL,
	code CHAR(10),
);



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
);
	



--------------------------------------------------------------DBO.CHATCONTENT------------------------------------------------------------------
CREATE TABLE CHATCONTENT(
	ID INT IDENTITY(1,1) NOT NULL,
	ChatID AS 'ChatID' + RIGHT('000000000000' + CAST(ID AS VARCHAR(12)), 12) PERSISTED PRIMARY KEY,
	UserID1 VARCHAR(11),
	CONSTRAINT fk_user_id1_dboCHATCONTENT FOREIGN KEY (UserID1) REFERENCES dbo.UserInfor(UserID),
	UserID2 VARCHAR(11),
	CONSTRAINT fk_user_id2_dboCHATCONTENT FOREIGN KEY (UserID2) REFERENCES dbo.UserInfor(UserID),
	CHECK (UserID1>UserID2),
	Mess NVARCHAR(500),
	ofUser1 BIT,
	--ofUser1 đúng thì đây sẽ là đoạn chat của user1
	--ofUser1 sai thì đây sẽ là đoạn chat của user2 
	CreateAt DATETIME DEFAULT GETDATE(),
	-- rang buoc UserID1 luc nao cung lon hon UserID2
);
--------------------------------------------------------------DBO.SHARE------------------------------------------------------------------
--tao them 1 table share nua


CREATE TABLE POSTSHARE(
ID INT IDENTITY(1,1) NOT NULL,
	ShareID AS 'SID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboPOSTSHARE FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	PostID VARCHAR(11),
	CONSTRAINT  fk_post_id_dboPOSTSHARE FOREIGN KEY (PostID) REFERENCES dbo.POST(PostID),
	Content NVARCHAR(MAX),
	TimeShare DATETIME DEFAULT GETDATE(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	PrivacyID VARCHAR(11) DEFAULT 'PUBLIC',
	CONSTRAINT fk_PrivacyID_POSTSHARE FOREIGN KEY (PrivacyID) REFERENCES dbo.Privacy(PrivacyID),
);
/*CREATE TABLE COMMENTSHARE(
	ID INT IDENTITY(1,1) NOT NULL,
	CmtID AS 'CID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboCOMMENTSHARE FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	ShareID VARCHAR(11),
	CONSTRAINT fk_post_id_dboCOMMENTSHARE FOREIGN KEY (ShareID) REFERENCES dbo.POSTSHARE(ShareID),
	Content NVARCHAR(MAX),
	TimeComment DATETIME DEFAULT GETDATE(),
	ImageComment VARCHAR(255),
	NumInterface INT DEFAULT 0,
)*/

--------------------------------------------------------------DBO.LIKE------------------------------------------------------------------
CREATE TABLE InterFace(
	InterFaceID VARCHAR(11) PRIMARY KEY NOT NULL,
	InterFaceName VARCHAR(30),
	InterFaceDiv VARCHAR(100),
)
INSERT INTO dbo.InterFace
VALUES
(   'like', 'like', '<i class="fa-solid fa-thumbs-up"></i>'),
(   'love', 'love', '<i class="fa-solid fa-heart"></i>'),
(   'haha', 'haha','<i class="fa-solid fa-face-laugh-squint"></i>'),
(   'sad', 'sad', '<i class="fa-solid fa-face-sad-cry"></i>'),
(   'angry', 'angry', '<i class="fa-regular fa-face-nose-steam"></i>'),
(   'wow', 'wow', '<i class="fa-solid fa-face-explode"></i>'),
(   'none', 'none', '<i class="fa-regular fa-thumbs-up"></i>');

CREATE TABLE InterFaceObject(
	UserID VARCHAR(11) NOT NULL,
	CONSTRAINT fk_user_id_InterFaceObject FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	ObjectID VARCHAR(11),
	PRIMARY KEY(ObjectID, UserID),
	InterFaceID VARCHAR(11) DEFAULT 'none'
	CONSTRAINT fk_InterFaceID_InterFaceObject FOREIGN KEY (InterFaceID) REFERENCES dbo.InterFace(InterFaceID),
);
--------------------------------------------------------------DBO.Notificate------------------------------------------------------------------
CREATE TABLE NOTE_COUNT(
	UserID VARCHAR(11) PRIMARY KEY,
	NOTE INT,
	MESS INT 
);

CREATE TABLE NOTE_FRIEND(
	ID INT IDENTITY(1,1) NOT NULL,
	NoteID AS 'NFR' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	UserID VARCHAR(11) NOT NULL,
	CONSTRAINT fk_user_id_Notificate FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	UserIDRequest VARCHAR(11) NOT NULL,
	CONSTRAINT fk_UserIDRequest_Notificate FOREIGN KEY (UserIDRequest) REFERENCES dbo.UserInfor(UserID),
	 CONSTRAINT uc_UserID_UserIDRequest UNIQUE (UserID, UserIDRequest),
	 statusNote NVARCHAR(30),
	 -- sent : nguowfi dung khac yeu cau
	 -- request: minh yeu cau
	 -- accepted: yeu cau cua minh duoc chap nhan
	 -- isFriend: minh chap nhan yeu cau
	TimeRequest DATETIME DEFAULT GETDATE(),
	isRead BIT DEFAULT 0
);
CREATE TABLE NOTE_COMMENT(
	ID INT IDENTITY(1,1) NOT NULL,
	NoteID AS 'NCM' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	ObjectID VARCHAR(11),
	UserID VARCHAR(11) NOT NULL,
	CONSTRAINT uc_UserID_NoteID UNIQUE (UserID, NoteID),
	statusNote NVARCHAR(30),
	 -- post :là bình luậnt của bài dang
	 -- comment: la binh luan tra loi comment
	TimeComment DATETIME DEFAULT GETDATE(),
	isRead BIT DEFAULT 0
);
CREATE TABLE NOTE_lIKE(
	ID INT IDENTITY(1,1) NOT NULL,
	NoteID AS 'NLI' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	ObjectID VARCHAR(11),
	UserID VARCHAR(11) NOT NULL,
	CONSTRAINT uc_UserID_ObjectID UNIQUE (UserID, ObjectID),
	
	statusNote NVARCHAR(30),
	-- post (PID and SID) :là thong bao cho bai viet post va sharepost
	 -- comment (CID, ILD): là thong bao tuong tac cho binh luan post va sharepost
	TimeComment DATETIME DEFAULT GETDATE(),
	isRead BIT DEFAULT 0
);
--------------------------------------------------------------DBO.LIKE------------------------------------------------------------------
CREATE TABLE InterFace(
	InterFaceID VARCHAR(11) PRIMARY KEY NOT NULL,
	InterFaceName VARCHAR(30),
	InterFaceDiv VARCHAR(100),
);
INSERT INTO dbo.InterFace
VALUES
(   'like', 'like', '<i class="fa-solid fa-thumbs-up"></i>'),
(   'love', 'love', '<i class="fa-solid fa-heart"></i>'),
(   'haha', 'haha','<i class="fa-solid fa-face-laugh-squint"></i>'),
(   'sad', 'sad', '<i class="fa-solid fa-face-sad-cry"></i>'),
(   'angry', 'angry', '<i class="fa-regular fa-face-nose-steam"></i>'),
(   'wow', 'wow', '<i class="fa-solid fa-face-explode"></i>'),
(   'none', 'none', '<i class="fa-regular fa-thumbs-up"></i>');


CREATE TABLE InterFaceObject(
	UserID VARCHAR(11) NOT NULL,
	CONSTRAINT fk_user_id_InterFaceObject FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	ObjectID VARCHAR(11),
	PRIMARY KEY(ObjectID, UserID),
	InterFaceID VARCHAR(11) DEFAULT 'none'
	CONSTRAINT fk_InterFaceID_InterFaceObject FOREIGN KEY (InterFaceID) REFERENCES dbo.InterFace(InterFaceID),
);

