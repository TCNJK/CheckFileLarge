/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.*;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author van12
 */
public class CommentDAO {

    Connection cnn;

    public CommentDAO() {
        this.cnn = new connection.connection().getConnection();
    }

    public CommentDAO(Connection cnn) {
        this.cnn = cnn;
    }
/// get infor comment

    public CommentChild getCommentChildByChildID(String ChildID) {
        String query = "DECLARE @ChildID VARCHAR(11)= ? ;"
                + "SELECT ChildID, UserID, CmtID, Content, \n"
                + "	TimeComment, ImageComment, NumInterface, (SELECT TOP(1) PostID\n"
                + "												FROM dbo.COMMENTCHILD\n"
                + "												INNER JOIN dbo.COMMENT ON COMMENT.CmtID = COMMENTCHILD.CmtID\n"
                + "												WHERE ChildID= @ChildID ) AS PostID														\n"
                + "	FROM dbo.COMMENTCHILD\n"
                + "	WHERE ChildID= @ChildID ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, ChildID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new CommentChild(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8));
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.getCommentChildByChildID()");
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<CommentChild> getCommentChildByCmtID(String CmtID, int offset) {
        ArrayList<CommentChild> commentChildList = new ArrayList<>();
        String query = "\n"
                + "	DECLARE @CmtID VARCHAR(11)= ? ;\n"
                + "    DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "    DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "                \n"
                + "	SELECT ChildID, UserID, CmtID, Content, TimeComment, ImageComment, NumInterface, (SELECT TOP(1) PostID\n"
                + "												FROM dbo.COMMENTCHILD\n"
                + "												INNER JOIN dbo.COMMENT ON COMMENT.CmtID = COMMENTCHILD.CmtID\n"
                + "												WHERE ChildID= 'ILD00000009' ) AS PostID	\n"
                + "	FROM dbo.COMMENTCHILD\n"
                + "	WHERE CmtID= @CmtID\n"
                + "	ORDER BY TimeComment DESC\n"
                + "    OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "    FETCH NEXT @FetchCount ROWS ONLY\n"
                + "\n"
                + "	SELECT *\n"
                + "	FROM dbo.COMMENTCHILD";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, CmtID);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                commentChildList.add(new CommentChild(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getInt(7), rs.getString(8)));
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.getCommentChildByChildID()");
            e.printStackTrace();
        }
        return commentChildList;
    }

    public Comment getCommentByCmtID(String CmtID) {
        String query = "SELECT CmtID, UserID, PostID, Content, TimeComment, ImageComment, NumInterface\n"
                + "FROM dbo.COMMENT\n"
                + "WHERE CmtID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, CmtID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getInt(7));
                comment.setCommentChild(getCommentChildByCmtID(CmtID, 1));
                return comment;
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.getCommentChildByChildID()");
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Comment> getCommentByPostID(String PostID, int offset) {
        String query = "DECLARE @PostID VARCHAR(11)= ? ;\n"
                + "    DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "    DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "                \n"
                + "	SELECT CmtID, UserID, PostID, Content, TimeComment, ImageComment, NumInterface\n"
                + "	FROM dbo.COMMENT\n"
                + "	WHERE PostID= @PostID\n"
                + "	ORDER BY TimeComment DESC\n"
                + "    OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "    FETCH NEXT @FetchCount ROWS ONLY\n"
                + "\n";
        ArrayList<Comment> commentList = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, PostID);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                Comment comment = new Comment(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getString(6), rs.getInt(7));
                comment.setCommentChild(getCommentChildByCmtID(rs.getString(1), 1));
                System.out.println("comment-log: " + comment.getTimeComment());
                commentList.add(comment);
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.getCommentChildByChildID()");
            e.printStackTrace();
        }
        return commentList;
    }
//  update 

    public void updateImageCommentOFCommentByCmtID(String CmtID, String fileName) {
        String query = "DECLARE @CmtId NVARCHAR(11)= ? \n"
                + "	DECLARE @ImageComment varchar(255) = ? \n"
                + "	UPDATE dbo.COMMENT\n"
                + "	SET ImageComment= @ImageComment\n"
                + "	WHERE CmtID= @CmtId";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, CmtID);
            ps.setString(2, fileName);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.updateImageCommentOFCommentByCmtID()");
            e.printStackTrace();
        }
    }

    public void updateContentOFCommentByCmtID(String CmtID, String Content) {
        String query = "DECLARE @CmtId NVARCHAR(11)= ?\n"
                + "	DECLARE @Content NVARCHAR(MAX) = ?\n"
                + "	UPDATE dbo.COMMENT\n"
                + "	SET Content= @Content\n"
                + "	WHERE CmtID= @CmtId";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, CmtID);
            ps.setString(2, Content);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.updateContentOFCommentByCmtID()");
            e.printStackTrace();
        }
    }

    public void updateImageCommentOFCommentChildByChildID(String ChildID, String fileName) {
        String query = "DECLARE @ChildId NVARCHAR(11)= ?\n"
                + "	DECLARE @ImageComment varchar(255) = ?\n"
                + "	UPDATE dbo.COMMENTCHILD\n"
                + "	SET ImageComment= @ImageComment\n"
                + "	WHERE ChildID= @ChildId";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, ChildID);
            ps.setString(2, fileName);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.updateImageCommentOFCommentChildByChildID()");
            e.printStackTrace();
        }
    }

    public void updateContentOFCommentChildByChildID(String ChildID, String Content) {
        String query = "DECLARE @ChildId NVARCHAR(11)= ?\n"
                + "	DECLARE @Content varchar(255) = ?\n"
                + "	UPDATE dbo.COMMENTCHILD\n"
                + "	SET Content= @Content\n"
                + "	WHERE ChildID= @ChildId";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, ChildID);
            ps.setString(2, Content);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.updateContentOFCommentChildByChildID()");
            e.printStackTrace();
        }
    }

    public CommentChild newCommentChildWithoutImage(CommentChild commentChild) {
        String query = "DECLARE @InsertedIDs TABLE (ChildID VARCHAR(11));\n"
                + "	INSERT INTO dbo.COMMENTCHILD\n"
                + "	(\n"
                + "	    UserID,\n"
                + "	    CmtID,\n"
                + "	    Content,\n"
                + "	    TimeComment,\n"
                + "	    ImageComment,\n"
                + "	    NumInterface\n"
                + "	)\n"
                + "	OUTPUT Inserted.ChildID INTO @InsertedIDs\n"
                + "	VALUES\n"
                + "	(   ?,    -- UserID - varchar(11)\n"
                + "	    ?,    -- CmtID - varchar(11)\n"
                + "	    ?,    -- Content - nvarchar(max)\n"
                + "	    DEFAULT, -- TimeComment - datetime\n"
                + "	    '',    -- ImageComment - varchar(255)\n"
                + "	    DEFAULT  -- NumInterface - int\n"
                + "	    )\n"
                + "		SELECT ChildID FROM @InsertedIDs";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, commentChild.getUserID());
            ps.setString(2, commentChild.getCmtID());
            ps.setString(3, commentChild.getContent());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return getCommentChildByChildID(rs.getString(1));
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.newCommentChildWithoutImage()");
            e.printStackTrace();
        }
        return null;
    }

    public CommentChild newCommentChildWithImage(CommentChild commentChild) {
        String query = "DECLARE @InsertedIDs TABLE (ChildID VARCHAR(11));\n"
                + "	INSERT INTO dbo.COMMENTCHILD\n"
                + "	(\n"
                + "	    UserID,\n"
                + "	    CmtID,\n"
                + "	    Content,\n"
                + "	    TimeComment,\n"
                + "	    ImageComment,\n"
                + "	    NumInterface\n"
                + "	)\n"
                + "	OUTPUT Inserted.ChildID INTO @InsertedIDs\n"
                + "	VALUES\n"
                + "	(   ?,    -- UserID - varchar(11)\n"
                + "	    ?,    -- CmtID - varchar(11)\n"
                + "	    ?,    -- Content - nvarchar(max)\n"
                + "	    DEFAULT, -- TimeComment - datetime\n"
                + "	    ? ,    -- ImageComment - varchar(255)\n"
                + "	    DEFAULT  -- NumInterface - int\n"
                + "	    )\n"
                + "		SELECT ChildID FROM @InsertedIDs;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, commentChild.getUserID());
            ps.setString(2, commentChild.getCmtID());
            ps.setString(3, commentChild.getContent());
            ps.setString(4, commentChild.getImageComment());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return getCommentChildByChildID(rs.getString(1));
            }
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.newCommentChildWithImage()");
            e.printStackTrace();
        }
        return null;
    }

    public Comment newCommentWithoutImage(Comment comment) {
        String query = "DECLARE @InsertedIDs TABLE (CmtID VARCHAR(11));\n"
                + "		INSERT INTO dbo.COMMENT\n"
                + "		(\n"
                + "		    UserID,\n"
                + "		    PostID,\n"
                + "		    Content,\n"
                + "		    TimeComment,\n"
                + "		    ImageComment,\n"
                + "		    NumInterface\n"
                + "		)\n"
                + "		OUTPUT Inserted.CmtID INTO @InsertedIDs\n"
                + "		VALUES\n"
                + "		(   ?,    -- UserID - varchar(11)\n"
                + "		    ?,    -- PostID - varchar(11)\n"
                + "		    ?,    -- Content - nvarchar(max)\n"
                + "		    DEFAULT, -- TimeComment - datetime\n"
                + "		    '',    -- ImageComment - varchar(255)\n"
                + "		    DEFAULT  -- NumInterface - int\n"
                + "		    )"
                + "SELECT CmtID FROM @InsertedIDs;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, comment.getUserID());
            ps.setString(2, comment.getPostID());
            ps.setString(3, comment.getContent());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return getCommentByCmtID(rs.getString(1));
            };
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.newCommentWithoutImage()");
            e.printStackTrace();
        }
        return null;
    }

    public Comment newCommentWithImage(Comment comment) {
        String query = "DECLARE @InsertedIDs TABLE (CmtID VARCHAR(11));\n"
                + "		INSERT INTO dbo.COMMENT\n"
                + "		(\n"
                + "		    UserID,\n"
                + "		    PostID,\n"
                + "		    Content,\n"
                + "		    TimeComment,\n"
                + "		    ImageComment,\n"
                + "		    NumInterface\n"
                + "		)\n"
                + "		OUTPUT Inserted.CmtID INTO @InsertedIDs\n"
                + "		VALUES\n"
                + "		(   ?,    -- UserID - varchar(11)\n"
                + "		    ?,    -- PostID - varchar(11)\n"
                + "		    ?,    -- Content - nvarchar(max)\n"
                + "		    DEFAULT, -- TimeComment - datetime\n"
                + "		    ?,    -- ImageComment - varchar(255)\n"
                + "		    DEFAULT  -- NumInterface - int\n"
                + "		    )"
                + "SELECT CmtID FROM @InsertedIDs;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, comment.getUserID());
            ps.setString(2, comment.getPostID());
            ps.setString(3, comment.getContent());
            ps.setString(4, comment.getImageComment());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return getCommentByCmtID(rs.getString(1));
            };
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.newCommentWithImage()");
            e.printStackTrace();
        }
        return null;
    }

    public void deleteCommentByCmtID(String CmtID) {
        String query = "DELETE dbo.COMMENT\n"
                + "	WHERE CmtID= ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, CmtID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.deleteCommentByCmtID()");
            e.printStackTrace();
        }
    }

    public void deleteCommentChildByChildID(String ChildID) {
        String query = "DELETE dbo.COMMENTCHILD\n"
                + "	WHERE ChildID = ?";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, ChildID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.CommentDAO.deleteCommentChildByChildID()");
            e.printStackTrace();
        }
    }
}
