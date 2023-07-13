/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import model.Relation;

/**
 *
 * @author van12
 */
public class RelationDao {
    private String function;
    // onclick="relate('unfriend')"  unfriend: unfriend
    private final String isfriend = "<button type = \"button\" onclick=\""+this.function+"('unfriend',<%=UID%>')\">"
            + "<div style='color: blue'>"
            + "<i class='fa-solid fa-user-check'></i> Your Friend "
            + "</div>"
            + "</button>";

    public String getIsFriend(String User, String OtherUser) {
        if(function.equals("relate")){
            return "<button type = \"button\" onclick=\"askAgainUnfiend('unfriend','" + OtherUser + "')\">"
                + "<div style='color: blue'>"
                + "<i class='fa-solid fa-user-check'></i> Your Friend "
                + "</div>"
                + "</button>";
        }
        return "<button type = \"button\">"
                + "<div style='color: blue'>"
                + "<i class='fa-solid fa-user-check'></i> Your Friend "
                + "</div>"
                + "</button>";
    }
    // onclick="relate('unrequest')" unrequest:unrequest
    private final String request = "<button type = \"button\" onclick=\""+this.function+"('unrequest','<%=UID%>')\" >"
            + "<div style='color: black'>"
            + "<i class='fa-solid fa-people-arrows'></i> Requested "
            + "</div>"
            + "</button>";

    public String getSentRequest(String User, String OtherUser) {
        return "<button type = \"button\" onclick=\""+this.function+"('unrequest','" + OtherUser + "')\" >"
                + "<div style='color: black'>"
                + "<i class='fa-solid fa-people-arrows'></i> Sent Requested "
                + "</div>";
    }
    // onclick="relate('addfriend')" rqfr: request friend
    private final String isNotFriend = "<button type = \"button\" onclick=\""+this.function+"('requestfriend','<%=UID%>')\" >"
            + "<div style='color: black'>"
            + "<i class=\"fa-sharp fa-solid fa-user-plus\"></i> Add friend "
            + "</div>"
            + "</button>";

    public String getIsNotFriend(String User, String OtherUser) {
        return "<button type = \"button\" onclick=\""+this.function+"('addfriend','" + OtherUser + "')\" >"
                + "<div style='color: black'>"
                + "<i class=\"fa-sharp fa-solid fa-user-plus\"></i> Add friend "
                + "</div>"
                + "</button>";
    }
    // onclick="relate('requestfriend')" accfr: accepct friend sở dĩ chấp nhận kết bạn với yêu cầu kết bạn gọi hàm giống nhau vì
    // cả 2 đều yêu cầu thì sẽ tự động chỉnh trong db là isFriend= true
    private final String acceptRequest = "<button type = \"button\" onclick=\""+this.function+"('requestfriend','<%=UID%>')\" >"
            + "<div style='color: black'>"
            + "<i class=\"fa-sharp fa-solid fa-arrow-right\"></i> Acppect request "
            + "</div>"
            + "</button>";

    public String getAcceptRequest(String User, String OtherUser) {
        return "<button type = \"button\" onclick=\""+this.function+"('requestfriend','" + OtherUser + "')\" >"
                + "<div style='color: black'>"
                + "<i class=\"fa-sharp fa-solid fa-arrow-right\"></i> Acppect request "
                + "</div>"
                + "</button>";
    }
    Connection cnn;

// onclick=""
    public RelationDao(String function) {
        cnn = new connection.connection().getConnection();
        this.function= function;
    }

    public void createRelation(String User1, String User2) {
        String Query = "DECLARE @User1 NVARCHAR(11), @User2 NVARCHAR(11);\n"
                + "SET @User1= ? ;\n"
                + "SET @User2= ? ;\n"
                + "IF NOT EXISTS(SELECT *\n"
                + "	FROM dbo.USERRELATION\n"
                + "	WHERE UserID1= @User1 AND UserID2= @User2)\n"
                + "	BEGIN\n"
                + "		INSERT INTO dbo.USERRELATION\n"
                + "		(\n"
                + "		    UserID1,\n"
                + "		    UserID2,\n"
                + "		    U1RequestU2,\n"
                + "		    U2RequestU1,\n"
                + "		    isFriend\n"
                + "		)\n"
                + "		VALUES\n"
                + "		(   @User1,      -- UserID1 - varchar(11)\n"
                + "		    @User2,      -- UserID2 - varchar(11)\n"
                + "		    DEFAULT, -- U1RequestU2 - bit\n"
                + "		    DEFAULT, -- U2RequestU1 - bit\n"
                + "		    DEFAULT  -- isFriend - bit\n"
                + "		    )\n"
                + "	END";
        try {
            PreparedStatement ps = cnn.prepareStatement(Query);
            ps.setString(1, User1);
            ps.setString(2, User2);
            ps.execute();
        } catch (Exception e) {
            System.out.println("dao.RelationDao.createRelation()");
            e.printStackTrace();
        }
    }
// lấy đối tương quan hệ giữa 2 người

    public Relation getRelation(String User1, String User2) {
        String query = "SELECT U1RequestU2, U2RequestU1, isFriend\n"
                + "FROM dbo.USERRELATION\n"
                + "WHERE UserID1= ?  AND UserID2= ? ";
        Relation relation = new Relation(User1, User2);
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, relation.getUser1());
            ps.setString(2, relation.getUser2());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                relation.setU1RequestU2(rs.getBoolean(1));
                relation.setU2RequestU1(rs.getBoolean(2));
                relation.setIsFriend(rs.getBoolean(3));
                return relation;
            }
        } catch (Exception e) {
            System.out.println("dao.RelationDao.getRelation()");
            e.printStackTrace();
        }
        return null;
    }
// lấy thẻ div cho nút thay đổi về quan hệ

    public String getDivRelation(String User, String OtherUser) {
        // U1 -> U2
        // U2 -> U1
        Relation relation = getRelation(User, OtherUser);
        if (relation.isIsFriend()) {
            return getIsFriend(User, OtherUser);
        }
        //User có id lớn hơn Other user thì sẽ lấy
        // User= 1, OtherUser= 2
        if (!relation.isU1RequestU2() && !relation.isU2RequestU1()) {
            return getIsNotFriend(User, OtherUser);
        }
        if (User.compareTo(OtherUser) < 0) {
            if (relation.isU1RequestU2()) {
                return getAcceptRequest(User, OtherUser);
            }
            if (relation.isU2RequestU1()) {
                return getSentRequest(User, OtherUser);
            }
        }
        if (relation.isU1RequestU2()) {
            return getSentRequest(User, OtherUser);
        }
        return getAcceptRequest(User, OtherUser);
    }
// tuong tac U1RequestU2 va U2RequestU1 (update table)
    public boolean updateTableRelation(Relation relation, String query) {
        try {
            PreparedStatement ps = cnn.prepareStatement(query);
            ps.setString(1, relation.getUser1());
            ps.setString(2, relation.getUser2());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("dao.RelationDao.requestBetweenUser()");
            e.printStackTrace();
        }
        return false;
    }
// yêu cầu kết bạn
    // User1 gui yc ket ban cho User2
    public String requestAddFriend(String User1, String User2) {
        String U1RequestU2 = "UPDATE dbo.USERRELATION\n"
                + "	SET U1RequestU2 = 1\n"
                + "	WHERE UserID1 = ? AND UserID2 = ? ";
        String U2RequestU1 = "UPDATE dbo.USERRELATION\n"
                + "	SET U2RequestU1 = 1\n"
                + "	WHERE UserID1 = ? AND UserID2 = ? ";
        String query = "";
        Relation relation = getRelation(User1, User2);
        if (User1.compareTo(User2) > 0) {
            //relation.setU1RequestU2(true);
            query = U1RequestU2;
        } else {
            //relation.setU2RequestU1(true);
            query = U2RequestU1;
        }
        if (updateTableRelation(relation, query)) {
            return getDivRelation(User1, User2);
        }
        return null;
    }
// Hủy yêu cầu kết bạn
    // User2 huy yc ket ban cho User1

    public String unRequestAddFriend(String User1, String User2) {
        String U1RequestU2 = "UPDATE dbo.USERRELATION\n"
                + "	SET U1RequestU2 = 0\n"
                + "	WHERE UserID1 = ? AND UserID2 = ? ";
        String U2RequestU1 = "UPDATE dbo.USERRELATION\n"
                + "	SET U2RequestU1 = 0\n"
                + "	WHERE UserID1 = ? AND UserID2 = ? ";
        String query = "";
        Relation relation = getRelation(User1, User2);
        if (User1.compareTo(User2) > 0) {
            //relation.setU1RequestU2(true);
            query = U1RequestU2;
        } else {
            //relation.setU2RequestU1(true);
            query = U2RequestU1;
        }
        if (updateTableRelation(relation, query)) {
            return getDivRelation(User1, User2);
        }
        return null;
    }
// hủy kết bạn

    public String unFriend(String User1, String User2) {
        String unfriend = "UPDATE dbo.USERRELATION\n"
                + "SET isFriend= 0\n"
                + "WHERE UserID1 = ? AND UserID2 = ? ";
        Relation relation = getRelation(User1, User2);
        if(updateTableRelation(relation, unfriend)){
            return getDivRelation(User1, User2);
        }
        return null;
    }
}
