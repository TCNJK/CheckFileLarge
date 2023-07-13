/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connection.connection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.UserReport;

/**
 *
 * @author TCNJK
 */
public class UserReportDAO {

    Connection cnn;

    public UserReportDAO() {
        cnn = new connection().getConnection();
    }

    public List<UserReport> getData() {
        List<UserReport> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT * FROM UserReportSummary");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserReport userReport = new UserReport();
                userReport.setUserID(rs.getString("UserID"));
                userReport.setImageUser(rs.getString("ImageUser"));
                userReport.setFullName(rs.getString("FullName"));
                userReport.setAccount(rs.getString("Account"));
                userReport.setMail(rs.getString("Mail"));
                userReport.setPhoneNumber(rs.getString("PhoneNumber"));
                userReport.setAddress(rs.getString("Address"));
                userReport.setNumCommentReported(rs.getInt("NumCommentReported"));
                userReport.setNumPostReported(rs.getInt("NumPostReported"));
                userReport.setNumReportedByUsers(rs.getInt("NumReportedByUsers"));
                list.add(userReport);
            }
            return list;

        } catch (Exception e) {
            System.err.println("getData UserReportDAO");
            e.printStackTrace();
        }
        return null;
    }

    public void UpdateSkip(String id) {
        try {
            PreparedStatement ps = cnn.prepareStatement("UPDATE dbo.ReportUser1686 \n"
                    + "	SET ReportUser1686.Status=0\n"
                    + "	WHERE ReportUser1686.UserID=?");
            ps.setString(1, id);
            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("UpdateSkip UserReportDAO");
            e.printStackTrace();
        }
    }

    public void AddReport(String urpid, String uid) {
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.ReportUser1686\n"
                    + "	(\n"
                    + "	    UserID,\n"
                    + "	    UserIDRP,\n"
                    + "	    Status\n"
                    + "	)\n"
                    + "	VALUES\n"
                    + "	(   ?,  -- UserID - varchar(11)\n"
                    + "	    ?,  -- UserIDRP - varchar(11)\n"
                    + "	    1 -- Status - bit\n"
                    + "	    )");
            ps.setString(1, urpid);
            ps.setString(2, uid);
            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("AddReport UserReportDAO");
            e.printStackTrace();
        }
    }

    public boolean AddLock(String id, int day, int hour, int minute) {
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.UserLock\n"
                    + "(\n"
                    + "    UserID,\n"
                    + "    LockTime,\n"
                    + "    LockDurationDay,\n"
                    + "    LockDurationHour,\n"
                    + "    LockDurationMinute\n"
                    + ")\n"
                    + "VALUES\n"
                    + "(   ?,        -- UserID - varchar(11)\n"
                    + "    GETDATE(), -- LockTime - datetime\n"
                    + "    ?,         -- LockDurationDay - int\n"
                    + "    ?,         -- LockDurationHour - int\n"
                    + "    ?          -- LockDurationMinute - int\n"
                    + "    )");
            ps.setString(1, id);
            ps.setInt(2, day);
            ps.setInt(3, hour);
            ps.setInt(4, minute);

            ps.executeUpdate();
            
            ps = cnn.prepareStatement("UPDATE dbo.UserInfor SET UserInfor.RoleID = 'LOCK' WHERE UserID = ?;");
            ps.setString(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("AddLock UserReportDAO");
            e.printStackTrace();
        }
        return false;
    }
    public boolean DeleteUser(String id) {
        try {
            PreparedStatement ps;
            ps = cnn.prepareStatement("UPDATE dbo.UserInfor SET UserInfor.RoleID = 'DELETED' WHERE UserID = ?;");
            ps.setString(1, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("DeleteUser UserReportDAO");
            e.printStackTrace();
        }
        return false;
    }
}
