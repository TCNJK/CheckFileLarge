--NumFriend: trigger khi add friend, trigger khi huy friend dbo.USERRELATION
	GO
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
				WHERE UserID IN (SELECT UserID1 FROM deleted);

				UPDATE [dbo].[UserInfor]
				SET NumFriend = NumFriend + 1
				WHERE UserID IN (SELECT UserID2 FROM deleted);
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
	--nếu post đăng thì sẽ tăng thuộc tính NumPost của UserInfor lên 1
	GO
	CREATE TRIGGER post_INSERT
	ON POST After INSERT
	AS
	BEGIN
		UPDATE dbo.UserInfor
		SET NumPost= NumPost +1
		WHERE UserID= (SELECT UserID FROM inserted);
	END;
	--nếu post đăng thì sẽ giảm thuộc tính NumPost của UserInfor đi 1
	GO
	CREATE TRIGGER post_DELETE
	ON POST After DELETE
	AS
	BEGIN
		UPDATE dbo.UserInfor
		SET NumPost= NumPost -1
		WHERE UserID= (SELECT UserID FROM Deleted);
	END;

-- NumInterface: tigger khi huy like va like dbo. (casi nay khong can trigger)
-- NumComment: trigger khi comment va xoa comment
	-- tăng NumComment của post kkhi đăng bình luận
	GO
	CREATE  TRIGGER delete_comment_of_post
	ON dbo.comment AFTER DELETE
	as
	BEGIN
		UPDATE dbo.POST
		SET NumComment= NumComment -1
		WHERE PostID= (SELECT PostID FROM Deleted)
		UPDATE dbo.PostShare
		SET NumComment= NumComment -1
		WHERE PostID= (SELECT PostID FROM Deleted)
		UPDATE dbo.Advertisement
		SET NumComment= NumComment -1
		WHERE AdvertiserID= (SELECT PostID FROM Deleted)
	END;
	-- giảm NumComment của post kkhi xáo bình luận
	GO
	CREATE  TRIGGER insert_comment_of_post
	ON dbo.comment AFTER INSERT 
	as
	BEGIN
		UPDATE dbo.POST
		SET NumComment= NumComment +1
		WHERE PostID= (SELECT PostID FROM Inserted)
		UPDATE dbo.PostShare
		SET NumComment= NumComment +1
		WHERE PostID= (SELECT PostID FROM Inserted)
		UPDATE dbo.Advertisement
		SET NumComment= NumComment +1
		WHERE AdvertiserID= (SELECT PostID FROM Inserted)
	END;

-- NumShare: trigger khi share
	--trigger khi đăng post
	go
	CREATE TRIGGER increase_when_share_POST
	ON dbo.POSTSHARE AFTER INSERT
	AS
	BEGIN
		UPDATE dbo.POST
		SET NumShare= NumShare +1
		WHERE PostID= (SELECT PostID FROM INSERTed)
	END
	--trigger khi xóa post
	go
	CREATE TRIGGER decrease_when_share_POST
	ON dbo.POSTSHARE AFTER DELETE
	AS
	BEGIN
		UPDATE dbo.POST
		SET NumShare= NumShare -1
		WHERE PostID= (SELECT PostID FROM deleted)
	END

-- NumInterface: tigger khi huy like va like (casi nay khong can trigger)
-- trigger neu user1 va user2 dong thoi yeu cau kb cho nhau thi chuyen bit = 1;
	go
	/*CREATE TRIGGER ChangeToFriend
	ON USERRELATION AFTER UPDATE
	AS
	BEGIN
		IF( UPDATE(U1RequestU2) AND UPDATE(U2RequestU1))
			UPDATE dbo.USERRELATION
			SET U1RequestU2= 0, U2RequestU1= 0, isFriend= 1
			WHERE UserID1= (SELECT UserID1 FROM dbo.USERRELATION) AND UserID2= (SELECT UserID2 FROM dbo.USERRELATION)
    END;*/
	CREATE TRIGGER ChangeToFriend
	ON USERRELATION AFTER UPDATE
	AS
	BEGIN
		IF EXISTS (
			SELECT *
			FROM INSERTED i1
			WHERE U1RequestU2 = 1 AND U2RequestU1 = 1
		)
		BEGIN
			UPDATE USERRELATION
			SET isFriend = 1, U1RequestU2= 0, U2RequestU1= 0
			FROM USERRELATION u
			JOIN INSERTED i1 ON u.UserID1 = i1.UserID1 AND u.UserID2 = i1.UserID2
			WHERE i1.U1RequestU2 = 1 AND i1.U2RequestU1 = 1
		END
	END;
	
-- NumComment: trigger khi comment va xoa comment
	
-- new path for image
	
	GO
    CREATE TRIGGER Add_Path_For_Post
	ON dbo.POST AFTER INSERT
	AS
	BEGIN
		
		UPDATE dbo.POST
		SET ImagePost= CASE
            WHEN ImagePost= '' THEN ''
			else
			ImagePost
			end
		WHERE PostID= (SELECT PostID FROM INSERTed)
	END
	GO
   CREATE TRIGGER Add_Path_For_UPDATE_Post
	ON dbo.POST AFTER UPDATE
	AS
	BEGIN
		IF UPDATE(ImagePost) 
			BEGIN
			UPDATE p
			SET ImagePost = CASE
					WHEN p.ImagePost = '' THEN ''
					ELSE 'data/post/'+p.PostID+'/'+p.ImagePost
				END
			FROM dbo.POST p
			INNER JOIN INSERTED i ON p.PostID = i.PostID
		END
	END
	
 
		-- add path for comment
	GO
    CREATE TRIGGER Add_Path_For_INSERT_Comment
	ON dbo.COMMENT AFTER INSERT
	AS
	BEGIN
		
		UPDATE dbo.COMMENT
		SET ImageComment= CASE
            WHEN ImageComment= '' THEN ''
			else
			ImageComment
			end
		WHERE CmtID= (SELECT CmtID FROM INSERTed)
	END
	GO
   CREATE TRIGGER Add_Path_For_UPDATE_Comment
	ON dbo.COMMENT AFTER UPDATE
	AS
	BEGIN
		IF UPDATE(ImageComment) 
			BEGIN
			UPDATE p
			SET p.ImageComment = CASE
					WHEN p.ImageComment = '' THEN ''
					ELSE 'data/post/'+p.PostID+'/'+p.CmtID+'/'+p.ImageComment
				END
			FROM dbo.COMMENT p
			INNER JOIN INSERTED i ON p.CmtID = i.CmtID
		END
	END

	-- add path for CommentChild
	GO
    CREATE TRIGGER Add_Path_For_INSERT_CommentChild
	ON dbo.COMMENTCHILD AFTER INSERT
	AS
	BEGIN
		
		UPDATE dbo.COMMENTCHILD
		SET ImageComment= CASE
            WHEN ImageComment= '' THEN ''
			ELSE
			ImageComment
			END
		WHERE CmtID= (SELECT Inserted.CmtID FROM INSERTed)
	END
	GO
   CREATE TRIGGER Add_Path_For_UPDATE_CommentChild
	ON dbo.COMMENTCHILD AFTER UPDATE
	AS
	BEGIN
		IF UPDATE(ImageComment) 
			BEGIN
			UPDATE p
			SET p.ImageComment = CASE
					WHEN p.ImageComment = '' THEN ''
					ELSE 'data/post/'+(SELECT TOP(1) PostID FROM dbo.COMMENT WHERE p.CmtID= dbo.COMMENT.CmtID)+'/'+p.CmtID+'/'+p.ChildID+'/'+p.ImageComment
				END
			FROM dbo.COMMENTCHILD p
			INNER JOIN INSERTED i ON p.ChildID= i.ChildID
		END
	END
	--data/user/UID00000001/background/img.jfif
	--data/user/UID00000001/avatar/img.jfif
	

	GO
    CREATE  TRIGGER Add_Path_For_Update_user
	ON dbo.UserInfor AFTER UPDATE 
	AS
	BEGIN
	IF UPDATE(ImageUser) 
		BEGIN
			UPDATE p
			SET p.ImageUser = CASE
					WHEN p.ImageUser = '' THEN ''
					ELSE 'data/user/'+p.UserID+'/avatar/'+p.ImageUser
				END
			FROM dbo.UserInfor p
			INNER JOIN INSERTED i ON p.UserID = i.UserID
		END
	IF UPDATE(ImageBackGround) 
		BEGIN
			UPDATE p
			SET p.ImageBackGround = CASE
					WHEN p.ImageBackGround = '' THEN ''
					ELSE 'data/user/'+p.UserID+'/background/'+p.ImageBackGround
				END
			FROM dbo.UserInfor p
			INNER JOIN INSERTED i ON p.UserID = i.UserID
		END
	END
	--trigger like object 
	GO
    CREATE  TRIGGER UpDate_Object_Inteface
	ON dbo.InterFaceObject AFTER UPDATE 
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @ObjectID VARCHAR(11)
		DECLARE @UserID VARCHAR(11)
		DECLARE @InterFaceID VARCHAR(11)

		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UpDate_Object_Inteface CURSOR FOR
			SELECT Inserted.ObjectID, Inserted.UserID,Inserted.InterFaceID
			FROM inserted;

		-- Mở CURSOR
		OPEN curRows_UpDate_Object_Inteface;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UpDate_Object_Inteface INTO @ObjectID, @UserID, @InterFaceID;

		-- Duyệt qua từng hàng và thực hiện các câu lệnh tương ứng
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			IF(@ObjectID LIKE 'PID%')
				BEGIN
					UPDATE dbo.POST
					SET NumInterface= CASE 
								WHEN @InterFaceID= 'none' THEN  NumInterface-1
								ELSE NumInterface + 1
							END
					WHERE PostID= @ObjectID
				END
			ELSE IF (@ObjectID LIKE 'SID%')
				BEGIN
					UPDATE dbo.POSTSHARE
					SET NumInterface= CASE 
								WHEN @InterFaceID= 'none' THEN  NumInterface-1
								ELSE NumInterface + 1
							END
					WHERE ShareID= @ObjectID
				END
			ELSE IF (@ObjectID LIKE 'CID%')
				BEGIN
					UPDATE dbo.COMMENT
					SET NumInterface= CASE 
								WHEN @InterFaceID= 'none' THEN  NumInterface-1
								ELSE NumInterface + 1
							END
					WHERE CmtID= @ObjectID
				END
			ELSE IF (@ObjectID LIKE 'ILD%')
				BEGIN
					UPDATE dbo.COMMENTCHILD
					SET NumInterface= CASE 
								WHEN @InterFaceID= 'none' THEN  NumInterface-1
								ELSE NumInterface + 1
							END
					WHERE ChildID= @ObjectID
				END
			ELSE IF (@ObjectID LIKE 'AID%')
				BEGIN
					UPDATE dbo.Advertisement
					SET NumInterface= CASE 
								WHEN @InterFaceID= 'none' THEN  NumInterface-1
								ELSE NumInterface + 1
							END
					WHERE AdvertiserID= @ObjectID
				END

			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UpDate_Object_Inteface INTO @ObjectID, @UserID, @InterFaceID;
		END;

		-- Đóng CURSOR
		CLOSE curRows_UpDate_Object_Inteface;
		DEALLOCATE curRows_UpDate_Object_Inteface;
	END

-----------------------------------------------Trigger for note-----------------------------------------------

go
	CREATE TRIGGER UseForNOTE_FRIEND
	ON USERRELATION AFTER UPDATE
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @U1RequestU2 BIT 
		DECLARE @U2RequestU1 BIT 
		DECLARE @isFriend BIT 
		DECLARE @UserID1 VARCHAR(11)
		DECLARE @UserID2 VARCHAR(11)
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_FRIEND CURSOR FOR
			SELECT Inserted.U1RequestU2, Inserted.U2RequestU1,Inserted.isFriend , Inserted.UserID1, Inserted.UserID2
			FROM inserted;

		-- Mở CURSOR
		OPEN curRows_UseForNOTE_FRIEND;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_FRIEND INTO @U1RequestU2, @U2RequestU1, @isFriend, @UserID1, @UserID2;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			IF(@U1RequestU2= 0 AND @U2RequestU1= 1)
				BEGIN
					IF NOT EXISTS( SELECT * FROM dbo.NOTE_FRIEND WHERE UserID= @UserID1 AND UserIDRequest=@UserID2 )
						BEGIN
							INSERT INTO dbo.NOTE_FRIEND
							VALUES
							(   @UserID1,@UserID2,'sent',GETDATE(), 0 )
						END
					ELSE 
						BEGIN
							UPDATE dbo.NOTE_FRIEND
							SET statusNote='sent', TimeRequest= GETDATE()
							WHERE UserID= @UserID1 AND UserIDRequest= @UserID2
						END
					IF NOT EXISTS( SELECT * FROM dbo.NOTE_FRIEND WHERE UserID= @UserID2 AND UserIDRequest=@UserID1 )
						BEGIN
							INSERT INTO dbo.NOTE_FRIEND
							VALUES
							(   @UserID2,@UserID1,'request',GETDATE(),0 )
						END
					ELSE 
						BEGIN
							UPDATE dbo.NOTE_FRIEND
							SET statusNote='request', TimeRequest= GETDATE()
							WHERE UserID= @UserID2 AND UserIDRequest= @UserID1
						END
				END
			ELSE 
				IF(@U1RequestU2= 1 AND @U2RequestU1= 0)
					BEGIN
						IF NOT EXISTS( SELECT * FROM dbo.NOTE_FRIEND WHERE UserID= @UserID1 AND UserIDRequest=@UserID2 )
							BEGIN
								INSERT INTO dbo.NOTE_FRIEND
								VALUES
								(   @UserID1,@UserID2,'request',GETDATE(),0 )
							END
						ELSE 
							BEGIN
								UPDATE dbo.NOTE_FRIEND
								SET statusNote='request', TimeRequest= GETDATE()
								WHERE UserID= @UserID1 AND UserIDRequest= @UserID2
							END
						IF NOT EXISTS( SELECT * FROM dbo.NOTE_FRIEND WHERE UserID= @UserID2 AND UserIDRequest=@UserID1 )
							BEGIN
								INSERT INTO dbo.NOTE_FRIEND
								VALUES
								(   @UserID2,@UserID1,'sent',GETDATE(),0 )
							END
						ELSE 
							BEGIN
								UPDATE dbo.NOTE_FRIEND
								SET statusNote='sent', TimeRequest= GETDATE()
								WHERE UserID= @UserID2 AND UserIDRequest= @UserID1
							END
					END
					ELSE IF  (@U1RequestU2= 0 AND @U2RequestU1= 0 AND @isFriend= 1)
								BEGIN
									DECLARE @status NVARCHAR(30) = (
										SELECT TOP(1) statusNote
										FROM dbo.NOTE_FRIEND
										WHERE UserID = @UserID1 AND UserIDRequest = @UserID2
									)

									IF(@status = 'sent')
										BEGIN
											UPDATE dbo.NOTE_FRIEND
											SET TimeRequest= GETDATE(), statusNote= 'isFriend'
											WHERE UserID= @UserID1 AND UserIDRequest= @UserID2
											UPDATE dbo.NOTE_FRIEND
											SET TimeRequest= GETDATE(), statusNote= 'accepted'
											WHERE UserID= @UserID2 AND UserIDRequest= @UserID1
										END
									ELSE IF(@status = 'request')
										BEGIN
											UPDATE dbo.NOTE_FRIEND
											SET TimeRequest= GETDATE(), statusNote= 'accepted'
											WHERE UserID= @UserID1 AND UserIDRequest= @UserID2
											UPDATE dbo.NOTE_FRIEND
											SET TimeRequest= GETDATE(), statusNote= 'isFriend'
											WHERE UserID= @UserID2 AND UserIDRequest= @UserID1
										END
								END
						
					 -- sent    : nguoi dung khac yeu cau
		 -- request : minh yeu cau
		 -- accepted: yeu cau cua minh duoc chap nhan
		 -- isFriend: minh chap nhan yeu cau
		-- Duyệt qua từng hàng và thực hiện các câu lệnh tương ứng

			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_FRIEND INTO @U1RequestU2, @U2RequestU1, @isFriend, @UserID1, @UserID2;
		
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_FRIEND;
		DEALLOCATE curRows_UseForNOTE_FRIEND;
	END;

--------------------------- dbo.COMMENT -----------------------------
go
	CREATE TRIGGER UseForNOTE_COMMENTByPost
	ON dbo.COMMENT AFTER INSERT
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @UserID VARCHAR(11)  
		DECLARE @ObjectID VARCHAR(11)  
		DECLARE @Content VARCHAR(11)
		DECLARE @TimeComment VARCHAR(11)
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_COMMENTByPost CURSOR FOR
			SELECT (SELECT TOP(1) UserID FROM dbo.POST WHERE PostID= Inserted.PostID),Inserted.PostID , Inserted.Content, Inserted.TimeComment
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_UseForNOTE_COMMENTByPost;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_COMMENTByPost INTO @UserID, @ObjectID, @Content, @TimeComment;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			IF NOT EXISTS( SELECT *
			FROM dbo.NOTE_COMMENT
			WHERE UserID= @UserID AND ObjectID= @ObjectID)
				BEGIN
					IF(@UserID !=NULL)
					BEGIN
						INSERT INTO dbo.NOTE_COMMENT
						(
							ObjectID,
							UserID,
							statusNote,
							TimeComment,
							isRead
						)
						VALUES
						(   @ObjectID,    -- CmtID - varchar(11)
							@UserID,      -- UserID - varchar(11)
							'post',    -- statusNote - nvarchar(30)
							DEFAULT, -- TimeComment - datetime
							DEFAULT     -- isRead - bit
							)
					END
				END
				ELSE
				BEGIN
					UPDATE dbo.NOTE_COMMENT
					SET TimeComment= GETDATE(), isRead= 0
					WHERE UserID= @UserID AND ObjectID= @ObjectID
				END
			
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment

			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_COMMENTByPost INTO  @UserID, @ObjectID, @Content, @TimeComment;
		
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_COMMENTByPost;
		DEALLOCATE curRows_UseForNOTE_COMMENTByPost;
	END;
--------------------------- dbo.COMMENTCHILD -----------------------------
go
	CREATE TRIGGER UseForNOTE_COMMENTByComment
	ON dbo.COMMENTCHILD AFTER INSERT
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @UserID VARCHAR(11)  
		DECLARE @ObjectID VARCHAR(11)  
		DECLARE @Content VARCHAR(11)
		DECLARE @TimeComment VARCHAR(11)
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_COMMENTByComment CURSOR FOR
			SELECT (SELECT TOP(1) UserID FROM dbo.COMMENT WHERE dbo.COMMENT.CmtID= Inserted.CmtID),Inserted.CmtID , Inserted.Content, Inserted.TimeComment
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_UseForNOTE_COMMENTByComment;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_COMMENTByComment INTO @UserID, @ObjectID, @Content, @TimeComment;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			IF NOT EXISTS( SELECT *
			FROM dbo.NOTE_COMMENT
			WHERE UserID= @UserID AND ObjectID= @ObjectID)
				BEGIN
					INSERT INTO dbo.NOTE_COMMENT
					(
					    ObjectID,
					    UserID,
					    statusNote,
					    TimeComment,
					    isRead
					)
					VALUES
					(   @ObjectID,    -- CmtID - varchar(11)
					    @UserID,      -- UserID - varchar(11)
					    'comment',    -- statusNote - nvarchar(30)
					    DEFAULT, -- TimeComment - datetime
					    DEFAULT     -- isRead - bit
					    )
				END
				ELSE
				BEGIN
					UPDATE dbo.NOTE_COMMENT
					SET TimeComment= GETDATE(), isRead= 0
					WHERE UserID= @UserID AND ObjectID= @ObjectID
				END
			
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment

			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_COMMENTByComment INTO  @UserID, @ObjectID, @Content, @TimeComment;
		
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_COMMENTByComment;
		DEALLOCATE curRows_UseForNOTE_COMMENTByComment;
	END;
	-------------- trigger for NOTE_COUNT------------------
GO
	CREATE TRIGGER UseForNOTE_COUNT_NOTE_COMMENT
	ON dbo.NOTE_COMMENT AFTER INSERT, UPDATE
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @UserID VARCHAR(11)  
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_COUNT_NOTE_COMMENT CURSOR FOR
			SELECT Inserted.UserID
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_UseForNOTE_COUNT_NOTE_COMMENT;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_COMMENT INTO @UserID;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			UPDATE dbo.NOTE_COUNT
			SET NOTE=  NOTE + 1
			WHERE UserID= @UserID	
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment
			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_COMMENT INTO  @UserID;
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_COUNT_NOTE_COMMENT;
		DEALLOCATE curRows_UseForNOTE_COUNT_NOTE_COMMENT;
	END;
GO
	CREATE  TRIGGER UseForNOTE_COUNT_NOTE_lIKE
	ON dbo.NOTE_lIKE AFTER INSERT, UPDATE
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @UserID VARCHAR(11)  
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_COUNT_NOTE_lIKE CURSOR FOR
			SELECT Inserted.UserID
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_UseForNOTE_COUNT_NOTE_lIKE;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_lIKE INTO @UserID;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			UPDATE dbo.NOTE_COUNT
			SET NOTE=  NOTE + 1
			WHERE UserID= @UserID	
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment
			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_lIKE INTO  @UserID;
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_COUNT_NOTE_lIKE;
		DEALLOCATE curRows_UseForNOTE_COUNT_NOTE_lIKE;
	END;

GO
	CREATE  TRIGGER UseForNOTE_COUNT_NOTE_FRIEND
	ON dbo.NOTE_FRIEND AFTER INSERT, UPDATE
	AS
	BEGIN
			-- Khai báo các biến
		DECLARE @UserID VARCHAR(11)  
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_UseForNOTE_COUNT_NOTE_FRIEND CURSOR FOR
			SELECT Inserted.UserID
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_UseForNOTE_COUNT_NOTE_FRIEND;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_FRIEND INTO @UserID;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			UPDATE dbo.NOTE_COUNT
			SET NOTE=  NOTE + 1
			WHERE UserID= @UserID	
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment
			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_UseForNOTE_COUNT_NOTE_FRIEND INTO  @UserID;
		END;
		-- Đóng CURSOR
		CLOSE curRows_UseForNOTE_COUNT_NOTE_FRIEND;
		DEALLOCATE curRows_UseForNOTE_COUNT_NOTE_FRIEND;
	END;
GO
    CREATE TRIGGER Create_for_note_count_userinfor
	ON dbo.UserInfor AFTER INSERT
	AS 
	BEGIN
		
		DECLARE @UserID VARCHAR(11)  
		-- Khởi tạo CURSOR để duyệt qua từng hàng trong bảng inserted
		DECLARE curRows_Create_for_note_count_userinfor CURSOR FOR
			SELECT  Inserted.UserID
			FROM inserted;
		-- Mở CURSOR
		OPEN curRows_Create_for_note_count_userinfor;

		-- Lấy hàng đầu tiên
		FETCH NEXT FROM curRows_Create_for_note_count_userinfor INTO @UserID;
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Thực hiện câu lệnh cập nhật cho hàng hiện tại
			-- Ví dụ: Cập nhật cột Column3 dựa trên giá trị của cột Column1
			INSERT INTO dbo.NOTE_COUNT
			(
			    UserID,
			    NOTE,
			    MESS
			)
			VALUES
			(   @UserID,   -- UserID - varchar(11)
			    0, -- NOTE - int
			    0  -- MESS - int
			    )
			
		 -- post :là bình luậnt của bài dang
		-- comment: la binh luan tra loi comment

			-- Lấy hàng tiếp theo
			FETCH NEXT FROM curRows_Create_for_note_count_userinfor INTO  @UserID;
		
		END;
		-- Đóng CURSOR
		CLOSE curRows_Create_for_note_count_userinfor;
		DEALLOCATE curRows_Create_for_note_count_userinfor;	
    END 