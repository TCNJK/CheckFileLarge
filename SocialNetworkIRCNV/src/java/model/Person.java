/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package model;

/**
 *
 * @author 84384
 */
public  class Person {

    private String UserID, FullName, Address, Mail, PhoneNumber, DOB;
    private boolean Gender;

    public Person(String FullName, String Mail, String DOB, boolean Gender) {
        this.FullName = FullName;
        this.Mail = Mail;
        this.DOB = DOB;
        this.Gender = Gender;
    }

    public Person() {
    }

    public Person(String UserID, String FullName, String Address, String Mail, String PhoneNumber, String DOB, boolean Gender) {
        this.UserID = UserID;
        this.FullName = FullName;
        this.Address = Address;
        this.Mail = Mail;
        this.PhoneNumber = PhoneNumber;
        this.DOB = DOB;
        this.Gender = Gender;
    }

    public Person(String FullName, String Mail, String DOB) {
        this.FullName = FullName;
        this.Mail = Mail;
        this.DOB = DOB;
    }

    
    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getMail() {
        return Mail;
    }

    public void setMail(String Mail) {
        this.Mail = Mail;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean Gender) {
        this.Gender = Gender;
    }

    @Override
    public String toString() {
        return "Person{" + "UserID=" + UserID + ", FullName=" + FullName + ", Address=" + Address + ", Mail=" + Mail + ", PhoneNumber=" + PhoneNumber + ", DOB=" + DOB + ", Gender=" + Gender + '}';
    }
    
}
