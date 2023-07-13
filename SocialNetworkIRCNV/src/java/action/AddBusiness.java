/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import dao.BusinessDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Business;

/**
 *
 * @author van12
 */
@MultipartConfig
@WebServlet(name = "AddBusiness", urlPatterns = {"/AddBusiness"})
public class AddBusiness extends HttpServlet {

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
        String id = (String) request.getSession().getAttribute("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String mail = request.getParameter("mail");
        String phone = request.getParameter("phone");
        String intro = request.getParameter("intro");
        BusinessDAO businessDAO = new BusinessDAO();
        Business business = new Business("", id, name, address, mail, phone, "", intro, 0, "", 0, "");
        business.setImageAvatar("");
        Part part = request.getPart("photo");
        String BID = "";
        try {
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                business.setImageAvatar(data.getFilename());
                BID = businessDAO.insert(business);
                //khowri tao cho viec bai post
                data.createInitForBusinessAvatar(BID);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
            } else {
                BID = businessDAO.insert(business);
            }
        } catch (Exception e) {
            try ( PrintWriter out = response.getWriter()) {
                out.print("null");
                return;
            }
        }
        try ( PrintWriter out = response.getWriter()) {
            out.print("ok");
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
