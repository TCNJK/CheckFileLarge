/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class NOTE_COUNT {
    private String UserID;
    private int mess;
    private int note;

    public NOTE_COUNT(String UserID, int mess, int note) {
        this.UserID = UserID;
        this.mess = mess;
        this.note = note;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public int getMess() {
        return mess;
    }

    public void setMess(int mess) {
        this.mess = mess;
    }

    public int getNote() {
        return note;
    }

    public void setNote(int note) {
        this.note = note;
    }
    
}
