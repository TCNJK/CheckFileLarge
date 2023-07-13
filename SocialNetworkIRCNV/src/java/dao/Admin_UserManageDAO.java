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
import model.Admin_UserManage;

/**
 *
 * @author TCNJK
 */
public class Admin_UserManageDAO {

    Connection cnn;

    public Admin_UserManageDAO() {
        cnn = new connection().getConnection();
    }

    public List<Admin_UserManage> getData() {
        List<Admin_UserManage> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT * FROM UserView");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String userID = rs.getString("UserID");
                String imageUser = rs.getString("ImageUser");
                String fullName = rs.getString("FullName");
                String address = rs.getString("Address");
                String mail = rs.getString("Mail");
                String account = rs.getString("Account");
                String phoneNumber = rs.getString("PhoneNumber");
                Date dob = rs.getDate("Dob");
                String nation = rs.getString("Nation");
                String roleID = rs.getString("RoleID");

                // Tạo đối tượng Admin_UserManage và thêm vào danh sách
                Admin_UserManage user = new Admin_UserManage(userID, imageUser, fullName, address, mail, account, phoneNumber, dob, nation, roleID);
                list.add(user);
            }
            return list;

        } catch (Exception e) {
            System.err.println("getData Admin_UserManageDAO");
            e.printStackTrace();
        }
        return null;
    }
}
