/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package listener;

import Count.UserCount;
import dao.UserCount_USE_DAO;
import java.time.Duration;
import java.time.LocalDateTime;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author TCNJK
 */
public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        LocalDateTime loginTime = (LocalDateTime) se.getSession().getAttribute("loginTime");
        String id = (String) se.getSession().getAttribute("id");
        if (id != null && !id.isBlank()) {
            LocalDateTime logoutTime = LocalDateTime.now();
            UserCount.time = Duration.between(loginTime, logoutTime).toMillis();
            UserCount_USE_DAO e = new UserCount_USE_DAO();
            e.AddToMonthlyUsage(UserCount.time);
            UserCount.count -= 1;
        }
        // Tính toán thời gian sử dụng
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent se) {
        getTime(se);
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent se) {
        getTime(se);
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent se) {
        String attributeName = se.getName();
        if (!"loginTime".equals(attributeName)) {
            getTime(se);
        }
    }

    public void getTime(HttpSessionBindingEvent se) {
        if (se.getSession().getAttribute("loginTime") == null) {
            se.getSession().setAttribute("loginTime", LocalDateTime.now());
            UserCount.count += 1;
        } else {
            LocalDateTime loginTime = (LocalDateTime) se.getSession().getAttribute("loginTime");
            String id = (String) se.getSession().getAttribute("id");
            if (id != null && !id.isBlank()) {
                LocalDateTime logoutTime = LocalDateTime.now();
                UserCount.time = Duration.between(loginTime, logoutTime).toMillis();
                UserCount_USE_DAO e = new UserCount_USE_DAO();
                e.AddToMonthlyUsage(UserCount.time);
                se.getSession().setAttribute("loginTime", LocalDateTime.now());
            }
        }
    }
}
