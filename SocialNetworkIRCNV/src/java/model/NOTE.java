/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class NOTE {
    private String Note_ID;
    private String User_ID;
    private String time;
    private boolean isRead;

//    public NOTE(String Note_ID, String User_ID, String time) {
//        this.Note_ID = Note_ID;
//        this.User_ID = User_ID;
//        this.time = time;
//    }

    public NOTE(String Note_ID, String User_ID, String time, boolean isRead) {
        this.Note_ID = Note_ID;
        this.User_ID = User_ID;
        this.time = time;
        this.isRead = isRead;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public String getNote_ID() {
        return Note_ID;
    }

    public void setNote_ID(String Note_ID) {
        this.Note_ID = Note_ID;
    }

    public String getUser_ID() {
        return User_ID;
    }

    public void setUser_ID(String User_ID) {
        this.User_ID = User_ID;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
}
