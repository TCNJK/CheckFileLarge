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

/**
 *
 * @author van12
 */
@WebServlet(name = "DeletePost", urlPatterns = {"/DeletePost"})
public class DeletePost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String PostID = request.getParameter("PostID");
        String Type = request.getParameter("Type");
        System.out.println("PostID: " + PostID);
        String id = (String) request.getSession().getAttribute("id");
        String role = (String) request.getSession().getAttribute("userRole");
        if( role == null) role= "user";
        dao.PostUserDAO api = new dao.PostUserDAO(id);
        
        try ( PrintWriter out = response.getWriter()) {
            if (Type.equalsIgnoreCase("Post")) {
                boolean checkExist = api.checkExistPostUser(PostID, id);
                /* TODO output your page here. You may use following sample code. */
                if (checkExist || role.equals("Admin") || role.equals("Master Admin")) {
                    api.deletePost(PostID, id);
                    out.print("true");

                } else {
                    out.print("null");
                }

            } else if (Type.equalsIgnoreCase("Share")) {
                boolean checkExist = api.checkExistPosSharetUser(PostID, id);
                if (checkExist || role.equals("Admin") || role.equals("Master Admin")) {
                    api.deletePostShare(PostID, id);
                    out.print("true");

                } else {
                    out.print("null");
                }
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
