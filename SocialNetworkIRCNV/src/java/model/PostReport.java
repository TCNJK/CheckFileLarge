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
public class PostReport {

    String postID;
    boolean isPost;
    int isPostVerInt;
    String img;
    String content;
    int reportCount;
    Date time;

    public PostReport(String postID, boolean isPost, String img, String content, int reportCount, Date time) {
        this.postID = postID;
        this.isPost = isPost;
        if (img == null) {
            img = "";
        }
        this.img = img;
        if (content == null) {
            content = "";
        }

        this.content = content;
        this.reportCount = reportCount;
        this.time = time;
    }

    public String getPostID() {
        return postID;
    }

    public void setPostID(String postID) {
        this.postID = postID;
    }

    public boolean isIsPost() {
        return isPost;
    }

    public void setIsPost(boolean isPost) {
        this.isPost = isPost;
    }

    public String getImg() {
//        String imagePath = img;
//        String trimmedPath ="";
//        if (!img.isBlank()) {
//            int secondOccurrenceIndex = imagePath.indexOf("data/post", imagePath.indexOf("data/post") + 1);
//            trimmedPath = imagePath.substring(secondOccurrenceIndex);
//        }
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getReportCount() {
        return reportCount;
    }

    public void setReportCount(int reportCount) {
        this.reportCount = reportCount;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getIsPostVerInt() {
        if (isPost==true) return 1;
        return 0;
    }

    public void setIsPostVerInt(int isPostVerInt) {
        this.isPostVerInt = isPostVerInt;
    }
    
}
