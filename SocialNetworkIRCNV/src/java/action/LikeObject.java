/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import dao.BusinessDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Advertisement;
import model.CommentChild;
import model.Comment;
import model.PostShare;
import model.PostUser;

/**
 *
 * @author van12
 */
@WebServlet(name = "LikeObject", urlPatterns = {"/LikeObject"})
public class LikeObject extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public String getInterfaceID(String InterfaceId){
        if(InterfaceId.equalsIgnoreCase("none"))
            return "like";
        return "none";
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id= (String) request.getSession().getAttribute("id");
        String ObejectID= request.getParameter("ObejectID");
        String Type= request.getParameter("Type");
        
        new dao.InterFaceObjectDAO().setInterFaceObjectBy(ObejectID, id, getInterfaceID(Type));
        String div="";
        if(ObejectID.substring(0, 3).equalsIgnoreCase("PID")){
            PostUser postUser= new dao.PostDAO(id).getPostUserByPostID(ObejectID);
            div= postUser.getUpdateDiv();
        }else if(ObejectID.substring(0, 3).equalsIgnoreCase("SID")){
            PostShare postShare= new dao.PostDAO(id).getPostShareByShareID(ObejectID);
            div= postShare.getUpdateDiv();
        }else if(ObejectID.substring(0, 3).equalsIgnoreCase("ILD")){
            CommentChild commentChild= new dao.CommentDAO().getCommentChildByChildID(ObejectID);
            div= commentChild.getUpdateDiv(id);
        }else if(ObejectID.substring(0, 3).equalsIgnoreCase("CID")){
            Comment comment= new dao.CommentDAO().getCommentByCmtID(ObejectID);
            div= comment.getUpdateDiv(id);
        }else if(ObejectID.substring(0, 3).equalsIgnoreCase("AID")){
            Advertisement advertisement= new BusinessDAO().getAdvertisementByAdvertiserID(ObejectID);
            advertisement.setIDUserCurrent(id);
            div= advertisement.getUpdateDiv();
        }
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println(div);
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
