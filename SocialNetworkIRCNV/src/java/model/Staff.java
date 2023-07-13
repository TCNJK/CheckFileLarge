/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class Staff {
    private String BusinessID, UserID;
    boolean view_ads, edit_ads, add_ads, post_ads;

    public Staff(String BusinessID, String UserID, boolean view_ads, boolean edit_ads, boolean add_ads, boolean post_ads) {
        this.BusinessID = BusinessID;
        this.UserID = UserID;
        this.view_ads = view_ads;
        this.edit_ads = edit_ads;
        this.add_ads = add_ads;
        this.post_ads = post_ads;
    }

    public String getBusinessID() {
        return BusinessID;
    }

    public void setBusinessID(String BusinessID) {
        this.BusinessID = BusinessID;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public boolean isView_ads() {
        return view_ads;
    }

    public void setView_ads(boolean view_ads) {
        this.view_ads = view_ads;
    }

    public boolean isEdit_ads() {
        return edit_ads;
    }

    public void setEdit_ads(boolean edit_ads) {
        this.edit_ads = edit_ads;
    }

    public boolean isAdd_ads() {
        return add_ads;
    }

    public void setAdd_ads(boolean add_ads) {
        this.add_ads = add_ads;
    }

    public boolean isPost_ads() {
        return post_ads;
    }

    public void setPost_ads(boolean post_ads) {
        this.post_ads = post_ads;
    }
    
}
