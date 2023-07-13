/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import model.Business;
import model.Advertisement;

/**
 *
 * @author van12
 */
public class BusinessDAO {

    Connection cnn;

    public BusinessDAO() {
        cnn = new connection.connection().getConnection();
    }

    public ArrayList<Business> getBusiness() {
        ArrayList<Business> businessList = new ArrayList<>();
        String query = "SELECT BusinessID, UserID, BrandName, Address, Mail, PhoneNumber, ImageAvatar, ImageBackGround, NumFlow, intro, budget, TimeCreate\n"
                + "FROM dbo.Business";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                businessList.add(new Business(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getString(8),
                        rs.getInt(9), rs.getString(10), rs.getFloat(11), rs.getString(12)));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getBusiness()");
            e.printStackTrace();
        }
        return businessList;
    }

    public Business getBusinessByBusinessID(String BusinessID) {
        String query = "SELECT BusinessID, UserID, BrandName, Address, Mail, PhoneNumber, ImageAvatar, ImageBackGround, NumFlow, intro, budget, TimeCreate\n"
                + "FROM dbo.Business\n"
                + "WHERE BusinessID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Business(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getString(8),
                        rs.getInt(9), rs.getString(10), rs.getFloat(11), rs.getString(12));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getBusinessByBusinessID()");
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Business> getBusinessByUserID(String UserID) {
        String query = "SELECT BusinessID, UserID, BrandName, Address, Mail, PhoneNumber, ImageAvatar, ImageBackGround, NumFlow, intro, budget, TimeCreate\n"
                + "FROM dbo.Business\n"
                + "WHERE UserID= ? ";
        ArrayList<Business> businessList = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                businessList.add(new Business(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getString(7), rs.getString(8),
                        rs.getInt(9), rs.getString(10), rs.getFloat(11), rs.getString(12)));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getBusinessByUserID()");
            e.printStackTrace();
        }
        return businessList;
    }

    public String insert(Business business) {
        String query = "DECLARE @InsertedIDs TABLE (BusinessID VARCHAR(11));\n"
                + "INSERT INTO dbo.Business\n"
                + "OUTPUT Inserted.BusinessID INTO @InsertedIDs\n"
                + "VALUES\n"
                + "(   ? ,    -- UserID - varchar(11)\n"
                + "    ? ,     -- BrandName - nvarchar(255)\n"
                + "    ? ,    -- Address - nvarchar(255)\n"
                + "    ? ,    -- Mail - varchar(255)\n"
                + "    ? ,    -- PhoneNumber - varchar(15)\n"
                + "    ? ,    -- ImageAvatar - nvarchar(255)\n"
                + "    ? ,    -- ImageBackGround - nvarchar(255)\n"
                + "    DEFAULT, -- NumFlow - int\n"
                + "    ? ,    -- intro - nvarchar(max)\n"
                + "    DEFAULT, -- budget - money\n"
                + "    DEFAULT  -- TimeCreate - datetime\n"
                + "    );\n"
                + "SELECT BusinessID FROM @InsertedIDs;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, business.getUserID());
            ps.setString(2, business.getBrandName());
            ps.setString(3, business.getAddress());
            ps.setString(4, business.getMail());
            ps.setString(5, business.getPhoneNumber());
            ps.setString(6, business.getImageAvatar());
            ps.setString(7, business.getImageBackGround());
            ps.setString(8, business.getIntro());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.insertBusiness()");
            e.printStackTrace();
        }
        return null;
    }

    public void delete(String BusinessID) {
        String query = "DELETE dbo.Business\n"
                + "WHERE BusinessID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.deleteBusinessByBusinessID()");
            e.printStackTrace();
        }
    }

    public void update(Business business) {
        String query = "UPDATE dbo.Business\n"
                + "SET UserID= ? , BrandName = ? , Address = ? , Mail = ? ,\n"
                + "PhoneNumber = ? , intro = ?, budget= ?\n"
                + "WHERE BusinessID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, business.getUserID());
            ps.setString(2, business.getBrandName());
            ps.setString(3, business.getAddress());
            ps.setString(4, business.getMail());
            ps.setString(5, business.getPhoneNumber());
            ps.setString(6, business.getIntro());
            ps.setFloat(7, business.getBudget());
            ps.setString(8, business.getBusinessID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.updateBusiness()");
            e.printStackTrace();
        }
    }

    public ArrayList<Advertisement> getAdvertisements() {
        ArrayList<Advertisement> advertisements = new ArrayList<>();
        String query = "SELECT AdvertiserID, BusinessID, Content, ImagePost, "
                + "TimePost, NumInterface, NumComment, NumShare, NumOfShow, Status, Quantity\n"
                + "FROM dbo.Advertisement";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                advertisements.add(new Advertisement(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getString(10), rs.getInt(11)));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getAdvertisements()");
            e.printStackTrace();
        }
        return advertisements;
    }

    public ArrayList<Advertisement> getAdvertisements(String BusinessID) {
        ArrayList<Advertisement> advertisements = new ArrayList<>();
        String query = "SELECT AdvertiserID, BusinessID, Content, ImagePost, "
                + "TimePost, NumInterface, NumComment, NumShare, NumOfShow, Status, Quantity\n"
                + "FROM dbo.Advertisement\n"
                + "WHERE BusinessID = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String content = rs.getString(3);
                advertisements.add(new Advertisement(rs.getString(1), rs.getString(2), content, rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getString(10), rs.getInt(11)));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getAdvertisements()");
            e.printStackTrace();
        }
        return advertisements;
    }

    public Advertisement getAdvertisementByAdvertiserID(String AdvertiserID) {
        String query = "SELECT AdvertiserID, BusinessID, Content, ImagePost, "
                + "TimePost, NumInterface, NumComment, NumShare, NumOfShow, Status, Quantity\n"
                + "FROM dbo.Advertisement\n"
                + "WHERE AdvertiserID = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, AdvertiserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Advertisement(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getString(10), rs.getInt(11));
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getAdvertisementByAdvertiserID()");
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkPermission(String BusinessID, String UserID) {
        String query = "SELECT *\n"
                + "FROM dbo.Business\n"
                + "WHERE BusinessID = ? AND UserID = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ps.setString(2, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.checkPermission()");
            e.printStackTrace();
        }
        return false;
    }

    public String insertAdvertisement(Advertisement advertisement) {
        String query = "DECLARE @inserted TABLE (AdvertiserID NVARCHAR(11));\n"
                + "INSERT INTO dbo.Advertisement\n"
                + "(\n"
                + "    BusinessID,\n"
                + "    Content,\n"
                + "    ImagePost,\n"
                + "    TimePost,\n"
                + "    NumInterface,\n"
                + "    NumComment,\n"
                + "    NumShare,\n"
                + "    NumOfShow,\n"
                + "    Status\n"
                + ") OUTPUT Inserted.AdvertiserID INTO @inserted\n"
                + "VALUES\n"
                + "(   ? ,    -- BusinessID - varchar(11)\n"
                + "    ? ,    -- Content - nvarchar(max)\n"
                + "    ? ,    -- ImagePost - nvarchar(255)\n"
                + "    DEFAULT, -- TimePost - datetime\n"
                + "    DEFAULT, -- NumInterface - int\n"
                + "    DEFAULT, -- NumComment - int\n"
                + "    DEFAULT, -- NumShare - int\n"
                + "    DEFAULT,    -- NumOfShow - int\n"
                + "    'inactive'     -- Status - varchar(20)\n"
                + "    )\n"
                + "SELECT AdvertiserID FROM @inserted";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, advertisement.getBusinessID());
            ps.setString(2, advertisement.getContent());
            ps.setString(3, advertisement.getImagePost());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.insertAdvertisement()");
            e.printStackTrace();
        }
        return null;
    }

    public void DeleteActive(String AID) {
        String query = "DELETE dbo.Active\n"
                + "		WHERE AdvertiserID= ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, AID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.insertAdvertisement()");
            e.printStackTrace();
        }
    }

    public void AddActive(String AID) {
        String query = "INSERT INTO dbo.Active\n"
                + "	(\n"
                + "	    AdvertiserID,\n"
                + "	    dateShow\n"
                + "	)\n"
                + "	VALUES\n"
                + "	(   ? ,     -- AdvertiserID - varchar(11)\n"
                + "	    DEFAULT -- dateShow - datetime\n"
                + "	    )";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, AID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.insertAdvertisement()");
            e.printStackTrace();
        }
    }

    public void deleteAdvertisement(String AdvertiserID) {
        String query = "DELETE dbo.Advertisement\n"
                + "	WHERE AdvertiserID= ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, AdvertiserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.deleteAdvertisement()");
            e.printStackTrace();
        }
    }

    public void updateAdvertisementContent(Advertisement advertisement) {
        String query = "UPDATE dbo.Advertisement\n"
                + "SET Content= ?, Quantity= ?, Status= ?\n"
                + "WHERE AdvertiserID = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, advertisement.getContent());
            ps.setInt(2, advertisement.getQuantity());
            ps.setString(3, advertisement.getStatus());
            ps.setString(4, advertisement.getAdvertiserID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.updateAdvertisementContent()");
            e.printStackTrace();
        }
    }

    public void updateAdvertisementImagePost(Advertisement advertisement) {
        String query = "UPDATE dbo.Advertisement\n"
                + "SET ImagePost= ?\n"
                + "WHERE AdvertiserID = ? AND BusinessID= ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, advertisement.getImagePost());
            ps.setString(2, advertisement.getAdvertiserID());
            ps.setString(3, advertisement.getBusinessID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.updateAdvertisementImagePost()");
            e.printStackTrace();
        }
    }
}
