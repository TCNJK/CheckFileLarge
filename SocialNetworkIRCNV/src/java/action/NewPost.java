/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import controller.Text;
import dao.PostUserDAO;
import java.util.Date;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.PostShare;
import model.PostUser;
import model.User;

/**
 *
 * @author van12
 */
@MultipartConfig
@WebServlet(name = "NewPost", urlPatterns = {"/NewPost"})
public class NewPost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void saveFile(Part part, String realPath) {

    }

    //UserID
    //Content
    //ImagePost
    //PublicPost
    public void createNewPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try {
                Text text = new Text();
                //
                HttpSession session = request.getSession();
                String id = (String) session.getAttribute("id");

                String content = text.changeUTF8(request.getParameter("content"));
                String isPublic = request.getParameter("privacy");
                //get path image
                Part part = request.getPart("photo");
                String PostID = "";
                if (part != null && part.getSubmittedFileName() != null) {
                    //khởi tạo controldata
                    ControlData data = new ControlData(part, getServletContext());
                    // save to db
                    PostID = new PostUserDAO(id).newPost(id, content, data.getFilename(), isPublic);
                    //khowri tao cho viec bai post
                    data.createInitForPost(PostID);
                    //create folder
                    data.creatFolder();
                    // save image
                    data.SaveImage();
                    System.out.println("path: " + data.getRealPath());
                } else {
                    PostID = new PostUserDAO(id).newPost(id, content, "", isPublic);
                }
                //respone
//                String publicpost = isPublic.endsWith("1") ? "Public" : "Private";
                User user = new dao.UserDAO().getUserByID(id);
                PostUser postUser = new dao.PostUserDAO(id).getPost(PostID);
//                String pathImg = "..s/SocialNetworkIRCNV/data/post/" + postUser.getImagePost();
                out.println("<div class=\"post\" style=\"margin: 10px; background: white; border-radius: 10px\" id=\"" + postUser.getPostID() + "\">\n"
                        + "            <div class=\"post-top\">\n"
                        + "                <p style=\"display: none\">" + postUser.getPostID() + "</p>\n"
                        + "                <div class=\"dp\" >\n"
                        + "                    <img src=\"" + user.getImgUser() + "\" alt=\"\" style=\"width: 100%;\" >\n"
                        + "                </div>\n"
                        + "                <div class=\"post-info\">\n"
                        + "                    <p class=\"name\" style=\"color: #003140\">" + user.getFullName() + "</p>\n"
                        + "                    <span class=\"time\" style=\"color: #70d8ff\">" + postUser.getTimePost() + "</span>\n"
                        + "                    <span class=\"time\" style=\"color: #003140\">" + (postUser.getPrivacyName()) + "</span>\n"
                        + "                </div>\n"
                        + "                <i class=\" dropdown fas fa-ellipsis-h\">\n"
                        + "                    <div >\n"
                        + "\n"
                        + "                        <div class=\"dropdown-content\">\n"
                        + "                            <a href=\"#\" onclick=\"deletePost('" + postUser.getPostID() + "', 'Post')\">Delete</a>\n"
                        + "                            <a href=\"#\" onclick=\"modifyPost('" + postUser.getPostID().trim() + "', '" + postUser.getImgUser() + "', '" + user.getFullName().trim() + "', '" + postUser.getTimePost() + "',\n"
                        + "                                            '" + postUser.getPrivacyName() + "', '" + postUser.getContent().trim() + "', '" + postUser.getImagePost() + "')\">Modify</a>\n"
                        + "                        </div>\n"
                        + "                    </div>\n"
                        + "                </i>\n"
                        + "            </div>\n"
                        + "\n"
                        + "            <div class=\"post-content\" style=\"text-align: center;\">\n"
                        + "                <p style=\"text-align: left;\">" + postUser.getContent() + "</p>\n"
                        + "                <c:if test=\"${img_post!=null && img_post!=''}\">\n"
                        + "                    <img src=\"" + postUser.getImagePost() + "\"style=\"margin: 0 auto; max-width: 100%\"/>\n"
                        + "                </c:if>\n"
                        + "            </div>\n"
                        + "            <div class=\"counter\">\n"
                        + "                <div class=\"count-like\">\n"
                        + "                    <span>" + postUser.getNumInterface() + "</span>\n"
                        + "                </div>\n"
                        + "                <div class=\"count-cmt\">\n"
                        + "                    <span>" + postUser.getNumComment() + "</span>\n"
                        + "                </div>\n"
                        + "                <div class=\"count-share\">\n"
                        + "                    <span>" + postUser.getNumShare() + "</span>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "\n"
                        + "\n"
                        + "            <div class=\"post-bottom\" style=\" width: 90%; color:  #00abfd; border-top: 1px #00587c solid; margin-left: 5%; padding: 0 5%;\">\n"
                        + "                <div class=\"action\">\n"
                        + "                    <i class=\"far fa-thumbs-up\"></i>\n"
                        + "                    <span>Like</span>\n"
                        + "                </div>\n"
                        + "                <div class=\"action\" onclick=\"openPost('"+postUser.getPostID()+"')\">\n"
                        + "                    <a href=\"#writecomment\" style=\"text-decoration: none; color:  #00abfd;\">\n"
                        + "                        <i class=\"far fa-comment\"></i>\n"
                        + "                        <span>Comment</span>\n"
                        + "                    </a>\n"
                        + "                </div>\n"
                        + "                <div class=\"action\" onclick=\"SharePost('" + postUser.getPostID() + "', '" + postUser.getImgUser() + "', '" + user.getImgUser() + "', '" + postUser.getContent().trim() + "', '" + postUser.getImagePost() + "')\">\n"
                        + "                    <i class=\" dropdown fa fa-share\">\n"
                        + "                    </i>\n"
                        + "                    <span>Share</span>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </div>      ");
            } catch (Exception e) {
                System.out.println("action.Upload.doPost()");
                e.printStackTrace();
                request.getRequestDispatcher("nonice.jsp").forward(request, response);
            }
        }
    }

    public void createNewPostShare(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            try {
                Text text = new Text();
                //
                HttpSession session = request.getSession();
                String id = (String) session.getAttribute("id");

                String content = text.changeUTF8(request.getParameter("content"));
                System.out.println("content: " + content);
                String isPublic = request.getParameter("privacy");
                //get path image
                String ShareID = "";
                String PostID = request.getParameter("PostID");

                ShareID = new dao.PostUserDAO(id).newPostShare(id, PostID, content, isPublic);
                //respone
//                String publicpost = isPublic.endsWith("1") ? "Public" : "Private";
                User userOwn = new dao.UserDAO().getUserByID(id);
                PostShare postShare = new dao.PostDAO(id).getPostShareByShareID(ShareID);
                User userShare = new dao.UserDAO().getUserByID(postShare.getUserID());

//                String pathImg = "../SocialNetworkIRCNV/data/post/" + postUser.getImagePost();
                out.println("\n"
                        + " <div id=\"showpost\">\n"
                        + "<%@page contentType=\"text/html\" pageEncoding=\"UTF-8\"%>\n"
                        + "<!DOCTYPE html>\n"
                        + "<html>\n"
                        + "    <head>\n"
                        + "        <meta charset=\"UTF-8\">\n"
                        + "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                        + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "        <link rel=\"shortcut icon\" href=\"./images/logo.png\" type=\"image/x-icon\">\n"
                        + "        <link href=\"https://fonts.googleapis.com/icon?family=Material+Icons\" rel=\"stylesheet\">\n"
                        + "        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css\"\n"
                        + "              integrity=\"sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==\"\n"
                        + "              crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\" />\n"
                        + "        <title>share Share</title>\n"
                        + "        <link rel=\"stylesheet\" href=\"/SocialNetworkIRCNV/css/postshare.css\">\n"
                        + "    </head>\n"
                        + "    <body>\n"
                        + "        <div class=\"share\" id=\"" + postShare.getIDshare() + "\">\n"
                        + "            <div class=\"share-head\">\n"
                        + "                <div class=\"dp\" >\n"
                        + "                    <img src=\"/SocialNetworkIRCNV/" + userShare.getImgUser() + "\" alt=\"\" style=\"width: 100%;\" >\n"
                        + "                </div>\n"
                        + "                <div class=\"share-info\">\n"
                        + "                    <p class=\"name\" style=\"color: #003140\">" + userShare.getFullName() + "</p>\n"
                        + "                    <span class=\"time\" style=\"color: #70d8ff\">" + postShare.getTimePost() + "</span>\n"
                        + "                    <span class=\"time\" style=\"color: #003140\">" + postShare.getPrivacyName() + "</span>\n"
                        + "                </div>\n"
                        + "                <i class=\" dropdown fas fa-ellipsis-h\">\n"
                        + "                    <div >\n"
                        + "\n"
                        + "                        <div class=\"dropdown-content\">\n"
                        + "                            <a href=\"#\" onclick=\"deletePost('" + postShare.getIDshare() + "', 'Share')\">Delete</a>\n"
                        + "                            <a href=\"#\" onclick=\"\">Modify</a>\n"
                        + "\n"
                        + "                        </div>\n"
                        + "                    </div>\n"
                        + "                </i>\n"
                        + "\n"
                        + "            </div>\n"
                        + "            <div class=\"share-content\">\n"
                        + "                " + postShare.getContent() + "\n"
                        + "            </div>\n"
                        + "            <div class=\"share-body\">\n"
                        + "                <div class=\"share-top\" >\n"
                        + "                    <div class=\"dp\" >\n"
                        + "                        <img src=\"/SocialNetworkIRCNV/" + userOwn.getImgUser() + "\" alt=\"\" style=\"width: 100%;\" >\n"
                        + "                    </div>\n"
                        + "                    <div class=\"share-info\">\n"
                        + "                        <p class=\"name\" style=\"color: #003140\">" + userOwn.getFullName() + "</p>\n"
                        + "                        <span class=\"time\" style=\"color: #70d8ff\">" + postShare.getTimePostDown() + "</span>\n"
                        + "                    </div>\n"
                        + "\n"
                        + "                </div>\n"
                        + "\n"
                        + "                <div class=\"share-content\" style=\"text-align: center;\" >\n"
                        + "                    <p style=\"text-align: left;\">" + postShare.getContentDown() + "</p>\n"
                        + "                    <img src=\"/SocialNetworkIRCNV/" + postShare.getImg_post() + "\" />\n"
                        + "                </div>\n"
                        + "            </div> \n"
                        + "\n"
                        + "            <div class=\"counter\">\n"
                        + "                <div class=\"count-like\">\n"
                        + "                    <span>" + postShare.getNumInterface() + "</span>\n"
                        + "                </div>\n"
                        + "                <div class=\"count-cmt\">\n"
                        + "                    <span>" + postShare.getNumComment() + "</span>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "            <div class=\"share-bottom\" style=\" width: 90%; color:  #00abfd; border-top: 1px #00587c solid; margin-left: 5%; padding: 0 5%;\">\n"
                        + "                <div class=\"action\">\n"
                        + "                    <i class=\"far fa-thumbs-up\"></i>\n"
                        + "                    <span>Like</span>\n"
                        + "                </div>\n"
                        + "                <div class=\"action\" onclick=\"openPost('"+postShare.getIDshare()+"')\">\n"
                        + "                    <a href=\"#writecomment-share\" style=\"text-decoration: none; color:  #00abfd;\">\n"
                        + "                        <i class=\"far fa-comment\"></i>\n"
                        + "                        <span>Comment</span>\n"
                        + "                    </a>\n"
                        + "                </div>\n"
                        + "                <div class=\"action\" onclick=\"SharePost(" + postShare.getPostID() + ", '/SocialNetworkIRCNV/" + postShare.getImgUserDown() + "','" + userOwn.getFullName() + "' ,'" + postShare.getContentDown() + "' ,'/SocialNetworkIRCNV/" + postShare.getImg_post() + "')\">\n"
                        + "                    <i class=\" dropdown fa fa-share\">\n"
                        + "                    </i>\n"
                        + "                    <span>Share</span>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "\n"
                        + "        </div>\n"
                        + "    </body>\n"
                        + "</html>"
                        + "</div>");
            } catch (Exception e) {
                System.out.println("action.Upload.doPost()");
                e.printStackTrace();
                request.getRequestDispatcher("nonice.jsp").forward(request, response);
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String type = request.getParameter("Type");
        if (type.equalsIgnoreCase("Post")) {
            try {
                createNewPost(request, response);
            } catch (Exception e) {
                System.out.println("action.NewPost.processRequest()");
                e.printStackTrace();
            }
        } else if (type.equalsIgnoreCase("Share")) {
            try {
                createNewPostShare(request, response);
            } catch (Exception e) {
                System.out.println("action.NewPost.processRequest()");
                e.printStackTrace();
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
