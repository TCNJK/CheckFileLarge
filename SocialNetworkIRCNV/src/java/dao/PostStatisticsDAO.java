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
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.PostStatistics;

/**
 *
 * @author TCNJK
 */
public class PostStatisticsDAO {

    Connection cnn;

    public PostStatisticsDAO() {
        cnn = new connection().getConnection();
    }

    public List<PostStatistics> getData() {
        List<PostStatistics> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT\n"
                    + "    M.CreatedMonth AS Month,\n"
                    + "    M.CreatedYear AS Year,\n"
                    + "    COALESCE(P.TotalPosts, 0) AS TotalPosts\n"
                    + "FROM\n"
                    + "    (SELECT\n"
                    + "        MONTH(MonthDate) AS CreatedMonth,\n"
                    + "        YEAR(MonthDate) AS CreatedYear\n"
                    + "    FROM\n"
                    + "        (SELECT TOP 11\n"
                    + "            DATEADD(MONTH, -ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), GETDATE()) AS MonthDate\n"
                    + "        FROM\n"
                    + "            sys.objects\n"
                    + "        UNION ALL\n"
                    + "        SELECT\n"
                    + "            DATEADD(MONTH, 0, GETDATE()) AS MonthDate) AS Subquery) AS M\n"
                    + "LEFT JOIN\n"
                    + "    (SELECT TOP 12\n"
                    + "        Month,\n"
                    + "        Year,\n"
                    + "		TotalPosts\n"
                    + "    FROM\n"
                    + "        PostSummaryByMonth\n"
                    + "    ORDER BY\n"
                    + "        Year DESC,\n"
                    + "        Month DESC) AS P\n"
                    + "ON\n"
                    + "    M.CreatedMonth = P.Month\n"
                    + "    AND M.CreatedYear = P.Year\n"
                    + "ORDER BY\n"
                    + "    M.CreatedYear ASC,\n"
                    + "    M.CreatedMonth ASC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int month = rs.getInt(1);
                int year = rs.getInt(2);
                int number = rs.getInt(3);
                list.add(new PostStatistics(month + "/" + year % 100, number));
            }
            return list;

        } catch (Exception e) {
            System.err.println("model.API.CheckLogin");
            e.printStackTrace();
        }
        return null;
    }
}
