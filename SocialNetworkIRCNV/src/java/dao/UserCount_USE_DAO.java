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
import java.util.Calendar;
import java.util.List;
import model.NewUserInMonth;
import model.User_Activity_Time;

/**
 *
 * @author TCNJK
 */
public class UserCount_USE_DAO {

    Connection cnn;

    public UserCount_USE_DAO() {
        cnn = new connection().getConnection();
    }

    public void AddToMonthlyUsage(long time) {
        try {
            PreparedStatement ps = cnn.prepareStatement("INSERT INTO dbo.MonthlyUsage\n"
                    + "(\n"
                    + "    MonthDate,\n"
                    + "    UsageTime\n"
                    + ")\n"
                    + "VALUES\n"
                    + "(\n"
                    + "    DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1), -- Lấy tháng và năm từ ngày hiện tại\n"
                    + "    ? --Thời gian sử dụng\n"
                    + ")");
            ps.setLong(1, time);
            ps.executeUpdate();
            return;
        } catch (Exception e) {
            System.err.println("AddToMonthlyUsage");
            e.printStackTrace();
        }
        try {
            PreparedStatement ps = cnn.prepareStatement("UPDATE MonthlyUsage\n"
                    + "SET UsageTime = MonthlyUsage.UsageTime+?\n"
                    + "WHERE MonthDate = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)");
            ps.setLong(1, time);
            ps.executeUpdate();
            return;
        } catch (Exception e) {
            System.err.println("AddToMonthlyUsage");
            e.printStackTrace();
        }
    }

    public List<User_Activity_Time> getUser_Activity_Time() {
        List<User_Activity_Time> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT\n"
                    + "    DATEFROMPARTS(M.CreatedYear, M.CreatedMonth, 1) AS MonthDate,\n"
                    + "    ISNULL(T.UsageTime, '') AS UsageTime\n"
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
                    + "        MonthDate,\n"
                    + "        UsageTime\n"
                    + "    FROM\n"
                    + "        MonthlyUsage\n"
                    + "    ORDER BY\n"
                    + "        MonthDate DESC) AS T\n"
                    + "ON\n"
                    + "    M.CreatedMonth = MONTH(T.MonthDate)\n"
                    + "    AND M.CreatedYear = YEAR(T.MonthDate)\n"
                    + "ORDER BY\n"
                    + "    M.CreatedYear ASC,\n"
                    + "    M.CreatedMonth ASC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Date monthDate = rs.getDate("MonthDate");
                long usageTime = rs.getLong("UsageTime");

                Calendar calendar = Calendar.getInstance();
                calendar.setTime(monthDate);
                int year = calendar.get(Calendar.YEAR);
                int month = calendar.get(Calendar.MONTH) + 1;

                list.add(new User_Activity_Time(usageTime, month + "/" + year % 100));
            }
            return list;

        } catch (Exception e) {
            System.err.println("getUser_Activity_Time");
            e.printStackTrace();
        }
        return null;
    }

    public List<NewUserInMonth> getNewUserInMonth() {
        List<NewUserInMonth> list = new ArrayList<>();
        try {
            PreparedStatement ps = cnn.prepareStatement("SELECT \n"
                    + "    ISNULL(T.NumUsers, 0) AS NumUsers,\n"
                    + "    M.CreatedMonth,\n"
                    + "    M.CreatedYear\n"
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
                    + "            DATEADD(MONTH, 0, GETDATE()) AS MonthDate) AS Subquery\n"
                    + "		) AS M\n"
                    + "LEFT JOIN\n"
                    + "    (SELECT \n"
                    + "        COUNT(*) AS NumUsers,\n"
                    + "        MONTH(TimeCreate) AS CreatedMonth,\n"
                    + "        YEAR(TimeCreate) AS CreatedYear\n"
                    + "    FROM \n"
                    + "        UserInfor\n"
                    + "    GROUP BY \n"
                    + "        MONTH(TimeCreate),\n"
                    + "        YEAR(TimeCreate)) AS T\n"
                    + "ON\n"
                    + "    M.CreatedMonth = T.CreatedMonth\n"
                    + "    AND M.CreatedYear = T.CreatedYear\n"
                    + "ORDER BY\n"
                    + "    M.CreatedYear ASC,\n"
                    + "    M.CreatedMonth ASC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int numUsers = rs.getInt("NumUsers");
                int createdMonth = rs.getInt("CreatedMonth");
                int createdYear = rs.getInt("CreatedYear");

                list.add(new NewUserInMonth(createdMonth + "/" + createdYear % 100, numUsers));
            }
            return list;

        } catch (Exception e) {
            System.err.println("getNewUserInMonth");
            e.printStackTrace();
        }
        return null;
    }
}
