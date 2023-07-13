/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connection.connection;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**
 *
 * @author TCNJK
 */
public class AddAChatDAO {
    
    Connection cnn;
    
    public AddAChatDAO() {
        cnn = new connection().getConnection();
    }
    
    public boolean SaveTODB(String UserID, String FriendID, String Mess) {
        String u1 = UserID;
        String u2 = FriendID;
        boolean check = true;
        if (u1.compareTo(u2)<0) {
            String user = u1;
            u1 = u2;
            u2 = user;
            check = false;
        }
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.CHATCONTENT\n"
                    + "(\n"
                    + "    UserID1,\n"
                    + "    UserID2,\n"
                    + "    Mess,\n"
                    + "    ofUser1\n"
                    + ")\n"
                    + "VALUES\n"
                    + "(   ?,       -- UserID1 - varchar(11)\n"
                    + "    ?,       -- UserID2 - varchar(11)\n"
                    + "    ?,      -- Mess - nvarchar(500)\n"
                    + "    ?     -- ofUser1 - bit\n"
                    + "    )");
            ps.setString(1, u1);
            ps.setString(2, u2);
            ps.setString(3, Mess);
            ps.setBoolean(4, check);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("model.API.SaveChatBox");
            e.printStackTrace();
        }
        return false;
    }
}
