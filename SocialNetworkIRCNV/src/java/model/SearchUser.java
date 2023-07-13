/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import controller.Text;
import dao.UserDAO;

/**
 *
 * @author van12
 */
public class SearchUser {
    private String UserID, fullName, img_user, link_href;
    private int mutual_friend;

    public SearchUser(String UserID, String fullName, String img_user, int mutual_friend) throws Exception{
        Text text= new controller.Text();
        this.UserID= UserID;
        if(img_user==null||img_user.isEmpty())
            this.img_user = "https://cdn-icons-png.flaticon.com/512/1946/1946429.png";
        else this.img_user = "/SocialNetworkIRCNV/"+img_user;
        this.fullName =fullName;
        this.link_href= "../PersonalPage/ProfileUser.jsp?UID="+this.UserID;
        
        this.mutual_friend= mutual_friend;
    }

    public String getLink_href() {
        return link_href;
    }

    public void setLink_href(String link_href) {
        this.link_href = link_href;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getImg_user() {
        return img_user;
    }

    public void setImg_user(String img_user) {
        this.img_user = img_user;
    }

    public int getMutual_friend() {
        return mutual_friend;
    }

    public void setMutual_friend(int mutual_friend) {
        this.mutual_friend = mutual_friend;
    }
    
}
