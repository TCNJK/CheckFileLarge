GO
    CREATE TRIGGER Add_Path_For_Bussiness_INSERT
	ON dbo.Business AFTER INSERT
	AS
	BEGIN
		UPDATE dbo.Business
		SET ImageAvatar= CASE
			WHEN ImageAvatar= '' THEN ''
			else
			ImageAvatar
			end
		WHERE BusinessID= (SELECT BusinessID FROM INSERTed);

		UPDATE dbo.Business
		SET ImageBackGround= CASE
			WHEN ImageBackGround= '' THEN ''
			else
			ImageBackGround
			end
		WHERE BusinessID= (SELECT BusinessID FROM INSERTed);
	END
GO
   CREATE TRIGGER Add_Path_For_Bussiness_UPDATE
	ON dbo.Business AFTER UPDATE
	AS
	BEGIN
		IF UPDATE(ImageAvatar) 
		BEGIN
			UPDATE p
			SET p.ImageAvatar = CASE
					WHEN p.ImageAvatar = '' THEN ''
					ELSE 'data/business/'+p.BusinessID+'/avatar/'+p.ImageAvatar
				END
			FROM dbo.Business p
			INNER JOIN INSERTED i ON p.BusinessID = i.BusinessID
		END
		IF UPDATE(ImageBackGround) 
		BEGIN
			UPDATE p
			SET p.ImageBackGround = CASE
					WHEN p.ImageBackGround = '' THEN ''
					ELSE 'data/business/'+p.BusinessID+'/background/'+p.ImageBackGround
				END
			FROM dbo.Business p
			INNER JOIN INSERTED i ON p.BusinessID = i.BusinessID
		END
	END

GO 
CREATE TRIGGER Add_Path_For_Advertise_INSERT
	ON dbo.Advertisement AFTER INSERT
	AS
	BEGIN
		UPDATE dbo.Advertisement
		SET ImagePost= CASE
			WHEN ImagePost= '' THEN ''
			else
			ImagePost
			end
		WHERE AdvertiserID= (SELECT AdvertiserID FROM INSERTed)
	END
	
GO
   CREATE TRIGGER Add_Path_For_Advertise_UPDATE
	ON dbo.Advertisement AFTER UPDATE
	AS
	BEGIN
		IF UPDATE(ImagePost) 
		BEGIN
			UPDATE p
			SET p.ImagePost = CASE
					WHEN p.ImagePost = '' THEN ''
					ELSE 'data/business/'+p.BusinessID+'/' + p.AdvertiserID+'/post/'+p.ImagePost
				END
			FROM dbo.Advertisement p
			INNER JOIN INSERTED i ON p.AdvertiserID = i.AdvertiserID
		END
		IF UPDATE(Quantity) 
		BEGIN
			UPDATE p
				SET p.Status= 'inactive'
			FROM dbo.Advertisement p
			INNER JOIN INSERTED i ON p.AdvertiserID = i.AdvertiserID
			WHERE p.Quantity= 0
			DELETE dbo.Active
			WHERE AdvertiserID= (SELECT TOP (1)AdvertiserID FROM dbo.Advertisement WHERE Quantity= 0)
		END 
	END

GO 
	CREATE TRIGGER Active_Advertisement
	ON dbo.Active AFTER INSERT
	AS
	BEGIN
		UPDATE dbo.Advertisement
		SET Status= 'ongoing'
		WHERE AdvertiserID= (SELECT AdvertiserID FROM Inserted)
	END

GO 
	CREATE TRIGGER InActive_Advertisement
	ON dbo.Active AFTER DELETE
	AS
	BEGIN
		UPDATE dbo.Advertisement
		SET Status= 'inactive'
		WHERE AdvertiserID= (SELECT AdvertiserID FROM Deleted)
	END

