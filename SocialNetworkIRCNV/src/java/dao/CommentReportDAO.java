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
import model.CommentReport;

/**
 *
 * @author TCNJK
 */
public class CommentReportDAO {

    Connection cnn;

    public CommentReportDAO() {
        cnn = new connection().getConnection();
    }

    public List<CommentReport> getData() {
        List<CommentReport> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT * FROM ReportCommentView");
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
                    list.add(new CommentReport(pid, ipost, img, content, num, time));
                }
            }
            return list;

        } catch (Exception e) {
            System.err.println("getData CommentReportDAO");
            e.printStackTrace();
        }
        return null;
    }

    public void UpdateSkip(String id, boolean isPost) {
        try {
            PreparedStatement ps = cnn.prepareStatement("UPDATE dbo.ReportComment1686\n"
                    + "SET ReportComment1686.Status = 0\n"
                    + "WHERE ReportComment1686.CommentID=? AND ReportComment1686.IsPost=?");
            ps.setString(1, id);
            ps.setBoolean(2, isPost);
            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("UpdateSkip CommentReportDAO");
            e.printStackTrace();
        }
    }

    public void AddReport(String pid, String uid, String isPost) {
        boolean isPostVerBool = false;
        if (isPost.equalsIgnoreCase("1")) {
            isPostVerBool = true;
        }
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.ReportComment1686\n"
                    + "(\n"
                    + "    CommentID,\n"
                    + "    UserID,\n"
                    + "    UserID2,\n"
                    + "    IsPost,\n"
                    + "    Status\n"
                    + ")\n"
                    + "VALUES\n"
                    + "(   ?,   -- CommentID - varchar(11)\n"
                    + "    ?,   -- UserID - varchar(11)\n"
                    + "    CASE WHEN ? = 1 \n"
                    + "THEN (SELECT UserID FROM dbo.COMMENT WHERE dbo.COMMENT.CmtID=?) \n"
                    + "ELSE (SELECT UserID FROM dbo.COMMENTSHARE WHERE dbo.COMMENTSHARE.CmtID=?) END,   -- UserID2 - varchar(11)\n"
                    + "    ?, -- IsPost - bit\n"
                    + "    1  -- Status - bit\n"
                    + "    )");
            ps.setString(1, pid);
            ps.setString(2, uid);
            ps.setBoolean(3, isPostVerBool);
            ps.setString(4, pid);
            ps.setString(5, pid);
            ps.setBoolean(6, isPostVerBool);

            ps.executeUpdate();
            return;

        } catch (Exception e) {
            System.err.println("AddReport CommentReportDAO");
            e.printStackTrace();
        }
    }
}
