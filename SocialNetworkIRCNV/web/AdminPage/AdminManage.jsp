<%-- 
    Document   : AdminManage
    Created on : Jun 18, 2023, 10:54:16 PM
    Author     : TCNJK
--%>

<%@page import="java.util.List"%>
<%@page import="dao.Admin_UserManageDAO"%>
<%@page import="model.Admin_UserManage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Datatable - Admin Manage</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/png" href="assets/images/icon/favicon.ico">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/themify-icons.css">
        <link rel="stylesheet" href="assets/css/metisMenu.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/slicknav.min.css">
        <!-- amcharts css -->
        <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
        <!-- Start datatable css -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.18/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.jqueryui.min.css">
        <!-- style css -->
        <link rel="stylesheet" href="assets/css/typography.css">
        <link rel="stylesheet" href="assets/css/default-css.css">
        <link rel="stylesheet" href="assets/css/styles.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <!-- modernizr css -->
        <script src="assets/js/vendor/modernizr-2.8.3.min.js"></script>
    </head>

    <body>
        <jsp:include page="sidebarMenu.jsp"></jsp:include>
            <!-- main content area start -->
        <jsp:include page="header.jsp"></jsp:include>
            <!-- page title area start -->
            <div class="page-title-area">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="breadcrumbs-area clearfix">
                            <h4 class="page-title pull-left">Admin Manage</h4>
                            <ul class="breadcrumbs pull-left">
                                <li><a href="index.html">Home</a></li>
                                <li><span>Admin Manage</span></li>
                            </ul>
                        </div>
                    </div>
                <jsp:include page="adminInfoInAnyPage.jsp"></jsp:include>
                </div>
            </div>
            <!-- page title area end -->
            <div class="main-content-inner">
                <div class="row">
                    <!-- Primary table start -->
                    <div class="col-11 mt-5">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">Data Table Primary</h4>
                                <div class="data-tables datatable-primary">
                                    <table id="dataTable2" class="text-center">
                                        <thead class="text-capitalize">
                                            <tr>
                                                <th>Image</th>
                                                <th>FullName</th>
                                                <th>Address</th>
                                                <th>Mail</th>
                                                <th>Account</th>
                                                <th>PhoneNumber</th>
                                                <th>DOB</th>
                                                <th>Nation</th>
                                                <th>Role</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%! Admin_UserManage elem;%>
                                        <% Admin_UserManageDAO e = new Admin_UserManageDAO();
                                            List<Admin_UserManage> list = e.getData();
                                            for (Admin_UserManage elem : list) {
                                        %>
                                        <tr class="<%= elem.getUserID()%>">
                                            <td class="user-image"><img style="width: 50px;" src="<%= elem.getImageUser()%>" alt="Không Có Ảnh"></td>
                                            <td><%= elem.getFullName()%></td>
                                            <td><%= elem.getAddress()%></td>
                                            <td><%= elem.getMail()%></td>
                                            <td><%= elem.getAccount()%></td>
                                            <td><%= elem.getPhoneNumber()%></td>
                                            <td><%= elem.getDob()%></td>
                                            <td><%= elem.getNation()%></td>
                                            <td>
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-light roleButton_<%=elem.getUserID()%>"><%= elem.getRoleID()%></button>
                                                    <button type="button" class="btn btn-light dropdown-toggle dropdown-toggle-split" data-toggle="dropdown">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item" href="#" onclick="changeRole('<%= elem.getUserID()%>', 'USER')">USER</a>
                                                        <a class="dropdown-item" href="#" onclick="changeRole('<%= elem.getUserID()%>', 'ADMIN')">ADMIN</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    <script>

                                        function skipRow(link, id) {
                                            var row = link.parentNode.parentNode; // Lấy thẻ <tr> chứa liên kết được nhấn
                                            row = row.parentNode;
                                            if (row !== null) {
                                                row = row.parentNode;
                                                if (row !== null) {
                                                    row = row.parentNode;
                                                    if (row !== null) {
                                                        var oldRow = row;
                                                        row = row.previousElementSibling;
                                                        if (row !== null) {
                                                            if (row.nodeName === 'TR') {
                                                                oldRow.remove();
                                                                row.remove();
                                                                alert('Thành công');
                                                                return;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            row = link.parentNode.parentNode; // Lấy thẻ <tr> chứa liên kết được nhấn
                                            row.remove();
                                            alert('Thành công');
                                        }
                                        function changeRole(userID, newRole) {
                                            var data = {
                                                userID: userID,
                                                newRole: newRole
                                            };
                                            $.ajax({
                                                url: '../changeRole', // Đường dẫn đến trang xử lý cập nhật vai trò
                                                method: 'POST',
                                                data: data,
                                                success: function (response) {
                                                    // Cập nhật lại giá trị vai trò trên giao diện
                                                    var elements = document.getElementsByClassName('roleButton_' + userID);
                                                    for (var i = 0; i < elements.length; i++) {
                                                        var element = elements[i];
                                                        element.innerHTML = newRole;
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    // Hiển thị thông báo lỗi
                                                    alert("Error: " + error);
                                                }
                                            });

                                        }
                                    </script>
                                    <!-- Add more rows as needed -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Primary table end -->
            </div>
        </div>
    </div>
    <!-- main content area end -->
    <!-- footer area start-->
    <footer>
        <div class="footer-area">
            <p>© Copyright 2023.</p>
        </div>
    </footer>
    <!-- footer area end-->
</div>
<!-- page container area end -->
<!-- offset area start -->
<!-- offset area end -->
<!-- jquery latest version -->
<script src="assets/js/vendor/jquery-2.2.4.min.js"></script>
<!-- bootstrap 4 js -->
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/metisMenu.min.js"></script>
<script src="assets/js/jquery.slimscroll.min.js"></script>
<script src="assets/js/jquery.slicknav.min.js"></script>

<!-- Start datatable js -->
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<script src="https://cdn.datatables.net/1.10.18/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.18/js/dataTables.bootstrap4.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.3/js/responsive.bootstrap.min.js"></script>
<!-- others plugins -->
<script src="assets/js/plugins.js"></script>
<script src="assets/js/scripts.js"></script>
</body>

</html>


