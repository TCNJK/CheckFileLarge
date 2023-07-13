/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connection.connection;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.PostReport;

/**
 *
 * @author TCNJK
 */
public class PostReportDAO {

    Connection cnn;

    public PostReportDAO() {
        cnn = new connection().getConnection();
    }

    public List<PostReport> getData() {
        List<PostReport> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT * FROM ReportPostView");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String pid = rs.getString(1);
                boolean ipost = rs.getBoolean(2);
                String img = rs.getString(3);
                String content = rs.getString(4);
                int num = rs.getInt(5);
                Date time = rs.getDate(6);
                int status = rs.getInt(8);
                if (status == 1) {
                    list.add(new PostReport(pid, ipost, img, content, num, time));
                }
            }
            return list;

        } catch (Exception e) {
            System.err.println("getData PostReportDAO");
            e.printStackTrace();
        }
        return null;
    }

    public void UpdateSkip(String id) {
        try {
            PreparedStatement ps = cnn.prepareStatement("UPDATE ReportPost\n"
                    + "SET Status = 0\n"
                    + "WHERE PostID = ?;");
            ps.setString(1, id);
            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("UpdateSkip PostReportDAO");
            e.printStackTrace();
        }
    }

    public void AddReport(String pid, String uid) {
        boolean isPost = false;
        if (pid.contains("PID")) {
            isPost = true;
        }
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.ReportPost (IsPost, PostID, UserID, UserID2, Status)\n"
                    + "VALUES (?, ?, ?, \n"
                    + "        CASE WHEN ? = 1 THEN (SELECT UserID FROM Post WHERE POST.PostID=?) ELSE (SELECT UserID FROM PostShare WHERE dbo.POSTSHARE.ShareID=?) END, \n"
                    + "        1);");
            ps.setBoolean(1, isPost);
            ps.setString(2, pid);
            ps.setString(3, uid);
            ps.setBoolean(4, isPost);
            ps.setString(5, pid);
            ps.setString(6, pid);
            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("AddReport PostReportDAO");
            e.printStackTrace();
        }
    }
}
