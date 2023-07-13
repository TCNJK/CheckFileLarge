/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class Privacy {
    private String PrivacyID, PrivacyName;

    public Privacy(String PrivacyID, String PrivacyName) {
        this.PrivacyID = PrivacyID;
        this.PrivacyName = PrivacyName;
    }

    public String getPrivacyID() {
        return PrivacyID;
    }

    public void setPrivacyID(String PrivacyID) {
        this.PrivacyID = PrivacyID;
    }

    public String getPrivacyName() {
        return PrivacyName;
    }

    public void setPrivacyName(String PrivacyName) {
        this.PrivacyName = PrivacyName;
    }
    
}
