INSERT INTO dbo.Business
(
    UserID,
    BrandName,
    ADDRESS,
    Mail,
    PhoneNumber,
    ImageAvatar,
    ImageBackGround,
    NumFlow,
    intro,
    budget,
    TimeCreate
)
VALUES
(   'UID00000001',    -- UserID - varchar(11)
    N'Pizza Hut',     -- BrandName - nvarchar(255)
    '379 Hoàng Hoa Thám, TP Đà Nẵng, Việt Nam',    -- Address - nvarchar(255)
    'thaydoinav@gmail.com',    -- Mail - varchar(255)
    '038485951',    -- PhoneNumber - varchar(15)
    'https://img.freepik.com/premium-vector/pizza-logo-template-suitable-restaurant-cafe-logo_607277-267.jpg',    -- ImageAvatar - nvarchar(255)
    'https://static.vecteezy.com/system/resources/previews/005/572/340/original/foggy-landscape-forest-in-the-morning-beautiful-sunrise-mist-cover-mountain-background-at-countryside-winter-free-photo.jpg',    -- ImageBackGround - nvarchar(255)
    DEFAULT, -- NumFlow - int
    'Welcome to my restaurant',    -- intro - nvarchar(max)
    DEFAULT, -- budget - money
    DEFAULT  -- TimeCreate - datetime
    )

SELECT BusinessID, UserID, BrandName, Address, Mail, PhoneNumber, ImageAvatar, ImageBackGround, NumFlow, intro, budget, TimeCreate
FROM dbo.Business
GO
SELECT BusinessID, UserID, BrandName, Address, Mail, PhoneNumber, ImageAvatar, ImageBackGround, NumFlow, intro, budget, TimeCreate
FROM dbo.Businesss
WHERE UserID= ?


DECLARE @InsertedIDs TABLE (BusinessID VARCHAR(11));
INSERT INTO dbo.Business
OUTPUT Inserted.BusinessID INTO @InsertedIDs
VALUES
(   ? ,    -- UserID - varchar(11)
    ? ,     -- BrandName - nvarchar(255)
    ? ,    -- Address - nvarchar(255)
    ? ,    -- Mail - varchar(255)
    ? ,    -- PhoneNumber - varchar(15)
    ? ,    -- ImageAvatar - nvarchar(255)
    ? ,    -- ImageBackGround - nvarchar(255)
    DEFAULT, -- NumFlow - int
    ? ,    -- intro - nvarchar(max)
    DEFAULT, -- budget - money
    DEFAULT  -- TimeCreate - datetime
    );
SELECT BusinessID FROM @InsertedIDs;


DELETE dbo.Business
WHERE BusinessID= ?

go
UPDATE dbo.Business
SET UserID= ? , BrandName = ? , Address = ? , Mail = ? ,
PhoneNumber = ? , ImageAvatar = ? , ImageBackGround = ? , intro = ?
WHERE BusinessID = ?

-------------------------------------------------DBO.STAFF-------------------------------------------------
SELECT *
FROM dbo.Staff
WHERE BusinessID= ? AND UserID= ?


INSERT INTO dbo.Staff
VALUES
(   ? ,   -- BusinessID - varchar(11)
    ? ,   -- UserID - varchar(11)
    ? , -- view_ads - bit
    ? , -- edit_ads - bit
    ? , -- add_ads - bit
    ?   -- post_ads - bit
    )

SELECT BusinessID, UserID, view_ads, edit_ads, add_ads, post_ads
FROM dbo.Staff
WHERE BusinessID= ?

SELECT BusinessID, UserID, view_ads, edit_ads, add_ads, post_ads
FROM dbo.Staff
WHERE BusinessID= ? AND UserID= ?

DELETE dbo.Staff
WHERE BusinessID= ? AND UserID= ? 

go
UPDATE dbo.Staff
SET view_ads= ? , edit_ads= ? , add_ads= ? , post_ads = ?
WHERE BusinessID= ? AND UserID = ?


INSERT INTO dbo.Active
(
    AdvertiserID,
    dateShow
)
VALUES
(   'AID00000002',     -- AdvertiserID - varchar(11)
    DEFAULT -- dateShow - datetime
    )
go
DECLARE @AdvertiserID VARCHAR(11);
SET @AdvertiserID= (SELECT TOP (1) AdvertiserID FROM dbo.Active ORDER BY dateShow);

UPDATE dbo.Advertisement
SET Quantity-=1
WHERE AdvertiserID= @AdvertiserID

UPDATE dbo.Active
SET dateShow= GETDATE()
WHERE AdvertiserID= @AdvertiserID

SELECT AdvertiserID, BusinessID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, NumOfShow, Status, Quantity
FROM dbo.Advertisement
WHERE AdvertiserID = @AdvertiserID


---------------------------------------------------------
SELECT *
FROM dbo.Business
WHERE BusinessID = ? AND UserID = ?



DECLARE @inserted TABLE (AdvertiserID NVARCHAR(11));
INSERT INTO dbo.Advertisement
(
    BusinessID,
    Content,
    ImagePost,
    TimePost,
    NumInterface,
    NumComment,
    NumShare,
    NumOfShow,
    Status
) OUTPUT Inserted.AdvertiserID INTO @inserted
VALUES
(   ? ,    -- BusinessID - varchar(11)
    ? ,    -- Content - nvarchar(max)
    ? ,    -- ImagePost - nvarchar(255)
    DEFAULT, -- TimePost - datetime
    DEFAULT, -- NumInterface - int
    DEFAULT, -- NumComment - int
    DEFAULT, -- NumShare - int
    DEFAULT,    -- NumOfShow - int
    'inactive'     -- Status - varchar(20)
    )
SELECT AdvertiserID FROM @inserted

UPDATE dbo.Advertisement
SET ImagePost= ?
WHERE AdvertiserID = ?


DELETE dbo.Advertisement

WHERE AdvertiserID='AID00000003' 