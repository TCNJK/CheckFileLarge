/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import javax.servlet.ServletContext;
import javax.servlet.http.Part;
import model.CommentChild;
import model.Comment;
/**
 *
 * @author van12
 */
public class ControlData {
    // duong dan se duoc luu vao db
    String pathForDb;
    // dau vao file
    Part part;
    // duong dan toi src anh thong qua build
    String realPath;
    // duong dan toi src anh thong qua build
    String realPathBuild;
    // ten file
    String filename;
    // duong dan toi project
    String projectRootPath;
//    public String getRootProject(ServletContext context) {
//
//        String projectPath = context.getRealPath("/");
//        int lastIndexOfWeb = projectPath.lastIndexOf("\\build");
////        String projectRootPath = projectPath.substring(0, lastIndexOfWeb) + "\\web";
//        return projectPath.substring(0, lastIndexOfWeb);
//    }

//    public ControlData() {
//
//    }

    public Part getPart() {
        return part;
    }

    public String getRealPath() {
        return realPath;
    }

    public String getRealPathBuild() {
        return realPathBuild;
    }

    public String getFilename() {
        return filename;
    }


//
//    public ControlData(Part part, String realPath, String realPathBuild, String filename, String projectRootPath) {
//        this.part = part;
//        this.realPath = realPath;
//        this.realPathBuild = realPathBuild;
//        this.filename = filename;
//        this.projectRootPath = projectRootPath;
//    }

    // truyen Part cua <input type= 'file'>
    // ServletContext context lay tu getServletContext() co san trong servlet
    public ControlData(Part part, ServletContext context) {
        this.part = part;
        this.filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
        String projectPath = context.getRealPath("/");
        int lastIndexOfWeb = projectPath.lastIndexOf("\\build");
        this.projectRootPath = projectPath.substring(0, lastIndexOfWeb);
    }
// chỉ khởi tạo 1 lần dành cho từng phần như lưu ảnh bài viết(post), ảnh đại diện(avatar), ảnh nền (backGround)
    public void createInitForPost(String PostID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\post\\" + PostID;
        this.realPath = projectRootPath + "\\web\\data\\post\\" + PostID;
        this.pathForDb= "data\\post\\"+ PostID;
    }
    public void createInitForCommentChild(CommentChild commentChild) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\post\\" + commentChild.getPostID()+"\\"+ commentChild.getCmtID()+"\\"+commentChild.getChilID();
        this.realPath = projectRootPath + "\\web\\data\\post\\" + commentChild.getPostID()+"\\"+ commentChild.getCmtID()+"\\"+commentChild.getChilID();
        this.pathForDb= "data\\post\\"+ commentChild.getPostID()+"\\"+ commentChild.getCmtID()+"\\"+commentChild.getChilID();
    }
    public void createInitForComment(Comment comment) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\post\\" + comment.getPostID()+"\\"+comment.getCmtID();
        this.realPath = projectRootPath + "\\web\\data\\post\\" + comment.getPostID()+"\\"+comment.getCmtID();
        this.pathForDb= "data\\post\\"+ comment.getPostID()+"\\"+comment.getCmtID();
    }
    public void createInitForAvatar(String UserID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\user\\" + UserID + "\\avatar";
        this.realPath = projectRootPath + "\\web\\data\\user\\" + UserID + "\\avatar";
        this.pathForDb= "data\\user\\" + UserID + "\\avatar";
    }

    public void createInitForBackGround(String UserID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\user\\" + UserID + "\\background";
        this.realPath = projectRootPath + "\\web\\data\\user\\" + UserID + "\\background";
        this.pathForDb= "data\\user\\" + UserID + "\\background";
    }
    
    public void createInitForBusinessPost(String BusinessID, String AdvertiserID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\business\\"+BusinessID+ "\\" + AdvertiserID + "\\post";
        this.realPath = projectRootPath + "\\web\\data\\business\\"+BusinessID+ "\\" + AdvertiserID + "\\post";
        this.pathForDb= "data\\business\\"+BusinessID+ "\\" + AdvertiserID + "\\post";
    }
    public void createInitForBusinessAvatar(String BID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\business\\" + BID + "\\avatar";
        this.realPath = projectRootPath + "\\web\\data\\business\\" + BID + "\\avatar";
        this.pathForDb= "data\\business\\" + BID + "\\avatar";
    }
    public void createInitForBusinessBackGround(String BID) {
        this.realPathBuild = projectRootPath + "\\build\\web\\data\\business\\" + BID + "\\background";
        this.realPath = projectRootPath + "\\web\\data\\business\\" + BID + "\\background";
        this.pathForDb= "data\\business\\" + BID + "\\background";
    }
    //UserID
    //Content
    //ImagePost
    //PublicPost
// tạo folder
    public void creatFolder() throws Exception {
        //create folder
        if (!Files.exists(Path.of(this.realPath))) {
            Files.createDirectories(Path.of(this.realPath));
        }
        if (!Files.exists(Path.of(this.realPathBuild))) {
            Files.createDirectories(Path.of(this.realPathBuild));
        }
    }
// luu anh vao den src/ den build den src
    public void SaveImage() throws Exception {
        //part.write(realPath + "\\" + filename);
        //part.write(realPathBuild + "\\" + filename);
        //System.out.println("path: " + realPath + "\\" + filename);
        InputStream inputStream = this.part.getInputStream();
        OutputStream outputStream1 = new FileOutputStream(this.realPath + "\\" + this.filename);
        OutputStream outputStream2 = new FileOutputStream(this.realPathBuild + "\\" + this.filename);

        byte[] buffer = new byte[1024];
        int length;
        while ((length = inputStream.read(buffer)) != -1) {
            outputStream1.write(buffer, 0, length);
            outputStream2.write(buffer, 0, length);
        }

        inputStream.close();
        outputStream1.close();
        outputStream2.close();
    }
}
