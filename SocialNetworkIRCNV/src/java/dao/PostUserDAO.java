/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import controller.Text;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author 84384
 */
public class PostUserDAO {

    /**
     * @param args the command line arguments
     */
    Connection cnn;
    private String IDUserCurrent;

    public PostUserDAO(String IDUserCurrent) {
        cnn = new connection.connection().getConnection();
        this.IDUserCurrent = IDUserCurrent;
    }
    String updatePost = "Update POST\n"
            + "		set Content= ? , ImagePost= ?\n"
            + "		where PostID= ? ";

    String updatePostWithoutImg = "Update POST\n"
            + "		set Content= ? \n"
            + "		where PostID= ? ";

    
    
    String checkExistPostUser = "SELECT *\n"
            + "FROM dbo.POST\n"
            + "WHERE PostID= ? AND UserID= ? ";
    String checkExistPostShareUser = "SELECT *\n"
            + "FROM dbo.POSTSHARE\n"
            + "WHERE ShareID= ? AND UserID= ? ";

    //------------------------------//
    String newPost = "DECLARE @InsertedIDs TABLE (PostID VARCHAR(11));\n"
            + "	INSERT INTO dbo.POST\n"
            + "(\n"
            + "    UserID,\n"
            + "    Content,\n"
            + "    ImagePost,\n"
            + "    TimePost,\n"
            + "    NumInterface,\n"
            + "    NumComment,\n"
            + "    NumShare,\n"
            + "    PrivacyID\n"
            + ")\n"
            + "OUTPUT Inserted.PostID INTO @InsertedIDs\n"
            + "VALUES\n"
            + "(   ? ,    -- UserID - varchar(11)\n"
            + "    ? ,    -- Content - nvarchar(max)\n"
            + "    ? ,    -- ImagePost - nvarchar(255)\n"
            + "    DEFAULT, -- TimePost - datetime\n"
            + "    DEFAULT, -- NumInterface - int\n"
            + "    DEFAULT, -- NumComment - int\n"
            + "    DEFAULT, -- NumShare - int\n"
            + "    ?  -- PrivacyID - varchar(11)\n"
            + "    );\n"
            + "SELECT PostID FROM @InsertedIDs;";
    String createPostShare = "	DECLARE @InsertedIDs TABLE (ShareID VARCHAR(11));\n"
            + "            	INSERT INTO dbo.POSTSHARE\n"
            + "            (\n"
            + "            	    UserID,\n"
            + "            	    PostID,\n"
            + "            	    Content,\n"
            + "            	    TimeShare,\n"
            + "            	    NumInterface,\n"
            + "            	    NumComment,\n"
            + "            	    PrivacyID\n"
            + "            	)\n"
            + "            	OUTPUT Inserted.ShareID INTO @InsertedIDs\n"
            + "            	VALUES\n"
            + "            	(   ? ,    -- UserID - varchar(11)\n"
            + "            	    ? ,    -- PostID - varchar(11)\n"
            + "            	    ? ,    -- Content - nvarchar(max)\n"
            + "            	    DEFAULT, -- TimeShare - datetime\n"
            + "            	    DEFAULT, -- NumInterface - int\n"
            + "            	    DEFAULT, -- NumComment - int\n"
            + "            	    ?  -- PrivacyID - varchar(11)\n"
            + "            	    )\n"
            + "            SELECT ShareID FROM @InsertedIDs;";

    public void updatePost(String PostID, String UserID, String Content, String imgPost) {
        try {
            PreparedStatement ps = cnn.prepareStatement(updatePost);
            ps.setString(1, Content);
            ps.setString(2, imgPost);
//            ps.setBoolean(3, Public.equals("Public") ? true : false);
            ps.setString(3, PostID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.deletePost()");
            e.printStackTrace();
        }

    }

    public void updatePost(String PostID, String UserID, String Content) {
        try {
            PreparedStatement ps = cnn.prepareStatement(updatePostWithoutImg);
            ps.setString(1, Content);
//            ps.setBoolean(2, Public.equals("Public") ? true : false);
            ps.setString(2, PostID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.deletePost()");
            e.printStackTrace();
        }

    }

    public void createPostShare(String UserID, String PostID, String Content, String PublicPost) {
        try {
            PreparedStatement ps = cnn.prepareStatement(createPostShare);
            ps.setString(1, UserID);
            ps.setString(2, PostID);
            ps.setString(3, Content);
//            ps.setBoolean(4, PublicPost.equalsIgnoreCase("Public") ? true : false);
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.createPostShare()");
            e.printStackTrace();
        }
    }

    public boolean checkExistPostUser(String PostID, String UserID) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkExistPostUser);
            ps.setString(1, PostID);
            ps.setString(2, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.checkExistPostUser()");
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkExistPosSharetUser(String PostID, String UserID) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkExistPostShareUser);
            ps.setString(1, PostID);
            ps.setString(2, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.checkExistPostUser()");
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePostShare(String PostID, String UserID) {
        String query = "DELETE dbo.POSTSHARE\n"
            + "WHERE ShareID= ?";
        try {
            
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, PostID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.deletePost()");
            e.printStackTrace();
        }
        return true;
    }

    public boolean deletePost(String PostID, String UserID) {
        String query = "DELETE FROM dbo.POST\n"
            + "WHERE PostID= ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, PostID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.deletePost()");
            e.printStackTrace();
        }
        return true;
    }

    public String newPost(String UserID, String Content, String ImagePost, String Privacy) {
        try {
            Connection cnn = new connection.connection().getConnection();
            PreparedStatement ps = cnn.prepareStatement(newPost);
            ps.setString(1, UserID);
            ps.setString(2, Content);
            ps.setString(3, ImagePost);
            ps.setString(4, new dao.PrivacyDao().transToId(Privacy.trim()));
            //ps.setString(4, PublicPost);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.newPost()");
            e.printStackTrace();
        }
        return null;
    }

    public String newPostShare(String UserID, String PostID, String Content, String Privacy) {
        try {
            Connection cnn = new connection.connection().getConnection();
            PreparedStatement ps = cnn.prepareStatement(createPostShare);
            ps.setString(1, UserID);
            ps.setString(2, PostID);
            ps.setNString(3, Content);
            ps.setString(4, new dao.PrivacyDao().transToId(Privacy.trim()));
            //ps.setString(4, PublicPost);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.newPostShare()");
            e.printStackTrace();
        }
        return null;
    }

    public PostUser getPost(String PostID) {
        //, String FullNameUser, String ImgUser
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
                return new PostUser(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getInt(6),
                        rs.getInt(7), rs.getInt(8), rs.getString(9),
                        rs.getString(10), rs.getString(11), IDUserCurrent);
            }
        } catch (Exception e) {
            System.out.println("dao.PostUserDAO.getPost()");
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<PostUser> getAllPost(String id) {
        ArrayList<PostUser> post = new ArrayList<>();
        String query = "SELECT POST.ID, PostID, POST.UserID, Content,\n"
                + "                		ImagePost, TimePost, NumInterface, NumComment, \n"
                + "                		NumShare, PrivacyName, FullName, ImageUser\n"
                + "	FROM dbo.POST \n"
                + "	INNER JOIN dbo.UserInfor ON POST.UserID = UserInfor.UserID\n"
                + "	 INNER JOIN dbo.Privacy ON Privacy.PrivacyID = POST.PrivacyID\n"
                + "	 where POST.UserID= ? \n"
                + "	 ORDER BY POST.TimePost DESC";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                post.add(new PostUser(rs.getString(2), rs.getString(3), rs.getNString(4), rs.getString(5), rs.getString(6), rs.getInt(7), rs.getInt(8),
                        rs.getInt(9), rs.getString(10), rs.getNString(11), rs.getString(12), this.IDUserCurrent));
                System.out.println("Name: " + rs.getNString(11));
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            System.err.println("WRONG AT CHECKLOGIN");
            e.printStackTrace();
        }
        return post;
    }
}
