/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class Relation {
//    String isfriend= "<div style='color: blue'><i class='fa-solid fa-user-check'></i> Your Friend </div>";
//    String request= "<div style='color: black'><i class='fa-solid fa-people-arrows'></i> Requested </div>";
//    String isNotFriend= "<div style='color: black'><i class='fa-solid fa-user-check'></i> Stranger </div>";

    private String User1, User2;
    private boolean U1RequestU2;
    private boolean U2RequestU1;
    private boolean isFriend;
    //User1 lúc nào cũng > User2

    public Relation(String User1, String User2) {
        if (User1.compareTo(User2) < 0) {
            this.User1 = User2;
            this.User2 = User1;
        } else {
            this.User1 = User1;
            this.User2 = User2;
        }
        new dao.RelationDao("relate").createRelation(this.User1 , this.User2);
    }

    public Relation(String User1, String User2, boolean U1RequestU2, boolean U2RequestU1, boolean isFriend) {
        if (User1.compareTo(User2) < 0) {
            this.User1 = User2;
            this.User2 = User1;
        } else {
            this.User1 = User1;
            this.User2 = User2;
        }
        new dao.RelationDao("relate").createRelation(this.User1, this.User2);
        this.U1RequestU2 = U1RequestU2;
        this.U2RequestU1 = U2RequestU1;
        this.isFriend = isFriend;
    }

    public String getUser1() {
        return User1;
    }

    public void setUser1(String User1) {
        this.User1 = User1;
    }

    public String getUser2() {
        return User2;
    }

    public void setUser2(String User2) {
        this.User2 = User2;
    }

    public boolean isU1RequestU2() {
        return U1RequestU2;
    }

    public void setU1RequestU2(boolean U1RequestU2) {
        this.U1RequestU2 = U1RequestU2;
    }

    public boolean isU2RequestU1() {
        return U2RequestU1;
    }

    public void setU2RequestU1(boolean U2RequestU1) {
        this.U2RequestU1 = U2RequestU1;
    }

    public boolean isIsFriend() {
        return isFriend;
    }

    public void setIsFriend(boolean isFriend) {
        this.isFriend = isFriend;
    }

}
