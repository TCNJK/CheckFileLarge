/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Role;
import connection.connection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author TCNJK
 */
public class RoleDao {

    Connection cnn;

    public RoleDao() {
        cnn = new connection().getConnection();
    }

    public Role getRole(String UserID) {
        String query = "DECLARE @UserID NVARCHAR(11) = ?\n"
                + "DECLARE @isLock BIT = CASE\n"
                + "    WHEN ((SELECT TOP(1) DATEADD(MINUTE, LockDurationMinute, DATEADD(HOUR, LockDurationHour, DATEADD(DAY, LockDurationDay, LockTime)))\n"
                + "           FROM UserLock\n"
                + "           WHERE UserID = @UserID) > GETDATE()) THEN 1\n"
                + "    ELSE 0\n"
                + "END\n"
                + "\n"
                + "DECLARE @Role VARCHAR(11)\n"
                + "\n"
                + "SELECT @Role = UserInfor.RoleID\n"
                + "FROM dbo.UserInfor\n"
                + "WHERE UserInfor.UserID = @UserID\n"
                + "\n"
                + "IF (@isLock = 0 AND @Role = 'LOCK')\n"
                + "BEGIN\n"
                + "    UPDATE dbo.UserInfor\n"
                + "    SET UserInfor.RoleID = 'USER'\n"
                + "    WHERE UserInfor.UserID = @UserID\n"
                + "	DELETE FROM dbo.UserLock WHERE UserLock.UserID=@UserID\n"
                + "END\n"
                + "\n"
                + "SELECT Role.RoleID, RoleName, @isLock\n"
                + "FROM dbo.UserInfor\n"
                + "INNER JOIN dbo.Role ON Role.RoleID = UserInfor.RoleID\n"
                + "WHERE UserID = @UserID\n"
                + "\n"
                + "\n"
                + "SELECT Role.RoleID, RoleName, @isLock\n"
                + "FROM dbo.UserInfor\n"
                + "INNER JOIN dbo.Role ON Role.RoleID = UserInfor.RoleID\n"
                + "WHERE UserID = @UserID";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Role(rs.getString(1), rs.getString(2), rs.getBoolean(3));
            }

        } catch (Exception e) {
            System.out.println("dao.RoleDao.getRole()");
            e.printStackTrace();
        }
        return null;
    }

    public boolean change(String id, String Roleid) {
        try {
            PreparedStatement ps;
            ps = cnn.prepareStatement("UPDATE dbo.UserInfor\n"
                    + "SET UserInfor.RoleID=?\n"
                    + "WHERE UserInfor.UserID=?");
            ps.setString(1, Roleid);
            ps.setString(2, id);
            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            System.err.println("DeleteUser UserReportDAO");
            e.printStackTrace();
        }
        return false;
    }
}
