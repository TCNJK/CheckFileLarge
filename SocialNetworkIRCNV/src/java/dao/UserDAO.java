/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author 84384
 */
public class UserDAO {

    Connection cnn;
    
    public UserDAO() {
        this.cnn = new connection.connection().getConnection();
    }
    public UserDAO(Connection cnn) {
        this.cnn= cnn;
    }
    public ArrayList<User> getProfile() {
        ArrayList<User> profile = new ArrayList<>();
        String Query = "SELECT UserId,FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, ImageUser, ImageBackGround FROM  dbo.UserInfor ";
        try {
            PreparedStatement ps = cnn.prepareStatement(Query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getString(1));
                user.setFullName(rs.getString(2));
                user.setGender(rs.getBoolean(3));
                user.setDOB(rs.getString(4));
                user.setAddress(rs.getString(5));
                user.setImgUser(rs.getString(6));
                user.setCoverImg(rs.getString(7));
                user.setMail(rs.getString(8));
                user.setNation(rs.getString(9));
                user.setPhoneNumber(rs.getString(10));
                profile.add(user);
            }
        } catch (Exception e) {
        }
        return profile;

    }

    public User getUserByID(String userId) {
        String Query = "SELECT UserID, FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, ImageUser, ImageBackGround, NumFriend, NumPost, intro "
                + " FROM  dbo.UserInfor WHERE UserID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(Query);
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new User(rs.getNString(8), rs.getString(9),
                        rs.getString(10), rs.getString(1),
                        rs.getNString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getBoolean(7), rs.getInt(11), rs.getInt(12), rs.getString(13));
            }
        } catch (Exception e) {
            System.out.println("dao.UserDAO.getUserByID()");
            e.printStackTrace();
        } 
        return null;
    }

    public ArrayList<User> getUserBySearch(String keyword) {
        ArrayList<User> profile = new ArrayList<>();
        String query = "SELECT UserId,FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, ImageUser, ImageBackGround\n"
                + "FROM dbo.UserInfor WHERE FullName COLLATE Latin1_General_CI_AI LIKE '%' + ? + '%'";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, keyword);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getString(1));
                user.setFullName(rs.getString(2));
                user.setGender(rs.getBoolean(3));
                user.setDOB(rs.getString(4));
                user.setAddress(rs.getString(5));
                user.setImgUser(rs.getString(6));
                user.setCoverImg(rs.getString(7));
                user.setMail(rs.getString(8));
                user.setNation(rs.getString(9));
                user.setPhoneNumber(rs.getString(10));
                profile.add(user);
            }
        } catch (Exception e) {
        }
        return profile;
    }
//update

    public void updateInfo(User user) {
        String query = "update UserInfor set \n"
                + "FullName =  ? ,\n"
                + "Address =  ? ,\n"
                + "Mail = ? ,\n"
                + "PhoneNumber = ? ,\n"
                + "Dob = ? ,\n"
                + "Gender = ? ,\n"
                + "Nation =      ? ,\n"
                + "intro =      ? \n"
                //                + "ImageUser = ? ,\n"
                //                + "ImageBackGround = ? \n"
                + "where UserID = ? ;";
//        String query1 = "update UserInfor set \n"
//                + "FullName = N'NgocAndepccccctraicc',\n"
//                + "Address =N'DaNang',\n"
//                + "Mail ='ngocan2002@gmail.com',\n"
//                + "PhoneNumber = '0945227000',\n"
//                + "Dob = '02-12-2002',\n"
//                + "Gender = 0,\n"
//                + "Nation =N'Hue',\n"
//                + "ImageUser = '',\n"
//                + "ImageBackGround = ''\n"
//                + "where UserID = 'UID00000001';";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setNString(1, user.getFullName());
            ps.setNString(2, user.getAddress());
            ps.setString(3, user.getMail());
            ps.setString(4, user.getPhoneNumber());
            ps.setString(5, user.getDOB());
            ps.setBoolean(6, user.isGender());
            ps.setNString(7, user.getNation());
            ps.setNString(8, user.getIntro());
//            ps.setString(8, user.getImgUser());
//            ps.setString(9, user.getCoverImg());
            ps.setString(9, user.getUserID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.UserDAO.updateInfo()");
            e.printStackTrace();
        }
    }

    public void updateAvatar(String filename, String UserID) {
        String query = "update UserInfor set ImageUser =  ? where UserID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, filename);
            ps.setString(2, UserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.UserDAO.updateAvatar()");
            e.printStackTrace();
        }
    }

    public void updateBackground(String filename, String UserID) {
        String query = "update UserInfor set ImageBackGround =  ? where UserID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, filename);
            ps.setString(2, UserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.UserDAO.updateBackground()");
            e.printStackTrace();
        }

    }

    public ArrayList<User> getUserFriend(String id, int offset) {
        ArrayList<User> profile = new ArrayList<>();
        String query = "DECLARE @UserID VARCHAR(11)= ? ;\n"
                + "	DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "	DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "	SELECT  UserInfor.UserID,FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, ImageUser, ImageBackGround, NumFriend, NumPost, intro\n"
                + "	FROM(\n"
                + "	SELECT UserID2\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE (UserID1= @UserID AND isFriend= 1)\n"
                + "	UNION ALL\n"
                + "	SELECT UserID1\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE (UserID2= @UserID AND isFriend= 1)) AS friend\n"
                + "	INNER JOIN dbo.UserInfor ON UserInfor.UserID = friend.UserID2\n"
                + "	ORDER BY TimeCreate\n"
                + "	OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "	FETCH NEXT @FetchCount ROWS ONLY;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getNString(8), rs.getString(9),
                        rs.getString(10), rs.getString(1),
                        rs.getNString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getBoolean(7), rs.getInt(11), rs.getInt(12), rs.getString(13));
                
                profile.add(user);
            }
        } catch (Exception e) {
            System.out.println("dao.UserDAO.getUserFriend()");
            e.printStackTrace();
        }
        return profile;
    }
    public ArrayList<User> getUserFriend(String id, int offset, int num) {
        ArrayList<User> profile = new ArrayList<>();
        String query = "DECLARE @UserID VARCHAR(11)= ? ;\n"
                + "	DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "	DECLARE @FetchCount INT = ?; -- Số bài post muốn lấy thêm\n"
                + "	SELECT  UserInfor.UserID,FullName, Address, Mail, PhoneNumber, Dob, Gender, Nation, ImageUser, ImageBackGround, NumFriend, NumPost, intro\n"
                + "	FROM(\n"
                + "	SELECT UserID2\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE (UserID1= @UserID AND isFriend= 1)\n"
                + "	UNION ALL\n"
                + "	SELECT UserID1\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE (UserID2= @UserID AND isFriend= 1)) AS friend\n"
                + "	INNER JOIN dbo.UserInfor ON UserInfor.UserID = friend.UserID2\n"
                + "	ORDER BY TimeCreate\n"
                + "	OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "	FETCH NEXT @FetchCount ROWS ONLY;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ps.setInt(2, offset);
            ps.setInt(3, num);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getNString(8), rs.getString(9),
                        rs.getString(10), rs.getString(1),
                        rs.getNString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5),
                        rs.getString(6), rs.getBoolean(7), rs.getInt(11), rs.getInt(12), rs.getString(13));
                user.toString();
                profile.add(user);
            }
        } catch (Exception e) {
            System.out.println("dao.UserDAO.getUserFriend()");
            e.printStackTrace();
        }
        return profile;
    }
}
