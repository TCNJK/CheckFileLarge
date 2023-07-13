/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.CommentChild;
import model.Comment;
/**
 *
 * @author van12
 */
@MultipartConfig
@WebServlet(name = "NewComment", urlPatterns = {"/NewComment"})
public class NewComment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void excuteComment(HttpServletRequest request, HttpServletResponse response, String id, String object, String content, Part part) {
         Comment comment = new Comment();
        comment.setUserID(id);
        comment.setContent(content);
        comment.setPostID(object);
        try {
            if (part != null && part.getSubmittedFileName() != null) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                comment.setImageComment(data.getFilename());
                comment = new dao.CommentDAO().newCommentWithImage(comment);
                //khowri tao cho viec bai post
                data.createInitForComment(comment);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
            } else {
                comment = new dao.CommentDAO().newCommentWithoutImage(comment);
            }
        } catch (Exception e) {
            System.out.println("action.NewComment.excuteCommentChild()");
            e.printStackTrace();
        }

        //printout
        try ( PrintWriter out = response.getWriter()) {
            out.println(comment.getDiv(id));
        } catch (Exception e) {
            System.out.println("action.NewComment.excuteCommentChild()");
            e.printStackTrace();
        }
    }
    public void excuteCommentChild(HttpServletRequest request, HttpServletResponse response, String id, String object, String content, Part part) {
        CommentChild commentChild = new CommentChild();
        commentChild.setUserID(id);
        commentChild.setContent(content);
        commentChild.setCmtID(object);
        //Comment comment= new dao.CommentDAO().getCommentByCmtID(object);
        //commentChild.setPostID(comment.getPostID());
        try {
            if (part != null && part.getSubmittedFileName() != null) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                commentChild.setImageComment(data.getFilename());
                commentChild = new dao.CommentDAO().newCommentChildWithImage(commentChild);
                //khowri tao cho viec bai post
                data.createInitForCommentChild(commentChild);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
                System.out.println("path: " + data.getRealPathBuild());
            } else {
                commentChild = new dao.CommentDAO().newCommentChildWithoutImage(commentChild);
            }
        } catch (Exception e) {
            System.out.println("action.NewComment.excuteCommentChild()");
            e.printStackTrace();
        }

        //printout
        try ( PrintWriter out = response.getWriter()) {
            out.println(commentChild.getDiv(id));
        } catch (Exception e) {
            System.out.println("action.NewComment.excuteCommentChild()");
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String object = request.getParameter("id");
         String content="";
        try {
           content= new controller.Text().changeUTF8(request.getParameter("content"));
        } catch (Exception e) {
            System.out.println("action.NewComment.processRequest()");
            e.printStackTrace();
        }
        
        Part part = request.getPart("photo");
        //get path image
        if (object.substring(0, 3).equalsIgnoreCase("CID")) {
            excuteCommentChild(request, response, id, object, content, part);
        }else if (object.substring(0, 3).equalsIgnoreCase("PID")) {
            excuteComment(request, response, id, object, content, part);
        }else if (object.substring(0, 3).equalsIgnoreCase("AID")) {
            excuteComment(request, response, id, object, content, part);
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
