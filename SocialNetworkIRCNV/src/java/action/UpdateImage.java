/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author van12
 */
@MultipartConfig
@WebServlet(name = "UpdateImage", urlPatterns = {"/UpdateImage"})
public class UpdateImage extends HttpServlet {

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
         String type= request.getParameter("type");
        if(type.equalsIgnoreCase("cover"))
            updateImageCover(request, response);
        else if(type.equalsIgnoreCase("avatar"))
            updateImageAvatar(request, response);
        response.sendRedirect("PersonalPage/ProfileInfo.jsp");
        
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
    public void updateImageAvatar(HttpServletRequest request, HttpServletResponse response){
        try {
            String id= (String) request.getSession().getAttribute("id");
                Part part = request.getPart("image");
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                new dao.UserDAO().updateAvatar(data.getFilename(), id);
                //khowri tao cho viec bai post
                data.createInitForAvatar(id);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
            }
            
        } catch (Exception e) {
            System.out.println("action.UpdateImage.updateImageAvatar()");
            e.printStackTrace();
        }
    }
    public void updateImageCover(HttpServletRequest request, HttpServletResponse response){
        try {
            String id= (String) request.getSession().getAttribute("id");
                Part part = request.getPart("image");
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                new dao.UserDAO().updateBackground(data.getFilename(), id);
                //khowri tao cho viec bai post
                data.createInitForBackGround(id);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
            }
        } catch (Exception e) {
            System.out.println("action.UpdateImage.updateImageCover()");
            e.printStackTrace();
        }
        
        
    }
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
