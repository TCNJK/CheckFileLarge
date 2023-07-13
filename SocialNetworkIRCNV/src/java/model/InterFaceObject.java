/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author van12
 */
public class InterFaceObject {
    private String UserID, PostOrShareID, InterFaceID, InterFaceName, InterFaceDiv;

    public InterFaceObject(String UserID, String PostOrShareID, String InterFaceID, String InterFaceName, String InterFaceDiv) {
        this.UserID = UserID;
        this.PostOrShareID = PostOrShareID;
        this.InterFaceID = InterFaceID;
        this.InterFaceName = InterFaceName;
        this.InterFaceDiv = InterFaceDiv;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String UserID) {
        this.UserID = UserID;
    }

    public String getPostOrShareID() {
        return PostOrShareID;
    }

    public void setPostOrShareID(String PostOrShareID) {
        this.PostOrShareID = PostOrShareID;
    }

    public String getInterFaceID() {
        return InterFaceID;
    }

    public void setInterFaceID(String InterFaceID) {
        this.InterFaceID = InterFaceID;
    }

    public String getInterFaceName() {
        return InterFaceName;
    }

    public void setInterFaceName(String InterFaceName) {
        this.InterFaceName = InterFaceName;
    }

    public String getInterFaceDiv() {
        return InterFaceDiv;
    }

    public void setInterFaceDiv(String InterFaceDive) {
        this.InterFaceDiv = InterFaceDive;
    }
    
}
