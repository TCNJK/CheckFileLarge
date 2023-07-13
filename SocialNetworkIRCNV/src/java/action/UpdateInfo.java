/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import controller.Text;
import dao.UserDAO;
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
import model.User;

/**
 *
 * @author LENOVO
 */
//@MultipartConfig
@WebServlet(name = "UpdateInfo", urlPatterns = {"/UpdateInfo"})
public class UpdateInfo extends HttpServlet {

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
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        dao.UserDAO api = new dao.UserDAO();
        User a = api.getUserByID(id);

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
        String id = (String) session.getAttribute("id");
        try {

            Text text = new Text();
            User user = new dao.UserDAO().getUserByID(id);

            String fullname = text.changeUTF8(request.getParameter("fullname"));
            System.out.println("fullname: " + fullname);
            if (fullname == null || fullname.trim().isEmpty()) {
                fullname = user.getFullName();
            } else {
                user.setFullName(fullname);
            }
            String address = text.changeUTF8(request.getParameter("address"));
            System.out.println("address: " + address);
            if (address == null || address.trim().isEmpty()) {
                address = user.getAddress();
            } else {
                user.setAddress(address);
            }
            System.out.println(fullname + address);
            String mail = request.getParameter("mail");
            if (mail == null || mail.trim().isEmpty()) {
                mail = user.getMail();
            } else {
                user.setMail(mail);
            }
            String phonenumber = request.getParameter("phonenumber");
            if (phonenumber == null || phonenumber.trim().isEmpty()) {
                phonenumber = user.getPhoneNumber();
            } else {
                user.setPhoneNumber(phonenumber);
            }
            String dob = request.getParameter("dob");
            if (dob == null || dob.trim().isEmpty()) {
                dob = user.getDOB();
            } else {
                user.setDOB(dob);
            }
            String gender = request.getParameter("gender");

            String nation = text.changeUTF8(request.getParameter("nation"));
            if (nation == null || nation.trim().isEmpty()) {
                nation = user.getNation();
            } else {
                user.setNation(nation);
            }
            String intro = text.changeUTF8(request.getParameter("intro"));
            if (intro == null || intro.trim().isEmpty()) {
                intro = user.getIntro();
            } else {
                user.setIntro(intro);
            }
            
//            Part part = request.getPart("avatar");
//            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
//                //khởi tạo controldata
//                ControlData data = new ControlData(part, getServletContext());
//                // save to db
//                new dao.UserDAO().updateAvatar(data.getFilename(), id);
//                //khowri tao cho viec bai post
//                data.createInitForAvatar(id);
//                //create folder
//                data.creatFolder();
//                // save image
//                data.SaveImage();
//                System.out.println("path: " + data.getRealPath());
//            }
//
//            
//            Part part2 = request.getPart("coverimage");
//            if (part2 != null && part2.getSubmittedFileName() != null && !part2.getSubmittedFileName().trim().isEmpty()) {
//                //khởi tạo controldata
//                ControlData data = new ControlData(part2, getServletContext());
//                // save to db
//                new dao.UserDAO().updateBackground(data.getFilename(), id);
//                //khowri tao cho viec bai post
//                data.createInitForBackGround(id);
//                //create folder
//                data.creatFolder();
//                // save image
//                data.SaveImage();
//                System.out.println("path: " + data.getRealPath());
//            }
            new dao.UserDAO().updateInfo(user);
            response.sendRedirect("PersonalPage/ProfileInfo.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }

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
