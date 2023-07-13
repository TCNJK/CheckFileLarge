package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author TCNJK
 */
public class FriendAndLastChat {

    private String FriendID, LastChat;
    boolean  ofYou;

    public FriendAndLastChat(String FriendID, String LastChat, boolean ofYou) {
        this.FriendID = FriendID;
        this.LastChat = LastChat;
        this.ofYou = ofYou;
    }

    public boolean isOfYou() {
        return ofYou;
    }

    public void setOfYou(boolean ofYou) {
        this.ofYou = ofYou;
    }
    public String getFriendID() {
        return FriendID;
    }

    public void setFriendID(String FriendID) {
        this.FriendID = FriendID;
    }

    public String getLastChat() {
        return LastChat;
    }

    public void setLastChat(String LastChat) {
        this.LastChat = LastChat;
    }

}
