/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import model.Privacy;

/**
 *
 * @author van12
 */
public class PrivacyDao {

    Connection cnn;

    public PrivacyDao() {
        cnn = new connection.connection().getConnection();
    }
    String getAllPrivacy = "SELECT * FROM dbo.Privacy";

    public String transToId(String Priva){
        if(Priva.equalsIgnoreCase("Friend")) return "FRIEND";
        if(Priva.equalsIgnoreCase("Private")) return "PRIVATE";
        return "PUBLIC";
    }
    
    public ArrayList<Privacy> getAllPrivacy() {
        ArrayList<Privacy> privacyList = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement(getAllPrivacy);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                privacyList.add(new Privacy(rs.getString(1), rs.getString(1)));
            }
        } catch (Exception e) {
            System.out.println("dao.PrivacyDao.getAllPrivacy()");
            e.printStackTrace();
        }
        return privacyList;
    }
}
