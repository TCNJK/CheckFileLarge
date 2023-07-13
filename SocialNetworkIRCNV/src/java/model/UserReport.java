/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TCNJK
 */
public class UserReport {
    private String userID;
    private String imageUser;
    private String fullName;
    private String account;
    private String mail;
    private String phoneNumber;
    private String address;
    private int numCommentReported;
    private int numPostReported;
    private int numReportedByUsers;

    // Constructor
    
    public UserReport() {
    }

    public UserReport(String userID, String imageUser, String fullName, String account, String mail, String phoneNumber, String address, int numCommentReported, int numPostReported) {
        this.userID = userID;
        this.imageUser = imageUser;
        this.fullName = fullName;
        this.account = account;
        this.mail = mail;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.numCommentReported = numCommentReported;
        this.numPostReported = numPostReported;
    }

    // Getters and Setters
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getImageUser() {
        return "../"+imageUser;
    }

    public void setImageUser(String imageUser) {
        this.imageUser = imageUser;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getNumCommentReported() {
        return numCommentReported;
    }

    public void setNumCommentReported(int numCommentReported) {
        this.numCommentReported = numCommentReported;
    }

    public int getNumPostReported() {
        return numPostReported;
    }

    public void setNumPostReported(int numPostReported) {
        this.numPostReported = numPostReported;
    }

    public int getNumReportedByUsers() {
        return numReportedByUsers;
    }

    public void setNumReportedByUsers(int numReportedByUsers) {
        this.numReportedByUsers = numReportedByUsers;
    }
    
}
