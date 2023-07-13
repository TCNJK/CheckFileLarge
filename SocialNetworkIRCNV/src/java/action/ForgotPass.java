/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;


import controller.Send;
import dao.AccountDAO;
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
@WebServlet(name = "ForgotPass", urlPatterns = {"/ForgotPass"})
public class ForgotPass extends HttpServlet {

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
            out.println("<title>Servlet ForgotPass</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPass at " + request.getContextPath() + "</h1>");
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
        String mail = request.getParameter("mail");
        String user = request.getParameter("user");
        AccountDAO api = new AccountDAO();
        String name = api.checkExistMail(user, mail);
        
        if (name == null) {
            request.setAttribute("mail", mail);
            request.setAttribute("user", user);
            request.setAttribute("status", "Mail or your account is wrong");
            request.getRequestDispatcher("Authen/forgotpass.jsp").forward(request, response);
            return;
        }
        String code = api.createNewMail(mail);
        try {
            new Send().sendEmail("vietnade160170@fpt.edu.vn", "hehe", "hello");
            new Send().sendMailForgotPass(mail, name, code);
        } catch (Exception e) {
        }
        
        request.setAttribute("name", name);
        request.setAttribute("mail", mail);
        request.setAttribute("user", user);
        request.getRequestDispatcher("Authen/forgotverify.jsp").forward(request, response);
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
        String mail = request.getParameter("mail");
        String user = request.getParameter("user");
        String code = request.getParameter("code");
        AccountDAO api = new AccountDAO();
        if (!api.checkMailCode(mail, code)) {
            request.setAttribute("status", "Your code wrong");
            request.setAttribute("mail", mail);
            request.setAttribute("user", user);
            request.setAttribute("code", code);
            request.getRequestDispatcher("Authen/forgotverify.jsp").forward(request, response);
            return;
        }
        request.setAttribute("mail", mail);
        request.setAttribute("user", user);
        request.setAttribute("code", code);
        request.getRequestDispatcher("Authen/NewPass.jsp").forward(request, response);
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
