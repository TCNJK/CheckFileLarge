/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author van12
 */
@WebServlet(name = "LoadListFriend", urlPatterns = {"/LoadListFriend"})
public class LoadListFriend extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param user
     * @param request servlet request
     * @param response servlet response
     * @return
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    /*public String getDivFriend(User user) {
        return " <div class=\"row\" onclick=\"otherProfile('" + user.getUserID() + "')\">\n"
                + "                <div class=\"col-md-6 col-xl-4\">                       \n"
                + "                    <div class=\"card\">\n"
                + "                        <div class=\"card-body\">\n"
                + "                            <div class=\"media align-items-center\">\n"
                + "                                <img src = \"" + user.getImgUser() + "\" class=\"avatar avatar-xl mr-3\">\n"
                + "                                <div class=\"media-body overflow-hidden\">\n"
                + "                                    <h5 class=\"card-text mb-0\">" + user.getFullName() + "</h5>\n"
                + "                                    <p class=\"card-text text-uppercase text-muted\">" + user.getNation() + "</p>\n"
                + "\n"
                + "                                </div>\n"
                + "                                <i class=\"icon fa-regular fa-message\"></i>\n"
                + "                                <i class=\"fa-solid fa-user-minus\"></i>  \n"
                + "                                \n"
                + "                            </div><a href=\"#\" class=\"tile-link\"></a>\n"
                + "                            \n"
                + "                        </div>\n"
                + "                    </div>\n"
                + "                </div>";
    }
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = (String) request.getSession().getAttribute("id");
        int offset = Integer.parseInt(request.getParameter("offset"));
        ArrayList<User> userList = new dao.UserDAO().getUserFriend(id, offset);
        String str = "";
        if (!userList.isEmpty()) {
            for (int i = 0; i < userList.size(); i++) {
                str += userList.get(i).getDivFriend();
            }
            try ( PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println(str);
            }
        } else {
            try ( PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("null");
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
