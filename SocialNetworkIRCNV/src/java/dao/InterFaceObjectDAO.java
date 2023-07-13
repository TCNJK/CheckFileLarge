/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import model.InterFaceObject;

/**
 *
 * @author van12
 */
public class InterFaceObjectDAO {

    Connection cnn;

    public InterFaceObjectDAO() {
        this.cnn = new connection.connection().getConnection();
    }

    public InterFaceObjectDAO(Connection cnn) {
        this.cnn = cnn;
    }

    //object sẽ là đối tượng như cmt, bài viết hoặc cũng có thể là đoạn chat trong tương lai
    // id là id người dùng
    // với object và id thì sẽ biết người dùng có tương tác gì với đối tượng(bài viết, cmt, đoạn chat) đó
    public InterFaceObject getInterFaceObjectByID(String object, String id) {
        String query = "	DECLARE @ObjectID NVARCHAR(11)= ? , @UserID NVARCHAR(11)= ? \n"
                + "		IF NOT EXISTS(SELECT *\n"
                + "		FROM dbo.InterFaceObject \n"
                + "		WHERE ObjectID= @ObjectID AND UserID=@UserID)\n"
                + "		BEGIN\n"
                + "			INSERT INTO dbo.InterFaceObject\n"
                + "			VALUES\n"
                + "			(   @UserID,     -- UserID - varchar(11)\n"
                + "				@ObjectID,     -- PostOrShareID - varchar(11)\n"
                + "				DEFAULT -- InterFaceID - varchar(11)\n"
                + "				)\n"
                + "		END\n"
                + "	BEGIN\n"
                + "		SELECT UserID, ObjectID, InterFaceObject.InterFaceID, InterFaceName, InterFaceDiv\n"
                + "		FROM dbo.InterFaceObject\n"
                + "		INNER JOIN dbo.InterFace ON InterFace.InterFaceID = InterFaceObject.InterFaceID\n"
                + "		WHERE ObjectID=@ObjectID AND UserID=@UserID\n"
                + "	END";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, object);
            ps.setString(2, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new InterFaceObject(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
            }
        } catch (Exception e) {
            System.out.println("dao.InterFaceObjectDAO.getInterFaceObjectByID()");
            e.printStackTrace();
        }
        return null;
    }

    public void setInterFaceObjectBy(String object, String id, String InterFaceID) {
        String query = "DECLARE @ObjectID NVARCHAR(11)= ? , @UserID NVARCHAR(11)= ? \n"
                + "DECLARE @InterFaceID VARCHAR(11)= ? \n"
                + "		IF NOT EXISTS(SELECT *\n"
                + "		FROM dbo.InterFaceObject \n"
                + "		WHERE ObjectID= @ObjectID AND UserID=@UserID)\n"
                + "		BEGIN\n"
                + "			INSERT INTO dbo.InterFaceObject\n"
                + "			VALUES\n"
                + "			(   @UserID,     -- UserID - varchar(11)\n"
                + "				@ObjectID,     -- PostOrShareID - varchar(11)\n"
                + "				DEFAULT -- InterFaceID - varchar(11)\n"
                + "				)\n"
                + "		END\n"
                + "	BEGIN\n"
                + "		UPDATE dbo.InterFaceObject\n"
                + "		SET InterFaceID = @InterFaceID\n"
                + "		WHERE ObjectID= @ObjectID AND UserID= @UserID\n"
                + "	END";
        try {
            PreparedStatement ps= cnn.prepareStatement(query);
            ps.setString(1, object);
            ps.setString(2, id);
            ps.setString(3, InterFaceID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.InterFaceObjectDAO.setInterFaceObjectBy()");
            e.printStackTrace();
        }
    }
}
