<%-- 
    Document   : AdminPageIndex
    Created on : Jun 13, 2023, 1:06:24 PM
    Author     : TCNJK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/png" href="assets/images/icon/favicon.ico">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/themify-icons.css">
        <link rel="stylesheet" href="assets/css/metisMenu.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
        <link rel="stylesheet" href="assets/css/slicknav.min.css">
        <!-- amchart css -->
        <link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
        <!-- others css -->
        <link rel="stylesheet" href="assets/css/typography.css">
        <link rel="stylesheet" href="assets/css/default-css.css">
        <link rel="stylesheet" href="assets/css/styles.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <!-- modernizr css -->
        <script src="assets/js/vendor/modernizr-2.8.3.min.js"></script>
    </head>
    <body onload="load()">
        <!--[if lt IE 8]>
                <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
            <![endif]-->
        <!-- preloader area start -->
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
                                <li class="active">
                                    <a href="javascript:void(0)" aria-expanded="true"><i class="ti-dashboard"></i><span>dashboard</span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)" aria-expanded="true"><i class="ti-flag-alt"></i><span>Reported Content
                                        </span></a>
                                    <ul class="collapse">
                                        <li><a href="UserReports.jsp">User Reports</a></li>
                                        <li><a href="PostsReports.jsp">Posts Reports</a></li>
                                        <li><a href="CommentsReports.jsp">Comments Reports</a></li>
                                    </ul>
                                </li>
                                <% if ("Master Admin".equals(session.getAttribute("userRole"))) { %>
                                <li>
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
            <!-- main content area start -->
            <div class="main-content">
                <!-- header area start -->
                <jsp:include page="header.jsp"></jsp:include>
                    <!-- page title area start -->
                    <div class="page-title-area">
                        <div class="row align-items-center">
                            <div class="col-sm-6">
                                <div class="breadcrumbs-area clearfix">
                                    <h4 class="page-title pull-left">Dashboard</h4>
                                    <ul class="breadcrumbs pull-left">
                                        <li><a href="index.html">Home</a></li>
                                        <li><span>Dashboard</span></li>
                                    </ul>
                                </div>
                            </div>
                        <jsp:include page="adminInfoInAnyPage.jsp"></jsp:include>

                    </div>
                </div>
                <!-- page title area end -->
                <div class="main-content-inner">
                    <div class="row">
                        <!-- seo fact area start -->
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-md-6 mt-5 mb-3">
                                    <div class="card">
                                        <div class="seo-fact sbg1">
                                            <div class="p-4 d-flex justify-content-between align-items-center">
                                                <div class="seofct-icon"><i class="ti-comment-alt"></i> Number of Post</div>
                                                <h2 id="TotalNumberofPost"></h2>
                                            </div>
                                            <canvas id="seolinechart1" height="50"></canvas>
                                            <!-- assets/js/line-chart.js -->
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mt-md-5 mb-3">
                                    <div class="card">
                                        <div class="seo-fact sbg2">
                                            <div class="p-4 d-flex justify-content-between align-items-center">
                                                <div class="seofct-icon"><i class="ti-timer"></i> User Activity Time(m)</div>
                                                <h2 id="TotalUserActTime"></h2>
                                            </div>
                                            <canvas id="seolinechart2" height="50"></canvas>
                                            <!-- assets/js/line-chart.js -->

                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3 mb-lg-0">
                                    <div class="card">
                                        <div class="seo-fact sbg3">
                                            <div class="p-4 d-flex justify-content-between align-items-center">
                                                <div class="seofct-icon"><i class="ti-user"></i>Current Users</div>
                                                <h2 id="UserCountINT"></h2>
                                                <!-- <canvas id="seolinechart3" height="60"></canvas> -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="seo-fact sbg4">
                                            <div class="p-4 d-flex justify-content-between align-items-center">
                                                <div class="seofct-icon"><i class="fa fa-user-plus"></i>New Users</div>
                                                <canvas id="seolinechart4" height="54"></canvas>
                                                <!-- assets/js/line-chart.js -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- seo fact area end -->
                        <!-- Statistics area start -->
                        <div class="col-lg-12 mt-5">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="header-title">New User</h4>
                                    <div id="user-statistics" ></div>
                                    <!-- assets/js/line-chart.js -->

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-5">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="header-title">User Activity Time(m)</h4>
                                    <div id="user-statistics2"></div>
                                    <!-- assets/js/line-chart.js -->

                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 mt-5">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="header-title">Number of Post</h4>
                                    <div id="user-statistics3"></div>
                                    <!-- assets/js/line-chart.js -->

                                </div>
                            </div>
                        </div>
                        <!-- Statistics area end -->
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
        <!-- jquery latest version -->
        <script src="assets/js/vendor/jquery-2.2.4.min.js"></script>
        <!-- bootstrap 4 js -->
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/owl.carousel.min.js"></script>
        <script src="assets/js/metisMenu.min.js"></script>
        <script src="assets/js/jquery.slimscroll.min.js"></script>
        <script src="assets/js/jquery.slicknav.min.js"></script>

        <!-- start chart js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
        <!-- start highcharts js -->
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <!-- start amcharts -->
        <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
        <script src="https://www.amcharts.com/lib/3/ammap.js"></script>
        <script src="https://www.amcharts.com/lib/3/maps/js/worldLow.js"></script>
        <script src="https://www.amcharts.com/lib/3/serial.js"></script>
        <script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
        <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
        <!-- all line chart activation -->
        <!--<script src="assets/js/line-chart.js"></script>-->
        <script src="scriptst.js"></script>
        <!-- all pie chart -->
        <script src="assets/js/pie-chart.js"></script>
        <!-- all bar chart -->
        <script src="assets/js/bar-chart.js"></script>
        <!-- all map chart -->
        <script src="assets/js/maps.js"></script>
        <!-- others plugins -->
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/scripts.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </body>

</html>

