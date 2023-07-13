/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author TCNJK
 */
public class Admin_UserManage {

    private String userID;
    private String imageUser;
    private String fullName;
    private String address;
    private String mail;
    private String account;
    private String phoneNumber;
    private Date dob;
    private String nation;
    private String roleID;

    // Constructor
    public Admin_UserManage(String userID, String imageUser, String fullName, String address, String mail,
            String account, String phoneNumber, Date dob, String nation, String roleID) {
        this.userID = userID;
        this.imageUser = imageUser;
        this.fullName = fullName;
        this.address = address;
        this.mail = mail;
        this.account = account;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.nation = nation;
        this.roleID = roleID;
    }

    // Getters and setters
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }
}
