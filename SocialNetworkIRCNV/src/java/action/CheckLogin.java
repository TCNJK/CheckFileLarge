/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Role;

/**
 *
 * @author 84384
 */
@WebServlet(name = "CheckLogin", urlPatterns = {"/CheckLogin"})
public class CheckLogin extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckLogin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckLogin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String id = new dao.AccountDAO().checkLogin(user, pass);
        Role role = new dao.RoleDao().getRole(id);

        if (role != null) {
            if (id == null || role.isIsLock() || role.getRoleID().equalsIgnoreCase("DELETED")) {
                request.setAttribute("pass", "");
                if (role.isIsLock()) {
                    request.setAttribute("status", "This account is locked");
                } else {
                    if (role.getRoleID().equalsIgnoreCase("DELETED")) {
                        request.setAttribute("status", "This account is DELETED");
                    } else {
                        request.setAttribute("status", "Login fail");
                    }
                }
                request.setAttribute("pass", "");
                request.getRequestDispatcher("Authen/login.jsp").forward(request, response);
                return;
            }
        } else {
            if (id == null) {
                request.setAttribute("pass", "");
                request.setAttribute("status", "Login fail");
                request.getRequestDispatcher("Authen/login.jsp").forward(request, response);
                return;
            }
        }
        HttpSession session = request.getSession();
        session.setAttribute("id", id);
        session.setAttribute("userRole", role.getRoleName());
//        session.setAttribute("userRole", "Master Admin");
        if (request.getParameter("check") != null) {
            Cookie cookie = new Cookie("id", id);
            cookie.setMaxAge(60 * 60 * 24);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }
        response.sendRedirect("HomePage/HomePage.jsp");
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
        HttpSession session = request.getSession();
        session.invalidate();
        Cookie cookie = new Cookie("id", null);
        cookie.setMaxAge(60 * 60 * 24);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
        response.sendRedirect("Authen/login.jsp");
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
