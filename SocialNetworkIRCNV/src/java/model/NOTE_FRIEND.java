/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;

/**
 *
 * @author van12
 */
public class NOTE_FRIEND extends NOTE {

    private String UserIDRequest, status;
//NoteID, UserID, UserIDRequest, TimeRequest, statusNote 
//    public NOTE_FRIEND(String Note_ID,String User_ID, String UserIDRequest, String time, String status) {
//        super(Note_ID, User_ID, time);
//        this.UserIDRequest = UserIDRequest;
//        this.status = status;
//    }

    public NOTE_FRIEND(String Note_ID, String User_ID, String UserIDRequest, String time, String status, boolean isRead) {
        super(Note_ID, User_ID, time, isRead);
        this.UserIDRequest = UserIDRequest;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserIDRequest() {
        return UserIDRequest;
    }

    public void setUserIDRequest(String UserIDRequest) {
        this.UserIDRequest = UserIDRequest;
    }

    /*
    -- sent    : nguoi dung khac yeu cau
    -- request : minh yeu cau
    -- accepted: yeu cau cua minh duoc chap nhan
    -- isFriend: minh chap nhan yeu cau
   -- Duyệt qua từng hàng và thực hiện các câu lệnh tương ứng
     */
    public String getStatus(String status) {
        if (status.equals("sent")) {
            return " is request Add friend";
        }
        if (status.equals("request")) {
            return " is Person that you sent a request ";
        }
        if (status.equals("accepted")) {
            return " is accpect your request";
        }
        if (status.equals("sent")) {
            return " is person that you accept request";
        }
        return "";
    }

    public String getDiv() {
        User userRequest = new dao.UserDAO().getUserByID(UserIDRequest);

        return "<div class=\"friend-requests\" id=\"" + super.getNote_ID() + "\" onclick=\"otherProfile('" + this.UserIDRequest + "')\">\n"
                + "                                <!-- Existing friend request boxes -->\n"
                + "\n"
                + "                                <div class=\"friend-box\" id=\"NoteID\">\n"
               
                + "                                    <div class=\"friend-profile\" style=\"background-image: url(" + userRequest.getImgUser().replaceAll(" ", "%20") + ");\"></div>\n"
                + "                                    <div class=\"name-box\">" + userRequest.getFullName() + "<i class=\"fa-solid fa-user-group\"></i>" + " </div>\n"
                + "                                    <div class=\"user-name-box\">" + super.getTime() + " <br> " + userRequest.getFullName() + getStatus(this.status.trim()) + "</div>\n"
                + "                                    <div class=\"request-btn-row\" data-username=\"silvergoose115\">\n"
                + "\n"
                + "                                    </div>\n"
                + "                                </div>\n"
                + "                            </div>";
    }

}
