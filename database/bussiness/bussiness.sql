
/*DROP TABLE price;
DROP TABLE Staff;
DROP TABLE Advertisement;
DROP TABLE Business;*/

CREATE TABLE Business (
	ID INT IDENTITY(1,1) NOT NULL,
	BusinessID AS 'BID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
    UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboBusiness FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
    BrandName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255),
	Mail VARCHAR(255),
	PhoneNumber VARCHAR(15),
	ImageAvatar NVARCHAR(255),
	ImageBackGround NVARCHAR(255),
	NumFlow INT DEFAULT 0,
    intro NVARCHAR(MAX),
	budget MONEY DEFAULT 0,
	TimeCreate DATETIME DEFAULT GETDATE(),
);


CREATE TABLE Advertisement (
    ID INT IDENTITY(1,1) NOT NULL,
	AdvertiserID AS 'AID' + RIGHT('00000000' + CAST(ID AS VARCHAR(8)), 8) PERSISTED PRIMARY KEY,
	BusinessID VARCHAR(11),
	CONSTRAINT fk_BusinessID_dboAdvertisement FOREIGN KEY (BusinessID) REFERENCES dbo.Business(BusinessID),
    Content NVARCHAR(MAX),
	ImagePost NVARCHAR(255),
	--'image', 'gif', 'video'
	TimePost DATETIME DEFAULT GETDATE(),
	NumInterface INT DEFAULT 0,
	NumComment INT DEFAULT 0,
	NumShare INT DEFAULT 0, 
	NumOfShow INT DEFAULT 0,
	Quantity INT DEFAULT 0,
	Status VARCHAR(20),
	-- 'ongoing'  : đang quảng cáo 
	-- 'inactive' : đang tạm hoãn quảng cáo 
	
);



CREATE TABLE Active(
	AdvertiserID VARCHAR(11) NOT NULL PRIMARY KEY,
	CONSTRAINT fk_AdvertiserID_dboactive FOREIGN KEY (AdvertiserID) REFERENCES dbo.Advertisement(AdvertiserID) ON DELETE CASCADE,
	dateShow DATETIME DEFAULT GETDATE()
)














------------------------------daft-------------------------
/*CREATE TABLE Staff(
	BusinessID VARCHAR(11),
	CONSTRAINT fk_BusinessID_dboStaff FOREIGN KEY (BusinessID) REFERENCES dbo.Business(BusinessID),
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id_dboStaff FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	primary key (BusinessID, UserID),
	-- Xem /  chỉnh sửa ( bao gom ca xoa)   /  thêm bài /  đăng bài 
	view_ads BIT,
	edit_ads BIT, 
	add_ads  BIT,
	post_ads BIT,
	num_edit_ads int,
	num_add_ads int,
	num_post_ads int, 
)

CREATE TABLE price(
	PriceID NVARCHAR(20) primary key not null,
	price MONEY
)

INSERT INTO dbo.price
VALUES
(   'image', 0.05 ),
(   'gif', 0.07 ),
(   'video', 0.1 );


CREATE  TABLE PAGERELATION(
	BusinessID VARCHAR(11),
	CONSTRAINT fk_BusinessID_dboPAGERELATION FOREIGN KEY (BusinessID) REFERENCES dbo.Business(BusinessID),
	UserID VARCHAR(11),
	CONSTRAINT fk_user_id2_dboUSERRELATION FOREIGN KEY (UserID) REFERENCES dbo.UserInfor(UserID),
	PRIMARY KEY(BusinessID, UserID),
	isFlow BIT,
);
*/



-- taoj trigger sau khi dbo.AdvertiseView có [numOfShow] xuống về 0 thì tự động xóa


