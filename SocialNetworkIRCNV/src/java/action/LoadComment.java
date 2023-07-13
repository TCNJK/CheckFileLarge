/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Comment;
import model.CommentChild;

/**
 *
 * @author van12
 */
@WebServlet(name = "LoadComment", urlPatterns = {"/LoadComment"})
public class LoadComment extends HttpServlet {

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
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String object = request.getParameter("id");
        int offset = Integer.parseInt(request.getParameter("offset"));

        //get path image
        if (object.substring(0, 3).equalsIgnoreCase("CID")) {
            loadCommentChild(request, response, id, object, offset);
        } else if (object.substring(0, 3).equalsIgnoreCase("PID")) {
            loadComment(request, response, id, object, offset);
        }
    }

    public void loadComment(HttpServletRequest request, HttpServletResponse response, String id, String object, int offset) {
        Connection cnn = new connection.connection().getConnection();
        ArrayList<Comment> commentList = new dao.CommentDAO().getCommentByPostID(object, offset);

        String str = "";
        for (int i = 0; i < commentList.size(); i++) {
            str += "<ul>"
                    + "<li id='comment-" + commentList.get(i).getCmtID() + "'>"
                    + "<div class=\"comment\" id=\"" + commentList.get(i).getCmtID() + "\">\n"
                    + commentList.get(i).getUpdateDiv(id)
                    + "        </div>\n";
            ArrayList<CommentChild> commentChildList = commentList.get(i).getCommentChild();
            for (int j = 0; j < commentChildList.size(); j++) {
                str += "<ul>"
                        + "<li id='comment-" + commentChildList.get(j).getChilID() + "'>"
                        + "<div class=\"comment\" id=\"" + commentChildList.get(j).getChilID() + "\">\n"
                        + commentChildList.get(j).getUpdateDiv(id)
                        + "    </div>\n"
                        + "</li>"
                        + "</ul>";

            }
            str += "</li></ul>";
            if (commentChildList.size() >= 5) {
                str += "<div id=\"btn-" + commentList.get(i).getCmtID() + "\" onclick=\"loadmorecomment('" + commentList.get(i).getCmtID() + "', '2')\" style=\"text-align: center\">\n"
                        + "    <a>Load more</a>\n"
                        + "</div>";
            }

        }
        try {
            try ( PrintWriter out = response.getWriter()) {
                if (commentList.isEmpty()) {
                    out.print("null");
                } else {
                    out.print(str);
                }
            }
        } catch (Exception e) {
            System.out.println("action.LoadComment.loadComment()");
            e.printStackTrace();
        }

    }

    public void loadCommentChild(HttpServletRequest request, HttpServletResponse response, String id, String object, int offset) {
        String str = "";
        Connection cnn = new connection.connection().getConnection();
        ArrayList<CommentChild> commentChildList = new dao.CommentDAO().getCommentChildByCmtID(object, offset);
        for (int j = 0; j < commentChildList.size(); j++) {
            str += "<ul>"
                    + "<li id='comment-" + commentChildList.get(j).getChilID() + "'>"
                    + "<div class=\"comment\" id=\"" + commentChildList.get(j).getChilID() + "\">\n"
                    + commentChildList.get(j).getUpdateDiv(id)
                    + "    </div>\n"
                    + "</li>"
                    + "</ul>";

        }
         try {
            try ( PrintWriter out = response.getWriter()) {
                if (commentChildList.isEmpty()) {
                    out.print("null");
                } else {
                    out.print(str);
                }
            }
        } catch (Exception e) {
             System.out.println("action.LoadComment.loadCommentChild()");
            e.printStackTrace();
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
