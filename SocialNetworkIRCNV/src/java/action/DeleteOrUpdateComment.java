/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Comment;
import model.CommentChild;
import model.User;

/**
 *
 * @author van12
 */
@WebServlet(name = "DeleteOrUpdateComment", urlPatterns = {"/DeleteOrUpdateComment"})
public class DeleteOrUpdateComment extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // check la comment hay commentchild
    public boolean checkIsComment(String id){
        id= id.trim().substring(0, 3);
        if(id.equalsIgnoreCase("ILD"))
            return false;
        else if(id.equalsIgnoreCase("CID"))
            return true;
        return true;
    }
    public void delete(HttpServletRequest request, HttpServletResponse response){
        String CmtID= request.getParameter("id");
        if(checkIsComment(CmtID))
            new dao.CommentDAO().deleteCommentByCmtID(CmtID);
        else new dao.CommentDAO().deleteCommentChildByChildID(CmtID);
    }
    public void update(HttpServletRequest request, HttpServletResponse response){
        String CmtID= request.getParameter("id");
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String type= request.getParameter("type");
        if(type.equalsIgnoreCase("delete"))
            delete(request, response);
        else  update(request, response);
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
        String CmtID= request.getParameter("id");
        if(checkIsComment(CmtID)){
            Comment comment= new dao.CommentDAO().getCommentByCmtID(CmtID);
            User user= new dao.UserDAO().getUserByID(comment.getUserID());
            request.setAttribute("cmt", comment);
            request.setAttribute("user", user);
            
        }else{
            CommentChild commentChild= new dao.CommentDAO().getCommentChildByChildID(CmtID);
            User user= new dao.UserDAO().getUserByID(commentChild.getUserID());
            request.setAttribute("CmtID", commentChild);
            request.setAttribute("user", user);
        }
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
