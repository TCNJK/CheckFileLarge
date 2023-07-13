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
import model.Account;
import model.User;

/**
 *
 * @author 84384
 */
@WebServlet(name = "Verify", urlPatterns = {"/Verify"})
public class Verify extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Verify</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Verify at " + request.getContextPath() + "</h1>");
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
        dao.AccountDAO api = new dao.AccountDAO();
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String name = request.getParameter("name");
        String mail = request.getParameter("mail");
        String dob = request.getParameter("dob");

        String gender = request.getParameter("gender");
        if (gender == null) {
            gender = "1";
        } else {
            gender = gender.equals("Male") ? "1" : "0";
        }
        Account newUser = new Account(user, pass, name, mail, dob, gender);
        HttpSession session = request.getSession();
        session.setAttribute("newUser", newUser);
        if (api.checkExistAccount(user)) {
            request.setAttribute("user", newUser.getUser());
            request.setAttribute("pass", newUser.getPass());
            request.setAttribute("name", newUser.getName());
            request.setAttribute("mail", newUser.getMail());
            request.setAttribute("dbo", newUser.getDob());
            request.setAttribute("gender", newUser.getGender());
            request.setAttribute("color", "Red");
            request.setAttribute("mess", " Account exist");
            session.setAttribute("newUser", null);
            request.getRequestDispatcher("Authen/signup.jsp").forward(request, response);
            return;
        }

        String code = api.createNewMail(mail);
        try {
            new controller.Send().sendMailCheckSignUp(mail, name, code);
        } catch (Exception e) {
        }
        

        request.getRequestDispatcher("Authen/verify.jsp").forward(request, response);
        return;
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
        dao.AccountDAO api = new dao.AccountDAO();
        String code = request.getParameter("code");
        HttpSession session = request.getSession();
        Account newUser = (Account) session.getAttribute("newUser");
        if (!api.checkMailCode(newUser.getMail(), code)) {
            request.setAttribute("user", newUser.getUser());
            request.setAttribute("pass", newUser.getPass());
            request.setAttribute("name", newUser.getName());
            request.setAttribute("mail", newUser.getMail());
            request.setAttribute("dbo", newUser.getDob());
            request.setAttribute("gender", newUser.getGender().equalsIgnoreCase("1") ? "Male" : "Female");
            request.setAttribute("color", "red");
            request.setAttribute("status", "code wrong");
            request.getRequestDispatcher("Authen/signup.jsp").forward(request, response);
            return;
        }
        api.createNewUser(newUser.getUser(), new controller.Argon().convertArgon2(newUser.getPass()), newUser.getName(), newUser.getMail(), newUser.getDob(), newUser.getGender());
        String id = api.getIdUser(newUser.getUser());
        session.setAttribute("id", id);
        if (request.getParameter("check") != null) {
            Cookie cookie = new Cookie("id", id);
            cookie.setMaxAge(60 * 60 * 24);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }
        response.sendRedirect("HomePage/HomePage.jsp");
       
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
