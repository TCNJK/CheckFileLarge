/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import model.Post;
import model.PostUser;
import model.PostShare;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Advertisement;
import model.User;

/**
 *
 * @author van12
 */
@WebServlet(name = "GetLoadPost", urlPatterns = {"/GetLoadPost"})
public class GetLoadPost extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void loadProfileUser(String id, String uid, HttpServletResponse response, HttpServletRequest request, int offset) throws Exception {
        dao.PostDAO api = new dao.PostDAO(id);
        ArrayList<Post> post = api.getPostForProfileUser(id, uid, offset);
        if (post.isEmpty()) {
            User user = new dao.UserDAO().getUserByID(uid);
            try ( PrintWriter out = response.getWriter()) {
                out.print("usernull");
            }
        } else
        try ( PrintWriter out = response.getWriter()) {
            for (int i = 0; i < post.size(); i++) {
                if (post.get(i) instanceof PostUser) {
                    out.append(((PostUser) post.get(i)).getDiv());
                } else {
                    out.append(((PostShare) post.get(i)).getDiv());
                }
            }
        }
    }

    public void loadProfileinfo(String id, HttpServletResponse response, HttpServletRequest request, int offset) throws Exception {
        dao.PostDAO api = new dao.PostDAO(id);
        ArrayList<Post> post = api.getPostForProfileInfo(id, offset);
        if (post.isEmpty()) {
            try ( PrintWriter out = response.getWriter()) {
                out.print("infonull");
            }
        } else
        try ( PrintWriter out = response.getWriter()) {
            for (int i = 0; i < post.size(); i++) {
                if (post.get(i) instanceof PostUser) {
                    out.append(((PostUser) post.get(i)).getDiv());
                } else {
                    out.append(((PostShare) post.get(i)).getDiv());
                }
            }
        }
    }

    public void loadHomePage(String id, HttpServletResponse response, HttpServletRequest request, int offset) throws Exception {
        dao.PostDAO api = new dao.PostDAO(id);
        ArrayList<Post> post = api.getPostForHomePage(id, offset);
        if (post.isEmpty()) {
            try ( PrintWriter out = response.getWriter()) {
                out.print("homenull");
            }
        } else
        try ( PrintWriter out = response.getWriter()) {
            for (int i = 0; i < post.size(); i++) {
                if (post.get(i) instanceof PostUser) {
                    out.append(((PostUser) post.get(i)).getDiv());
                }else  if (post.get(i) instanceof PostShare) {
                    out.append(((PostShare) post.get(i)).getDiv());
                }else{
                    out.append(((Advertisement) post.get(i)).getDiv());
                }
            }
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String type = request.getParameter("type");
        String id = (String) session.getAttribute("id");
        String uid = request.getParameter("UID");
        int offset = Integer.parseInt(request.getParameter("offset"));
        switch (type) {
            case "profileuser":
                try {
                    loadProfileUser(id, uid, response, request, offset);
                } catch (Exception e) {
                }
            break;
            case "profileinfo":
                try {
                    loadProfileinfo(id, response, request, offset);
                } catch (Exception e) {
                }
            break;
            case "homepage":
                try {
                    loadHomePage(id, response, request, offset);
                } catch (Exception e) {
                }
            break;
            default:
                throw new AssertionError();
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
