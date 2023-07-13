/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.SearchUser;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author van12
 */
public class SearchUserDao {
    Connection cnn;
    public SearchUserDao() {
        cnn= new connection.connection().getConnection();
    }
    
    public ArrayList<SearchUser> getSearchUserByKeyWord(String keyword) {
        ArrayList<SearchUser> searchUser= new ArrayList<>();
        String query = "SELECT UserId,FullName, ImageUser, NumFriend\n"
                + "FROM dbo.UserInfor WHERE FullName COLLATE Latin1_General_CI_AI LIKE '%' + ? + '%'";
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, keyword);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                //String name= rs.getString(2);
                searchUser.add(new SearchUser(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4)));
            }
        } catch (Exception e) {
            System.out.println("dao.SearchUserDao.getSearchUserByKeyWord()");
            e.printStackTrace();
        }
        return searchUser;
    }
}
