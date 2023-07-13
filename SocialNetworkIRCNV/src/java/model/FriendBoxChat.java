/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Hashtable;

/**
 *
 * @author TCNJK
 */
public class FriendBoxChat {
    String UserID,friendID,FriendName;
    Hashtable<Integer, String> listChatID;
    Hashtable<Integer, String> list;
    Hashtable<Integer, Boolean> listWho;
    public FriendBoxChat(String UserID, String friendID) {
        this.UserID = UserID;
        this.friendID = friendID;
        list= new Hashtable<>();
        listWho= new Hashtable<>();
        listChatID = new Hashtable<>();
    }

    public String getFriendName() {
        return FriendName;
    }

    public void setFriendName(String FriendName) {
        this.FriendName = FriendName;
    }

   
    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getFriendID() {
        return friendID;
    }

    public void setFriendID(String friendID) {
        this.friendID = friendID;
    }

    public Hashtable<Integer, String> getListChatID() {
        return listChatID;
    }

    public void setListChatID(Hashtable<Integer, String> listChatID) {
        this.listChatID = listChatID;
    }

    public Hashtable<Integer, String> getList() {
        return list;
    }

    public void setList(Hashtable<Integer, String> list) {
        this.list = list;
    }

    public Hashtable<Integer, Boolean> getListWho() {
        return listWho;
    }

    public void setListWho(Hashtable<Integer, Boolean> listWho) {
        this.listWho = listWho;
    }

    
    
}
