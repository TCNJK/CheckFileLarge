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
@WebServlet(name = "UpdateAds", urlPatterns = {"/UpdateAds"})
public class UpdateAds extends HttpServlet {

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

        String type = request.getParameter("type");
        try {
            if (type==null || type.equalsIgnoreCase("none")){
                updateAdvertisement(request, response);
                return;
            }
            else if (type.equalsIgnoreCase("quantity")) {
                addMoreQuantity(request, response);
                return;
            }
            else if (type.equalsIgnoreCase("status")) {
                updateStatus(request, response);
                return;
            } 
        } catch (Exception e) {
            System.out.println("action.UpdateAds.processRequest()");
            e.printStackTrace();
        }

    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) {
        BusinessDAO businessDAO = new BusinessDAO();
        String AID = request.getParameter("AID");
        String status = request.getParameter("status");
        try {
            Advertisement advertisement = businessDAO.getAdvertisementByAdvertiserID(AID);
            advertisement.setStatus(status);
            //businessDAO.updateAdvertisementContent(advertisement);
            if(status.equalsIgnoreCase("ongoing")){
                 businessDAO.AddActive(AID);
            }
            else if(status.equalsIgnoreCase("inactive")){
                    businessDAO.DeleteActive(AID);
                    }
           
        } catch (Exception e) {
        }

    }

    private void addMoreQuantity(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String AID = request.getParameter("AID");
        String BID = request.getParameter("BID");

        BusinessDAO businessDAO = new BusinessDAO();
        try {
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            float cast = (float) Math.round(Float.parseFloat(request.getParameter("cast")) * 100) / 100;
            Advertisement advertisement = businessDAO.getAdvertisementByAdvertiserID(AID);
            Business business = businessDAO.getBusinessByBusinessID(BID);
            if (cast <= business.getBudget()) {
                business.setBudget(business.getBudget() - cast);
                businessDAO.update(business);
                advertisement.setQuantity(quantity + advertisement.getQuantity());
                businessDAO.updateAdvertisementContent(advertisement);
            } else {
                throw new Exception("not enough");
            }
        } catch (Exception e) {

            try ( PrintWriter out = response.getWriter()) {
                out.println("null");
            }
        }
    }

    private void updateAdvertisement(HttpServletRequest request, HttpServletResponse response) throws Exception {
        BusinessDAO businessDAO = new BusinessDAO();
        String AID = request.getParameter("AID");
        try {
            Text text = new Text();
            //lay session
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("id");
            // lay param
            Part part = request.getPart("photo");
            String content = text.changeUTF8(request.getParameter("content"));

            String BID = request.getParameter("BID");
            String type = request.getParameter("type");
            //khởi tạo api
            Advertisement advertisement = businessDAO.getAdvertisementByAdvertiserID(AID);
            //Advertisement advertisement = new Advertisement(AID, BID, content, "", "", 0, 0, 0, 0, "", quantity);
            advertisement.setContent(content);
           
            if (type.equalsIgnoreCase("clear")) {
                businessDAO.updateAdvertisementContent(advertisement);
                businessDAO.updateAdvertisementImagePost(advertisement);
            } else {
                if (part != null && part.getSubmittedFileName() != null) {
                    //khởi tạo controldata
                    ControlData data = new ControlData(part, getServletContext());
                    // save to db
                    advertisement.setImagePost(data.getFilename());
                    businessDAO.updateAdvertisementContent(advertisement);
                    businessDAO.updateAdvertisementImagePost(advertisement);
                    //khowri tao cho viec bai post
                    data.createInitForBusinessPost(BID, AID);
                    //create folder
                    data.creatFolder();
                    // save image
                    data.SaveImage();
                    System.out.println("path: " + data.getRealPath());
                } else {
                    businessDAO.updateAdvertisementContent(advertisement);
                }
            }

        } catch (Exception e) {
            System.out.println("action.UpdateAds.processRequest()");
            e.printStackTrace();
        }
        try ( PrintWriter out = response.getWriter()) {
            Advertisement advertisement = businessDAO.getAdvertisementByAdvertiserID(AID);
            out.println(advertisement.getDivView());
//            out.println("<td class=\"post-image\">\n"
//                    + "    <img id=\"image-"+advertisement.getAdvertiserID()+"\"style=\"width: 50px;\" src=\""+advertisement.getImagePost()+"\" alt=\"Không Có ?nh\">\n"
//                    + "</td>\n"
//                    + "<td id=\"content-"+advertisement.getAdvertiserID()+"\">"+advertisement.getContent()+" </td>\n"
//                    + "<td>"+advertisement.getNumInterface()+"</td>\n"
//                    + "<td id=\"quantity-"+advertisement.getAdvertiserID()+"\">"+advertisement.getQuantity()+"</td>\n"
//                    + "<td id=\"status-"+advertisement.getAdvertiserID()+"\">"+advertisement.getStatus()+"</td>\n"
//                    + "<td><a href=\"#\" onclick=\"postAds('"+advertisement.getAdvertiserID()+"', '"+advertisement.getBusinessID()+"')\" >Post</a>\n"
//                    + "    /<a href=\"#\" onclick=\"viewAds('"+advertisement.getAdvertiserID()+"', '"+advertisement.getBusinessID()+"')\">View</a>\n"
//                    + "    /<a href=\"#\" onclick=\"DeleteAds('"+advertisement.getAdvertiserID()+"')\">Delete</a></td>");
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
