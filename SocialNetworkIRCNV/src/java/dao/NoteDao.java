/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.*;

/**
 *
 * @author van12
 */
public class NoteDao {

    Connection cnn;
    private String IDUserCurrent;
    public NoteDao(String IDUserCurrent) {
        this.cnn = new connection.connection().getConnection();
        this.IDUserCurrent= IDUserCurrent;
    }

    public NoteDao(Connection cnn, String IDUserCurrent) {
        this.cnn = cnn;
        this.IDUserCurrent= IDUserCurrent;
    }

    private NOTE_FRIEND getNOTE_FRIEND(String NoteID) {
        String query = "SELECT NoteID, UserID, UserIDRequest, TimeRequest, statusNote, isRead \n"
                + "	FROM dbo.NOTE_FRIEND\n"
                + "	WHERE NoteID= ? ;";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, NoteID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new NOTE_FRIEND(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getBoolean(6));
            }
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNOTE_FRIEND()");
            e.printStackTrace();
        }
        return null;
    }

    public NOTE_COUNT getNOTE_COUNT(String UserID) {
        String query = "DECLARE @UserID NVARCHAR(11) =? \n"
                + "	IF NOT EXISTS(SELECT UserID, MESS, NOTE\n"
                + "                FROM dbo.NOTE_COUNT\n"
                + "                WHERE UserID= @UserID)\n"
                + "				BEGIN\n"
                + "					INSERT INTO dbo.NOTE_COUNT\n"
                + "					(\n"
                + "					    UserID,\n"
                + "					    NOTE,\n"
                + "					    MESS\n"
                + "					)\n"
                + "					VALUES\n"
                + "					(   @UserID,   -- UserID - varchar(11)\n"
                + "					    0, -- NOTE - int\n"
                + "					    0  -- MESS - int\n"
                + "					    )\n"
                + "                END \n"
                + "   SELECT UserID, MESS, NOTE\n"
                + "                FROM dbo.NOTE_COUNT\n"
                + "                WHERE UserID= @UserID";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new NOTE_COUNT(UserID, rs.getInt(2), rs.getInt(3));
            }
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNOTE_COUNT()");
            e.printStackTrace();
        }
        return null;
    }

    public void setNOTE_ZERO(String UserID) {
        String query = "UPDATE dbo.NOTE_COUNT\n"
                + "SET NOTE= 0\n"
                + "WHERE UserID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNOTE_ZERO()");
            e.printStackTrace();
        }
    }

    public void setMESS_ZERO(String UserID) {
        String query = "UPDATE dbo.NOTE_COUNT\n"
                + "SET MESS= 0\n"
                + "WHERE UserID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getMESS_ZERO()");
            e.printStackTrace();
        }
    }

    private NOTE_LIKE getNOTE_LIKE(String NoteID) {
        String query = "DECLARE @NoteID NVARCHAR(11)= ? \n"
                + "				SELECT NoteID, ObjectID, UserID, statusNote, TimeComment, isRead,  CASE\n"
                + "																					WHEN ObjectID LIKE 'ILD%' THEN (SELECT TOP(1) PostID\n"
                + "																														FROM dbo.COMMENTCHILD\n"
                + "																														INNER JOIN dbo.COMMENT ON COMMENT.CmtID = COMMENTCHILD.CmtID\n"
                + "																														WHERE ChildID= ObjectID\n"
                + "																														)\n"
                + "																					WHEN ObjectID LIKE 'CID%' THEN (SELECT TOP(1) PostID\n"
                + "																														FROM dbo.COMMENT \n"
                + "																														WHERE CmtID=ObjectID)\n"
                + "																					ELSE ObjectID\n"
                + "																				END AS PostID\n"
                + "                	FROM dbo.NOTE_lIKE\n"
                + "                	WHERE NoteID= @NoteID";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, NoteID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new NOTE_LIKE(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getBoolean(6), rs.getString(7), IDUserCurrent);
            }
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNOTE_FRIEND()");
            e.printStackTrace();
        }
        return null;
    }

    public NOTE getNoteByID(String NotID) {
        if (NotID.substring(0, 3).equalsIgnoreCase("NFR")) {
            return getNOTE_FRIEND(NotID);
        }
        if (NotID.substring(0, 3).equalsIgnoreCase("NLI")) {
            return getNOTE_LIKE(NotID);
        }
        return null;
    }
//note(, ,)

    public ArrayList<NOTE> getNote(String UserID) {
        String query = "SELECT NoteID, TimeRequest\n"
                + "        FROM dbo.NOTE_FRIEND\n"
                + "		UNION ALL\n"
                + "		SELECT NoteID, TimeComment\n"
                + "        FROM dbo.NOTE_lIKE\n"
                + "        WHERE UserID= ? \n"
                + "		ORDER BY TimeRequest DESC";
        ArrayList<NOTE> noteList = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                NOTE note= getNoteByID(rs.getString(1));
                if(note instanceof NOTE_LIKE)
                    if(((NOTE_LIKE)note).getObjectID().substring(0, 3).equalsIgnoreCase("AID"))
                        continue;
                noteList.add(getNoteByID(rs.getString(1)));
            }
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNote()");
            e.printStackTrace();
        }
        return noteList;
    }

    public ArrayList<NOTE> getNote(String UserID, int offset) {
        String query = "DECLARE @UserID VARCHAR(11)= ? ;\n"
                + "    DECLARE @Offset INT = ? ; -- Số bài post đã hiển thị trước đó = @FetchCount* (offset-1)\n"
                + "    DECLARE @FetchCount INT = 5; -- Số bài post muốn lấy thêm\n"
                + "                \n"
                + "	SELECT NoteID, TimeRequest\n"
                + "		FROM dbo.NOTE_FRIEND\n"
                + "		WHERE UserID= @UserID\n"
                + "	UNION ALL\n"
                + "		SELECT NoteID, TimeComment\n"
                + "		FROM dbo.NOTE_lIKE\n"
                + "		WHERE UserID= @UserID\n"
                + "    ORDER BY TimeRequest DESC\n"
                + "    OFFSET (@Offset-1)* @FetchCount ROWS\n"
                + "    FETCH NEXT @FetchCount ROWS ONLY";
        ArrayList<NOTE> noteList = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                NOTE note= getNoteByID(rs.getString(1));
                if(note instanceof NOTE_LIKE)
                    if(((NOTE_LIKE)note).getObjectID().substring(0, 3).equalsIgnoreCase("AID"))
                        continue;
                noteList.add(getNoteByID(rs.getString(1)));
            }
        } catch (Exception e) {
            System.out.println("dao.NoteDao.getNote()");
            e.printStackTrace();
        }
        return noteList;
    }
}
