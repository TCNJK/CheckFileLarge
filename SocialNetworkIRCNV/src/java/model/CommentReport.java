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
public class CommentReport {

    String commentID;
    boolean isPost;
    int isPostVerInt;
    String img;
    String content;
    int reportCount;
    Date time;

    public CommentReport(String commentID, boolean isPost, String img, String content, int reportCount, Date time) {
        this.commentID = commentID;
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

    public String getCommentID() {
        return commentID;
    }

    public void setCommentID(String commentID) {
        this.commentID = commentID;
    }

    public boolean isIsPost() {
        return isPost;
    }

    public void setIsPost(boolean isPost) {
        this.isPost = isPost;
    }

    public int getIsPostVerInt() {
        if (isPost==true) return 1;
        return 0;
    }

    public void setIsPostVerInt(int isPostVerInt) {
        this.isPostVerInt = isPostVerInt;
    }

    public String getImg() {
        String imagePath = img;
        String trimmedPath = "";
//        if (!img.isBlank()) {
//            int secondOccurrenceIndex = imagePath.indexOf("data/post", imagePath.indexOf("data/post") + 1);
//            trimmedPath = imagePath.substring(secondOccurrenceIndex);
//        }
        return "../" + trimmedPath;
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

}
