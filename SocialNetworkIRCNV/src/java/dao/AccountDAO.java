/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package dao;

import java.sql.*;

/**
 *
 * @author 84384
 */
public class AccountDAO {

    Connection cnn;

    public AccountDAO() {
        cnn = new connection.connection().getConnection();
    }

    /*
	acount
	pass
	name
	mail
	dob
     */
    String createNewUser = "INSERT INTO dbo.UserInfor\n"
            + "(\n"
            + "    Account,\n"
            + "    Password,\n"
            + "    FullName,\n"
            + "    Address,\n"
            + "    Mail,\n"
            + "    PhoneNumber,\n"
            + "    Dob,\n"
            + "    Gender,\n"
            + "    Nation,\n"
            + "    ImageUser,\n"
            + "    ImageBackGround,\n"
            + "    NumFriend,\n"
            + "    NumPost,\n"
            + "    TimeCreate,\n"
            + "    RoleID\n"
            + ")\n"
            + "VALUES\n"
            + "(   ? ,    -- Account - varchar(155)\n"
            + "    ? ,    -- Password - varchar(155)\n"
            + "    ? ,    -- FullName - nvarchar(255)\n"
            + "    NULL,    -- Address - nvarchar(255)\n"
            + "    ? ,    -- Mail - varchar(255)\n"
            + "    NULL,    -- PhoneNumber - varchar(15)\n"
            + "    ? ,    -- Dob - date\n"
            + "    ? ,    -- Gender - bit\n"
            + "    NULL,    -- Nation - nvarchar(255)\n"
            + "    NULL,    -- ImageUser - nvarchar(255)\n"
            + "    NULL,    -- ImageBackGround - nvarchar(255)\n"
            + "    DEFAULT, -- NumFriend - int\n"
            + "    DEFAULT, -- NumPost - int\n"
            + "    DEFAULT, -- TimeCreate - datetime\n"
            + "    DEFAULT  -- RoleID - varchar(11)\n"
            + "    )";
    String checkExistAccount = "SELECT *\n"
            + "FROM dbo.UserInfor\n"
            + "WHERE Account= ?";
    String createSendMailCode = "DECLARE @mail VARCHAR(255);\n"
            + "SET @mail= ? ;\n"
            + "DECLARE @code char(10);\n"
            + "SET @code= ? ;\n"
            + "\n"
            + "IF NOT EXISTS (SELECT * FROM dbo.MAIL WHERE Mail= @mail) \n"
            + "BEGIN\n"
            + "    INSERT INTO dbo.MAIL\n"
            + "	VALUES\n"
            + "	(   @mail ,  -- Mail - varchar(255)\n"
            + "		@code  -- code - char(10)\n"
            + "		)\n"
            + "END\n"
            + "ELSE\n"
            + "BEGIN\n"
            + "   \n"
            + "		UPDATE dbo.MAIL\n"
            + "	SET code= @code WHERE Mail= @mail \n"
            + "END";
    String checkMailCode = "SELECT * FROM dbo.MAIL\n"
            + "WHERE Mail= ? AND code= ?";

    String getIdUser = "SELECT UserID FROM dbo.UserInfor\n"
            + "WHERE Account= ?";

    String checkLogin = "SELECT UserID, Password FROM dbo.UserInfor\n"
            + "WHERE Account= ?";
    String checkExistMail = " SELECT FullName\n"
            + "	FROM dbo.UserInfor\n"
            + "	WHERE Account= ? AND Mail= ?";
    String resetPass = "	UPDATE dbo.UserInfor\n"
            + "	SET Password= ?\n"
            + "	WHERE Account= ? ";

    public void resetPass(String user, String pass) {
        try {
            PreparedStatement ps= cnn.prepareStatement(resetPass);
            ps.setString(1, new controller.Argon().convertArgon2(pass).trim());
            ps.setString(2, user);
            
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.AccountDAO.resetPass()");
        }
        
    }

    public String checkExistMail(String user, String mail) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkExistMail);
            ps.setString(1, user);
            ps.setString(2, mail);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("dao.AccountDAO.checkExistMail()");
        }
        return null;
    }

    public boolean checkMailCode(String mail, String code) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkMailCode);
            ps.setString(1, mail.trim());
            ps.setString(2, code.trim());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.checkMailCode");
        }
        return false;
    }

    public boolean checkExistAccount(String user) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkExistAccount);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.checkExistAccount");
        }
        return false;
    }

    public String checkLogin(String user, String pass) {
        try {
            PreparedStatement ps = cnn.prepareStatement(checkLogin);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String hash = rs.getString(2);
                if (new controller.Argon().checkArgon2(hash, pass)) {
                    return rs.getString(1);
                }
                System.out.println("hash: " + hash + "\n" + "pass: " + rs.getString(1) + "\n" + rs.getString(1));
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.checkExistAccount");
        }
        return null;
    }

    public String getIdUser(String user) {
        try {
            PreparedStatement ps = cnn.prepareStatement(getIdUser);
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.getIdUser");
        }
        return null;
    }

    public boolean createNewUser(String user, String pass, String name, String mail, String dob, String getGender) {
        try {
            PreparedStatement ps = cnn.prepareStatement(createNewUser);
            ps.setString(1, user.trim());
            ps.setString(2, pass.trim());
            ps.setString(3, name.trim());
            ps.setString(4, mail.trim());
            ps.setString(5, dob.trim());
            ps.setString(6, getGender.trim());
            ps.execute();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.checkExistAccount");
        }
        return false;
    }

    public String createNewMail(String mail) {
        try {
            String code = new controller.Rand().getStringNum(6);
            PreparedStatement ps = cnn.prepareStatement(createSendMailCode);
            ps.setString(1, mail.trim());
            ps.setString(2, code.trim());
            //new controller.Send().sendEmail(mail, "MAIL CODE", "This is your mail code for user " + name + ": " + code);
            ps.execute();
            return code;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("dao.AccountDAO.checkExistAccount");
        }
        return null;
    }
}
