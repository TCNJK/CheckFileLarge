/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import controller.Text;
import java.sql.*;
import java.util.ArrayList;
import java.util.Random;
import jdk.vm.ci.code.CodeUtil;
import model.Post;
import model.PostShare;
import model.PostUser;
import model.Advertisement;

/**
 *
 * @author van12
 */
public class PostDAO {

    private Connection cnn;
    Text text;
    private String IDUserCurrent;

    public PostDAO(String IDUserCurrent) {
        cnn = new connection.connection().getConnection();
        text = new Text();
        this.IDUserCurrent = IDUserCurrent;
    }

    public PostDAO(Connection cnn, String IDUserCurrent) {
        this.cnn = cnn;
        text = new Text();
        this.IDUserCurrent = IDUserCurrent;
    }
    String getPostUser = "SELECT PostID, POST.UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName, FullName, ImageUser\n"
            + "            FROM dbo.POST\n"
            + "            INNER JOIN dbo.UserInfor ON UserInfor.UserID = POST.UserID\n"
            + "			INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID";
    String getPostShareUser = "	SELECT c.UserID, c.FullName, c.ImageUser, \n"
            + "            b.TimePost, b.Content, a.PostID, a.ShareID, a.UserID, \n"
            + "            d.FullName, d.ImageUser,a.Content,\n"
            + "            a.TimeShare, a.NumInterface, a.NumComment, e.PrivacyName, b.ImagePost\n"
            + "            FROM dbo.POSTSHARE a\n"
            + "            INNER JOIN dbo.POST b ON b.PostID = a.PostID\n"
            + "            INNER JOIN dbo.UserInfor c ON b.UserID= c.UserID\n"
            + "            INNER JOIN dbo.UserInfor d ON d.UserID= a.UserID\n"
            + "			INNER JOIN dbo.Privacy e ON e.PrivacyID = a.PrivacyID ";

    String getPostShareUserByID = "SELECT c.UserID, c.FullName, c.ImageUser, \n"
            + "            b.TimePost, b.Content, a.PostID, a.ShareID, a.UserID, \n"
            + "            d.FullName, d.ImageUser,a.Content,\n"
            + "            a.TimeShare, a.NumInterface, a.NumComment, e.PrivacyName, b.ImagePost\n"
            + "            FROM dbo.POSTSHARE a\n"
            + "            INNER JOIN dbo.POST b ON b.PostID = a.PostID\n"
            + "            INNER JOIN dbo.UserInfor c ON b.UserID= c.UserID\n"
            + "            INNER JOIN dbo.UserInfor d ON d.UserID= a.UserID\n"
            + "             INNER JOIN dbo.Privacy e ON e.PrivacyID = a.PrivacyID\n"
            + "            WHERE a.UserID= ? ";
    String getPostUserByID = "SELECT PostID, POST.UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName, FullName, ImageUser\n"
            + "            FROM dbo.POST\n"
            + "            INNER JOIN dbo.UserInfor ON UserInfor.UserID = POST.UserID\n"
            + "			INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID\n"
            + "            WHERE POST.UserID= ? ";

    public ArrayList<Post> getPostUser() {
        ArrayList<Post> postUser = new ArrayList<>();

        try {
            PreparedStatement ps = cnn.prepareStatement(getPostUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                postUser.add(new PostUser(rs.getString(1), rs.getString(2),
                        text.changeUTF8(rs.getNString(3)), rs.getString(4),
                        rs.getString(5), rs.getInt(6),
                        rs.getInt(7), rs.getInt(8),
                        rs.getString(9), text.changeUTF8(rs.getNString(10)),
                        rs.getString(11), IDUserCurrent));

            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostUser()");
            e.printStackTrace();
        }
        return postUser;
    }

    public ArrayList<Post> getPostShareUser() {
        ArrayList<Post> postUser = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(getPostShareUser);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                postUser.add(new PostShare(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), text.changeUTF8(rs.getNString(5)), rs.getString(6), rs.getString(7), rs.getString(8),
                        text.changeUTF8(rs.getNString(9)), rs.getString(10), text.changeUTF8(rs.getNString(11)),
                        rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), rs.getString(16), this.IDUserCurrent));
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostShareUser()");
            e.printStackTrace();
        }
        return postUser;
    }

    public ArrayList<Post> getPostPersonalPage() {
        ArrayList<Post> postUser = new ArrayList<>();
        postUser.addAll(getPostUser());
        postUser.addAll(getPostShareUser());
        return postUser;
    }

    public ArrayList<Post> getPostUser(String id) {
        ArrayList<Post> postUser = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(getPostUserByID);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                postUser.add(new PostUser(rs.getString(1), rs.getString(2),
                        rs.getNString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6),
                        rs.getInt(7), rs.getInt(8),
                        rs.getString(9), rs.getNString(10),
                        rs.getString(11), IDUserCurrent));

            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostUser()");
            e.printStackTrace();
        }
        return postUser;
    }

    public ArrayList<Post> getPostShareUser(String id) {
        ArrayList<Post> postUser = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(getPostShareUserByID);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                postUser.add(new PostShare(rs.getString(1), rs.getNString(2), rs.getString(3),
                        rs.getString(4), rs.getNString(5), rs.getString(6), rs.getString(7), rs.getString(8),
                        rs.getNString(9), rs.getString(10), rs.getNString(11),
                        rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), rs.getString(16), this.IDUserCurrent));
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostShareUser()");
            e.printStackTrace();
        }
        return postUser;
    }

    public ArrayList<Post> getPostPersonalPage(String id) {
        ArrayList<Post> postUser = new ArrayList<>();
        postUser.addAll(getPostUser(id));
        postUser.addAll(getPostShareUser(id));
        postUser.sort((o1, o2) -> o2.getTimePost().compareTo(o1.getTimePost()));
        postUser.forEach((t) -> {
            if (t instanceof PostUser) {
                System.out.println(((PostUser) t).toString());
            } else if (t instanceof PostShare) {
                System.out.println(((PostShare) t).toString());
            }
        });
        return postUser;
    }

    // lấy bài post theo PostID hoặc ShareID
    public PostUser getPostUserByPostID(String PostID) {
        String query = "SELECT PostID, POST.UserID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, PrivacyName, FullName, ImageUser\n"
                + "	 FROM dbo.POST\n"
                + "	 INNER JOIN dbo.UserInfor ON UserInfor.UserID = POST.UserID\n"
                + "	INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID\n"
                + "	WHERE PostID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, PostID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new PostUser(rs.getString(1), rs.getString(2),
                        rs.getNString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6),
                        rs.getInt(7), rs.getInt(8),
                        rs.getString(9), rs.getNString(10),
                        rs.getString(11), this.IDUserCurrent);

            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostUser()");
            e.printStackTrace();
        }
        return null;
    }

    public Advertisement getAdvertisement() {
        String query = "DECLARE @AdvertiserID VARCHAR(11);\n"
                + "SET @AdvertiserID= (SELECT TOP (1) AdvertiserID FROM dbo.Active ORDER BY dateShow);\n"
                + "\n"
                + "UPDATE dbo.Advertisement\n"
                + "SET Quantity-=1\n"
                + "WHERE AdvertiserID= @AdvertiserID\n"
                + "\n"
                + "UPDATE dbo.Active\n"
                + "SET dateShow= GETDATE()\n"
                + "WHERE AdvertiserID= @AdvertiserID\n"
                + "\n"
                + "SELECT AdvertiserID, BusinessID, Content, ImagePost, TimePost, NumInterface, NumComment, NumShare, NumOfShow, Status, Quantity\n"
                + "FROM dbo.Advertisement\n"
                + "WHERE AdvertiserID = @AdvertiserID";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Advertisement(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getInt(9), rs.getString(10), rs.getInt(11), IDUserCurrent);
            }
        } catch (Exception e) {
            System.out.println("dao.BusinessDAO.getAdvertisementByAdvertiserID()");
            e.printStackTrace();
        }
        return null;
    }

    public Post getPostByID(String PostID) {
        if (PostOrShare(PostID)) {
            return getPostUserByPostID(PostID);
        }
        return getPostShareByShareID(PostID);
    }

    public PostShare getPostShareByShareID(String ShareID) {
        try {
            String query = "SELECT c.UserID, c.FullName, c.ImageUser, \n"
                    + "            b.TimePost, b.Content, a.PostID, a.ShareID, a.UserID, \n"
                    + "            d.FullName, d.ImageUser,a.Content,\n"
                    + "            a.TimeShare, a.NumInterface, a.NumComment, e.PrivacyName, b.ImagePost\n"
                    + "            FROM dbo.POSTSHARE a\n"
                    + "            INNER JOIN dbo.POST b ON b.PostID = a.PostID\n"
                    + "            INNER JOIN dbo.UserInfor c ON b.UserID= c.UserID\n"
                    + "            INNER JOIN dbo.UserInfor d ON d.UserID= a.UserID"
                    + "            INNER JOIN dbo.Privacy e ON e.PrivacyID = a.PrivacyID\n"
                    + "WHERE a.ShareID= ? ";
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, ShareID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new PostShare(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
                        rs.getString(9), rs.getString(10), rs.getString(11),
                        rs.getString(12), rs.getInt(13), rs.getInt(14), rs.getString(15), rs.getString(16), this.IDUserCurrent);
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostShareUser()");
            e.printStackTrace();
        }
        return null;
    }
// cũng là lấy bài post, nhưng có trọng số 
    //-- hiện bài post bản thân

    public boolean PostOrShare(String PostID) {
        if (PostID.substring(0, 3).equalsIgnoreCase("PID")) {
            return true;
        }
        return false;
    }

    public ArrayList<Post> getPostForHomePage(String id, int offset) {
        ArrayList<Post> post = new ArrayList<>();
        String query = "DECLARE @id NVARCHAR(11)= ? \n"
                + "		DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "		DECLARE @FetchCount INT = 10; -- Số bài post muốn lấy thêm;\n"
                + "		DECLARE @table TABLE (FriendID NVARCHAR(11))\n"
                + "		INSERT INTO @table (FriendID)\n"
                + "			VALUES (@id);\n"
                + "\n"
                + "		INSERT INTO @table (FriendID)\n"
                + "		SELECT CASE\n"
                + "			WHEN UserID1 = @id THEN UserID2\n"
                + "			WHEN UserID2 = @id THEN UserID1\n"
                + "		END AS FriendID\n"
                + "		FROM dbo.USERRELATION\n"
                + "		WHERE (UserID1 = @id OR UserID2 = @id) AND isFriend = 1\n"
                + "\n"
                + "\n"
                + "		SELECT PostID, TimePost, PrivacyID\n"
                + "			FROM dbo.POST\n"
                + "			INNER JOIN @table ON UserID= FriendID\n"
                + "			WHERE (PrivacyID='FRIEND' OR PrivacyID='Public')\n"
                + "			UNION ALL\n"
                + "		SELECT ShareID, TimeShare, PrivacyID\n"
                + "			FROM dbo.POSTSHARE\n"
                + "			INNER JOIN @table ON UserID= FriendID\n"
                + "			WHERE (PrivacyID='FRIEND' OR PrivacyID='Public')\n"
                + "		ORDER BY TimePost DESC\n"
                + "		OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "		FETCH NEXT @FetchCount ROWS ONLY;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String PostID = rs.getString(1);
                if (PostOrShare(PostID)) {
                    post.add(getPostUserByPostID(PostID));
                } else {
                    post.add(getPostShareByShareID(PostID));
                }
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostForProfileInfo()");
            e.printStackTrace();
        }
        Advertisement advertisement = getAdvertisement();
        if (advertisement != null) {
            int rand = new Random().nextInt(post.size()) + 1;
            post.add(rand, advertisement);
        }

        return post;
    }

    public ArrayList<Post> getPostForProfileInfo(String id, int offset) {
        ArrayList<Post> post = new ArrayList<>();
        String query = "DECLARE @id NVARCHAR(11)= ? \n"
                + "	DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "	DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "\n"
                + "	SELECT PostID, TimePost, PrivacyID\n"
                + "	FROM dbo.POST\n"
                + "	WHERE UserID= @id\n"
                + "	UNION ALL\n"
                + "    SELECT ShareID, TimeShare, PrivacyID\n"
                + "	FROM dbo.POSTSHARE\n"
                + "	WHERE UserID= @id\n"
                + "	ORDER BY TimePost DESC\n"
                + "	OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "	FETCH NEXT @FetchCount ROWS ONLY;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String PostID = rs.getString(1);
                if (PostOrShare(PostID)) {
                    post.add(getPostUserByPostID(PostID));
                } else {
                    post.add(getPostShareByShareID(PostID));
                }
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostForProfileInfo()");
            e.printStackTrace();
        }
        return post;
    }

    /*-- hiện bài post nguoi khac người khác 
    -- nhâpj id: @id người dùng đang dùng tài khoản
    -- @uid id người dùng khác
    -- @Offset cụm đang hiện post*/
    public ArrayList<Post> getPostForProfileUser(String id, String uid, int offset) {
        ArrayList<Post> post = new ArrayList<>();
        String query = "DECLARE @id NVARCHAR(11)= ? ;\n"
                + "	DECLARE @uid NVARCHAR(11)= ? ;\n"
                + "	DECLARE @u1 NVARCHAR(11), @u2 NVARCHAR(11), @isFriend bit;\n"
                + "	DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "	DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "	IF (@id > @uid)\n"
                + "	BEGIN\n"
                + "		SET @u1 = @id;\n"
                + "		SET @u2 = @uid;\n"
                + "	END\n"
                + "	ELSE\n"
                + "	BEGIN\n"
                + "		SET @u2 = @id;\n"
                + "		SET @u1 = @uid;\n"
                + "	END\n"
                + "\n"
                + "	SET @isFriend= (SELECT isFriend\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE UserID1= @u1 AND UserID2=@u2)\n"
                + "	IF(@isFriend=1)\n"
                + "		BEGIN\n"
                + "			SELECT PostID, TimePost, PrivacyID\n"
                + "			FROM dbo.POST\n"
                + "			WHERE UserID= @uid AND (PrivacyID='FRIEND' OR PrivacyID='Public')\n"
                + "			UNION ALL\n"
                + "			SELECT ShareID, TimeShare, PrivacyID\n"
                + "			FROM dbo.POSTSHARE\n"
                + "			WHERE UserID= @uid AND (PrivacyID='FRIEND' OR PrivacyID='Public')\n"
                + "			ORDER BY TimePost DESC\n"
                + "			OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "			FETCH NEXT @FetchCount ROWS ONLY;\n"
                + "		end \n"
                + "	ELSE \n"
                + "		BEGIN\n"
                + "			SELECT PostID, TimePost, PrivacyID\n"
                + "			FROM dbo.POST\n"
                + "			WHERE UserID= @uid  AND (PrivacyID='Public') \n"
                + "			UNION ALL\n"
                + "			SELECT ShareID, TimeShare, PrivacyID\n"
                + "			FROM dbo.POSTSHARE\n"
                + "			WHERE UserID= @uid AND (PrivacyID='Public') \n"
                + "			ORDER BY TimePost DESC\n"
                + "			OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "			FETCH NEXT @FetchCount ROWS ONLY;\n"
                + "		End ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ps.setString(2, uid);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String PostID = rs.getString(1);
                if (PostOrShare(PostID)) {
                    post.add(getPostUserByPostID(PostID));
                } else {
                    post.add(getPostShareByShareID(PostID));
                }
            }
        } catch (Exception e) {
            System.out.println("dao.PostDAO.getPostForProfileUser()");
            e.printStackTrace();
        }
        return post;
    }
/// load 5 bài post duy nhất
}
