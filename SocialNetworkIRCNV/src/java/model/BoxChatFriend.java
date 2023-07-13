/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author TCNJK
 */

public class BoxChatFriend {
    private String UserID;
    private ArrayList<FriendAndLastChat> list;

    public BoxChatFriend(String UserID) {
        this.UserID = UserID;
        this.list= new ArrayList<>();
    }
    
    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public ArrayList<FriendAndLastChat> getList() {
        return list;
    }

    public void setList(ArrayList<FriendAndLastChat> list) {
        this.list = list;
    }
    
}
