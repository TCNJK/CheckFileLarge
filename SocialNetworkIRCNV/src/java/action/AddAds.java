/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import controller.Text;
import dao.BusinessDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Advertisement;
import model.Business;

/**
 *
 * @author van12
 */
@MultipartConfig
@WebServlet(name = "AddAds", urlPatterns = {"/AddAds"})
public class AddAds extends HttpServlet {

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
        
        try {
            Text text = new Text();
            //lay session
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("id");
            // lay param
            String BID = request.getParameter("BID");
            String content = text.changeUTF8(request.getParameter("content"));
            Part part = request.getPart("photo");
            //khởi tạo api
            BusinessDAO businessDAO = new BusinessDAO();
            Advertisement advertisement = new Advertisement("", BID, content, "", "", 0, 0, 0, 0, "", 0);
            if (part != null && part.getSubmittedFileName() != null) {
                //khởi tạo controldata
                ControlData data = new ControlData(part, getServletContext());
                // save to db
                advertisement.setImagePost(data.getFilename());
                String AdvertiserID = businessDAO.insertAdvertisement(advertisement);
                advertisement.setAdvertiserID(AdvertiserID);
                //khowri tao cho viec bai post
                data.createInitForBusinessPost(BID, AdvertiserID);
                //create folder
                data.creatFolder();
                // save image
                data.SaveImage();
                System.out.println("path: " + data.getRealPath());
            } else {
                String AdvertiserID = businessDAO.insertAdvertisement(advertisement);
                advertisement.setAdvertiserID(AdvertiserID);
            }
            
        } catch (Exception e) {
            System.out.println("action.AddAds.processRequest()");
            e.printStackTrace();
        }
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            out.print("<textarea id=\"NewPostTextarea\" rows =\"3\" placeholder=\"Your content....\"></textarea>    \n"
                    + "<img id=\"previewImage\" src=\"#\" alt=\"Preview Image\" style=\"display: none; max-height: 300px\">\n"
                    + "<input type=\"file\" accept=\"image/*,capture=camera\" name=\"photo\" id=\"fileInput\"> ");
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
