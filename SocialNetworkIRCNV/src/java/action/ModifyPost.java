/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package action;

import controller.ControlData;
import controller.Text;
import dao.PostDAO;
import dao.PostUserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.PostUser;
import model.User;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author ADMIN
 */
@MultipartConfig
@WebServlet(name = "ModifyPost", urlPatterns = {"/ModifyPost"})
public class ModifyPost extends HttpServlet {

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
    public void updatePost(String PostID, String UserID, String Content, String ImagePost, String PublicPost) {
        if (PublicPost == null) {
            PublicPost = "1";
        } else if (PublicPost.equalsIgnoreCase("Public")) {
            PublicPost = "1";
        } else {
            PublicPost = "0";
        }
        new dao.PostUserDAO(UserID).updatePost(PostID, UserID, Content, ImagePost);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        Text text = new Text();
        try {
            //
            HttpSession session = request.getSession();
            String id = (String) session.getAttribute("id");
            String isPublic = request.getParameter("isPublic");
            Part part = request.getPart("photoPost");
            String PostID = request.getParameter("IDpost");
            System.out.println(PostID + " ISPOST ");
            String CONTENT = request.getParameter("contentPost");
            System.out.println(CONTENT + "    hoahsohdaosahkshdk");
            String content = text.changeUTF8((String) request.getParameter("contentPost"));
            dao.PostUserDAO api = new dao.PostUserDAO(id);
            //get path image
            boolean checkExist = api.checkExistPostUser(PostID, id);
            if (checkExist) {
                if (part != null && part.getSubmittedFileName() != null) {
                    //khởi tạo controldata
                    ControlData data = new ControlData(part, getServletContext());
                    // save to db

                    new dao.PostUserDAO(id).updatePost(PostID, id, content, data.getFilename());
                    //khowri tao cho viec bai post
                    data.createInitForPost(PostID);
                    //create folder
                    data.creatFolder();
                    // save image
                    data.SaveImage();
                    System.out.println("path: " + data.getRealPath());
                } else {
                    new dao.PostUserDAO(id).updatePost(PostID, id, content);
                }
                request.getRequestDispatcher("ProfileInfo.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("");
            e.printStackTrace();
            request.getRequestDispatcher("").forward(request, response);
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
