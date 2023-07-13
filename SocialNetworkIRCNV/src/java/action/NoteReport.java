/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author van12
 */
@WebServlet(name = "NoteReport", urlPatterns = {"/NoteReport"})
public class NoteReport extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public void load(HttpServletRequest request, HttpServletResponse response, String id, int offset) throws Exception {
        ArrayList<NOTE> note = new dao.NoteDao(id).getNote(id, offset);
        if (note.size() == 0) {
            try ( PrintWriter out = response.getWriter()) {
                out.print("null");
            }
            return;
        }
        try ( PrintWriter out = response.getWriter()) {
            note.forEach((t) -> {
                if (t instanceof NOTE_FRIEND) {
                    out.println(((NOTE_FRIEND) t).getDiv());
                } else if (t instanceof NOTE_LIKE) {
                    out.println(((NOTE_LIKE) t).getDiv());
                }
            });
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = (String) request.getSession().getAttribute("id");
        String type = request.getParameter("Type");
        new dao.NoteDao(id).setNOTE_ZERO(id);
        int offset= Integer.parseInt(request.getParameter("offset"));
        if (type.equalsIgnoreCase("load"))
            try {
            load(request, response, id, offset);
        } catch (Exception e) {
                System.out.println("action.NoteReport.processRequest()");
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
