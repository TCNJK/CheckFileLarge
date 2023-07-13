<%-- 
    Document   : sidebarMenu
    Created on : Jun 13, 2023, 1:03:59 PM
    Author     : TCNJK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div id="preloader">
            <div class="loader"></div>
        </div>
        <!-- preloader area end -->
        <!-- page container area start -->
        <div class="page-container">
            <!-- sidebar menu area start -->
            <div class="sidebar-menu">
                <div class="sidebar-header">
                    <div class="logo">
                        <a href="index.html"><img src="assets/images/icon/logo.png" alt="logo"></a>
                    </div>
                </div>
                <div class="main-menu">
                    <div class="menu-inner">
                        <nav>
                            <ul class="metismenu" id="menu">
                                <li >
                                    <a href="AdminPageIndex.jsp" aria-expanded="true"><i class="ti-dashboard"></i><span>Dashboard</span></a>
                                </li>
                                <li >
                                    <a href="javascript:void(0)" aria-expanded="true"><i class="ti-flag-alt"></i><span>Reported Content
                                        </span></a>
                                    <ul class="collapse">
                                        <li ><a href="UserReports.jsp">User Reports</a></li>
                                        <li><a href="PostsReports.jsp">Posts Reports</a></li>
                                        <li><a href="CommentsReports.jsp">Comments Reports</a></li>
                                    </ul>
                                </li>
                                <% if ("Master Admin".equals(session.getAttribute("userRole"))) { %>
                                <li class="active">
                                    <a href="AdminManage.jsp" aria-expanded="true"><i class="ti-slice"></i><span>AdminManage</span></a>
                                </li>
                                <% }%>
                                <li><a href="invoice.html"><i class="ti-receipt"></i> <span>Invoice Summary</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- sidebar menu area end -->
    </body>
</html>
