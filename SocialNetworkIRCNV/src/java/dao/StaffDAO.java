/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import model.Staff;
import java.sql.*;

/**
 *
 * @author van12
 */
public class StaffDAO {

    Connection cnn;

    public StaffDAO() {
        cnn = new connection.connection().getConnection();
    }

    public StaffDAO(Connection cnn) {
        this.cnn = cnn;
    }

    public ArrayList<Staff> getStaffByBusinessID(String BusinessID) {
        String query = "SELECT BusinessID, UserID, view_ads, edit_ads, add_ads, post_ads\n"
                + "FROM dbo.Staff\n"
                + "WHERE BusinessID= ?";
        ArrayList<Staff> staffs = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                staffs.add(new Staff(rs.getString(1), rs.getString(2),
                        rs.getBoolean(3), rs.getBoolean(4), rs.getBoolean(5), rs.getBoolean(6)));
            }
        } catch (Exception e) {
            System.out.println("dao.StaffDAO.getStaffByBusinessID()");
            e.printStackTrace();
        }
        return staffs;
    }

    public Staff getStaffByBusinessIDAndUserID(String BusinessID, String UserID) {
        String query = "SELECT BusinessID, UserID, view_ads, edit_ads, add_ads, post_ads\n"
                + "FROM dbo.Staff\n"
                + "WHERE BusinessID= ? AND UserID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ps.setString(2, UserID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Staff(rs.getString(1), rs.getString(2),
                        rs.getBoolean(3), rs.getBoolean(4), rs.getBoolean(5), rs.getBoolean(6));
            }
        } catch (Exception e) {
            System.out.println("dao.StaffDAO.getStaffByBusinessIDAndUserID()");
            e.printStackTrace();
        }
        return null;
    }

    public void insert(Staff staff) {
        String query = "INSERT INTO dbo.Staff\n"
                + "VALUES\n"
                + "(   ? ,   -- BusinessID - varchar(11)\n"
                + "    ? ,   -- UserID - varchar(11)\n"
                + "    ? , -- view_ads - bit\n"
                + "    ? , -- edit_ads - bit\n"
                + "    ? , -- add_ads - bit\n"
                + "    ?   -- post_ads - bit\n"
                + "    )";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, staff.getBusinessID());
            ps.setString(2, staff.getUserID());
            ps.setBoolean(3, staff.isView_ads());
            ps.setBoolean(4, staff.isEdit_ads());
            ps.setBoolean(5, staff.isAdd_ads());
            ps.setBoolean(6, staff.isPost_ads());
            ps.execute();
        } catch (Exception e) {
            System.out.println("dao.StaffDAO.insert()");
            e.printStackTrace();
        }
    }

    public void delete(String BusinessID, String UserID) {
        String query = "DELETE dbo.Staff\n"
                + "WHERE BusinessID= ? AND UserID= ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, BusinessID);
            ps.setString(2, UserID);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.StaffDAO.delete()");
            e.printStackTrace();
        }
    }

    public void update(Staff staff) {
        String query = "UPDATE dbo.Staff\n"
                + "SET view_ads= ? , edit_ads= ? , add_ads= ? , post_ads = ?\n"
                + "WHERE BusinessID= ? AND UserID = ? ";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setBoolean(1, staff.isView_ads());
            ps.setBoolean(2, staff.isEdit_ads());
            ps.setBoolean(3, staff.isAdd_ads());
            ps.setBoolean(4, staff.isPost_ads());
            ps.setString(5, staff.getBusinessID());
            ps.setString(6, staff.getUserID());
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("dao.StaffDAO.insert()");
            e.printStackTrace();
        }
    }
}
