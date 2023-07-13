--create database trash1
--------------------------------------------------------------UserInfor------------------------------------------------------------------
Create table UserInfor(
	ID INT IDENTITY(1,1) NOT NULL,
	UserID AS 'UID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) persisted PRIMARY KEY,
	Account varchar(155) unique,
	Password varchar(155),
	FullName nvarchar(255),
	Address nvarchar(255),
	Mail varchar(255),
	PhoneNumber varchar(15),
	check (PhoneNumber like '%[^0-9]%'),
	Dob date,
	Gender bit,
	-- 0: girl
	-- 1: man
	Nation nvarchar(255),
	ImageUser nvarchar(255),
	NumFriend INT DEFAULT 0,
	NumPost INT DEFAULT 0,
	TimeCreate datetime DEFAULT getDate(),
	isAdmin BIT DEFAULT 0
	-- 0 khong phai admin
	-- 1 chinh  la  admin
);
--NumFriend: trigger khi add friend, trigger khi huy friend dbo.USERRELATION
CREATE TRIGGER trigger_friend
ON USERRELATION AFTER UPDATE 
AS
BEGIN
	IF (UPDATE(isFriend))
	BEGIN
		IF((SELECT isFriend FROM inserted) = 1)
		BEGIN
			UPDATE [dbo].[UserInfor]
			SET NumFriend = NumFriend + 1
			WHERE UserID IN (SELECT UserID1 FROM inserted);

			UPDATE [dbo].[UserInfor]
			SET NumFriend = NumFriend + 1
			WHERE UserID IN (SELECT UserID2 FROM inserted);
		END
		ELSE
		BEGIN
			UPDATE [dbo].[UserInfor]
			SET NumFriend = NumFriend - 1
			WHERE UserID IN (SELECT UserID1 FROM deleted);

			UPDATE [dbo].[UserInfor]
			SET NumFriend = NumFriend - 1
			WHERE UserID IN (SELECT UserID2 FROM deleted);
		END
	END
END;


--NumPost  : Trigger khi ddanwg bai
CREATE TRIGGER post_INSERT
ON POST After INSERT
AS
BEGIN
	UPDATE dbo.UserInfor
	SET NumPost= NumPost +1
	WHERE UserID= (SELECT UserID FROM inserted);
END;

CREATE TRIGGER post_DELETE
ON POST After DELETE
AS
BEGIN
	UPDATE dbo.UserInfor
	SET NumPost= NumPost -1
	WHERE UserID= (SELECT UserID FROM Deleted);
END;




--------------------------------------------------------------DBO.POST------------------------------------------------------------------
Create table POST(
	ID INT IDENTITY(1,1) NOT NULL,
	PostID AS 'PID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) persisted PRIMARY KEY,
	UserID varchar(11),
	constraint fk_user_id_dboPOST foreign key (UserID) references dbo.UserInfor(UserID),
	Content nvarchar(max),
	ImagePost nvarchar(255),
	TimePost datetime DEFAULT getDate(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	NumShare INT DEFAULT 0, 
)
-- NumInterface: tigger khi huy like va like dbo. (casi nay khong can trigger)
-- NumComment: trigger khi comment va xoa comment
	CREATE TRIGGER delete_comment_of_post
	ON dbo.comment AFTER DELETE
	as
	BEGIN
		UPDATE dbo.POST
		SET NumComment= NumComment -1
		WHERE PostID= (SELECT PostID FROM Deleted)
	END;

	CREATE TRIGGER insert_comment_of_post
	ON dbo.comment AFTER INSERT 
	as
	BEGIN
		UPDATE dbo.POST
		SET NumComment= NumComment +1
		WHERE PostID= (SELECT PostID FROM Inserted)
	END;
-- NumShare: trigger khi share
CREATE TRIGGER increase_when_share_POST
ON dbo.POSTSHARE AFTER INSERT
AS
BEGIN
	UPDATE dbo.POST
	SET NumShare= NumShare +1
	WHERE PostID= (SELECT PostID FROM INSERTed)
END



--------------------------------------------------------------DBO.COMMENT------------------------------------------------------------------
Create table COMMENT(
	ID INT IDENTITY(1,1) NOT NULL,
	CmtID AS 'CID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) persisted PRIMARY KEY,
	UserID varchar(11),
	constraint fk_user_id_dboCOMMENT foreign key (UserID) references dbo.UserInfor(UserID),
	PostID varchar(11),
	constraint fk_post_id_dboCOMMENT foreign key (PostID) references dbo.POST(PostID),
	Content nvarchar(max),
	TimeComment datetime DEFAULT getDate(),
	ImageComment varchar(255),
	NumInterface INT DEFAULT 0,
)
-- NumInterface: tigger khi huy like va like (casi nay khong can trigger)



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
	-- trigger neu user1 va user2 dong thoi yeu cau kb cho nhau thi chuyen bit = 1;
	CREATE TRIGGER ChangeToFriend
	ON USERRELATION AFTER UPDATE
	AS
	BEGIN
		IF( UPDATE(U1RequestU2) AND UPDATE(U2RequestU1))
			UPDATE dbo.USERRELATION
			SET U1RequestU2= 0, U2RequestU1= 0, isFriend= 1
			WHERE UserID1= (SELECT UserID1 FROM dbo.USERRELATION) AND UserID2= (SELECT UserID2 FROM dbo.USERRELATION)
    END;


--------------------------------------------------------------DBO.CHATCONTENT------------------------------------------------------------------
CREATE TABLE CHATCONTENT(
	ID INT IDENTITY(1,1) NOT NULL,
	ChatID AS 'ChatID' + RIGHT('000000000000' + CAST(ID AS VARCHAR(12)), 12) PERSISTED PRIMARY KEY,
	UserID1 VARCHAR(11),
	constraint fk_user_id1_dboCHATCONTENT foreign key (UserID1) references dbo.UserInfor(UserID),
	UserID2 varchar(11),
	constraint fk_user_id2_dboCHATCONTENT foreign key (UserID2) references dbo.UserInfor(UserID),
	check (UserID1>UserID2),
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
)
-- NumComment: trigger khi comment va xoa comment
	CREATE TRIGGER delete_comment_of_POSTSHARE
	ON dbo.COMMENTSHARE AFTER DELETE
	as
	BEGIN
		UPDATE dbo.POSTSHARE
		SET NumComment= NumComment -1
		WHERE ShareID= (SELECT ShareID FROM Deleted)
	END;

	CREATE TRIGGER insert_comment_of_POSTSHARE
	ON dbo.COMMENTSHARE AFTER INSERT 
	as
	BEGIN
		UPDATE dbo.POSTSHARE
		SET NumComment= NumComment +1
		WHERE ShareID= (SELECT ShareID FROM Inserted)
	END;

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
