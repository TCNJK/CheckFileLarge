<%@page import="dao.BusinessDAO"%>
<%@page import="model.Business"%>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Datatable - View ADS</title>
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
    <style>
        ol, ul{
            padding: 0;
        }
        .profile-container{
            padding: 20px 17%;
            background-color: #cdf1ff;
        }
        body{
            background-color: #cdf1ff;
        }
        .cover-img{
            width:100%;
            border-radius:3px;
            margin-bottom:14px;
            object-fit: cover;
            height:200px;

        }
        .profile-details{
            background: white;
            padding: 20px;
            border-radius: 10px;
            display:flex;
            align-items: flex-start;
            justify-content: space-between;
        }
        .pd-row{
            display: flex;
            align-items:flex-start;

        }
        .pd-image{
            width:130px;
            height:130px;
            margin-right:30px;
            border-radius: 3px;
            object-fit: cover;
        }
        .pd-row div h3{
            font-size: 25px;
            font-weight:600;

        }
        .pd-row div p{
            font-size:13px;

        }
        .pd-row div img{
            width: 25px;
            height:25px;
            border-radius: 50%;

        }
        .pd-row .profile-name{
            margin-top:17px;
        }
        .pd-right button{
            background: #1876f2;
            border: 3px;
            outline : 0;
            padding: 6px 10px;
            display: inline-flex;
            align-items: center;
            color:#fff;
            border-radius:4px;
            margin-left:10px;
            cursor:pointer;
            margin-top:20px;
        }
        .pd-right button .icon{
            margin-right:5px;
        }
        .pd-right button:first-child{
            background:#e4e6eb;
            color:#000;
        }
        .pd-right{
            text-align: right;
        }
        .pd-right .more{
            background: #e4e6eb;
            border-radius:4px;
            padding:6px 12px;
            display: inline-flex;
            margin-top: 30px;

        }
        .write-post-container{
            background: white;
            border-radius:10px;
            padding: 20px;
            color:#626262;
        }
        .user-profile{
            display:flex;
            align-items: center;
        }
        .user-profile img{
            width:45px;
            height:45px;
            border-radius:50%;
            margin-right: 10px;
            object-fit: cover;
        }
        .user-profile p{
            margin-bottom: -5px;
            font-weight: 500;
            color:#626262;
            margin-top:4px;
            margin-bottom:1px;
        }
        .user-profile option{
            font-size: 12px;
        }
        .post-input-container{
        }
        .post-input-container textarea{
            width:100%;
            border:0;
            outline:0;
            border-bottom: 1px solid #ccc;
            background:transparent;
            resize: none;
        }
        .add-post-links{
            display: flex;
            margin-top: 10px;
        }
        .add-post-links a{
            text-decoration: none;
            display: flex;
            align-items: center;
            color: #626262;
            margin-right:30px;
            font-size:13px;
        }
        .add-post-links a .icon{
            margin-right: 10px;
        }
        .add-post-links .send-post{
            background: #1876f2;
            border: 3px;
            outline : 0;
            padding: 6px 13px;
            display: inline-flex;
            align-items: center;
            color:#fff;
            border-radius:4px;
            cursor:pointer;
            font-size:15px;
        }
        .profile-info{
            display: flex;
            align-self: flex-start;
            justify-content: space-between;
            margin-top: 20px;
        }
        .info-col{
            /*            flex-basis:36%;*/
            padding-left: 0;
        }
        .post-col{
            /*            flex-basis: 63%;*/
            padding-right: 0;
        }
        .profile-intro{
            background: white;
            padding:20px;
            margin-bottom: 20px;
            border-radius: 10px;

        }
        .profile-intro h3{
            font-weight: 600;
            margin-top:-1px;
        }

        .intro-text{
            text-align: center;
            margin: 10px 0;
            font-size: 15px;
        }
        .profile-intro hr{
            border:0;
            height:1px;
            background: #ccc;
            margin:24px 0;
        }
        .profile-intro ul li{
            list-style: none;
            font-size:15px;

            display: flex;
            align-items: center;
        }
        .profile-intro ul li .intro{
            margin-right: 10px;
        }
        .title-box{
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .title-box a{
            text-decoration: none;
            color: #1876f2;
            font-size:14px;
        }
        .friend-box{
            display: grid;
            grid-template-columns: repeat(3,auto);

        }
        .friend-box div img{
            width:80px;
            height:110px;
            object-fit: cover;
            cursor:pointer;
            padding-bottom:30px;
            border-radius:10px;
        }
        .friend-box div{
            position: relative;
        }
        .friend-box p{
            position: absolute;
            bottom:0;
            left:0;
        }
        .post-container{
            border-radius:10px;
            color:#626262;
            margin:20px 0;
        }
        .user-profile span{
            font-size:13px;
            color: #9a9a9a;
        }
        .post-text{
            color:#9a9a9a;
            margin:15px 0;
            font-size:15px;
        }
        .post-text span{
            color:#626262;
            font-weight: 500;
        }
        .post-img{
            width:100%;

            border-radius:4px;
            margin-bottom:5px;
        }
        .post-row{
            display:flex;
            align-items:center;
            justify-content: space-between;

        }
        .activity-icons div .icon{
            width:18px;
            margin-right: 10px;
            border-bottom: 2px;
        }
        .activity-icons div{
            display:inline-flex;
            align-items: center;
            margin-right: 30px;
        }
        @media(max-width:900px){
            .profile-container{
                padding:20px 5%;
            }
            .profile-details{
                flex-wrap:wrap;
            }
            .pd-right{
                text-align: left;
                margin-top:15px;

            }
            .pd-right button{
                margin-left: 0;
                margin-right: 10px;
            }
            .pd-row div h3{
                font-size:16px;
            }
            #previewImage{
                margin:5px 0px;
                max-height: 530px;
            }
        }
    </style>
    <body>
        <%
            BusinessDAO apiBusniess = new BusinessDAO();
            String BID = request.getParameter("BID");
            String id = (String) session.getAttribute("id");
            System.out.println(BID + " " + id);
            if (!apiBusniess.checkPermission(BID, id)) {
                throw new Exception("not permission");
            }
            Business business = apiBusniess.getBusinessByBusinessID(BID);
        %>
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
                        <a href="/SocialNetworkIRCNV/Business/BusinessIndex.jsp?BID=<%=BID%>"><img src="<%=business.getImageAvatar()%>" alt="logo"></a>
                    </div>
                </div>
                <div class="main-menu">
                    <div class="menu-inner">
                        <nav>
                            <ul class="metismenu" id="menu">
                                <li class="active">
                                    <a href="javascript:void(0)" aria-expanded="true"><i class="ti-dashboard"></i><span>Add Advertise</span></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0)" aria-expanded="true"><i class="ti-flag-alt"></i><span>Content
                                        </span></a>
                                    <ul class="collapse">
                                        <li><a href="ViewAds.jsp?BID=<%=BID%>">View advertise</a></li>
                                        <li><a href="AddAds.jsp?BID=<%=BID%>">Add advertise</a></li>
                                        <li><a href="CommentsReports.jsp?BID=<%=BID%>">Post advertise</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- sidebar menu area end -->
            <!-- main content area start -->
            <div class="main-content">
                <!-- header area start -->
                <div class="header-area">
                    <div class="row align-items-center">
                        <!-- nav and search button -->
                        <div class="col-md-6 col-sm-8 clearfix">
                            <div class="nav-btn pull-left">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="search-box pull-left">

                            </div>
                        </div>
                        <!-- profile info & task notification -->

                    </div>
                </div>
                <!-- header area end -->
                <!-- page title area start -->
                <div class="page-title-area">
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <div class="breadcrumbs-area clearfix">
                                <h4 class="page-title pull-left">Add Advertise</h4>
                                <ul class="breadcrumbs pull-left">
                                    <li><a href="/SocialNetworkIRCNV/Business/BusinessIndex.jsp?BID=<%=BID%>">Home</a></li>
                                    <li><span>Add Advertise</span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6 clearfix">
                            <div class="user-profile pull-right">
                                <img class="avatar user-thumb" src="<%=business.getImageAvatar()%>" alt="avatar">
                                <h4 class="user-name dropdown-toggle" data-toggle="dropdown"><%=business.getBrandName()%><i class="fa fa-angle-down"></i></h4>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="#">Update</a>
                                    <a class="dropdown-item" href="/SocialNetworkIRCNV/HomePage/HomePage.jsp">Back to home</a>
                                    <a class="dropdown-item" href="#">Delete</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- page title area end -->
                <div class="main-content-inner">
                    <!-- sales report area start -->
                    <!-- sales report area end -->
                    <!-- overview area start -->
                    <div class="row">
                        <div class="col-11 mt-5">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="header-title">Add Advertise</h4>
                                    <div class="data-tables datatable-primary">
                                        <table id="dataTable2" class="text-center">
                                            <div class ="write-post-container">
                                                <div class ="user-profile">
                                                    <img src="<%=business.getImageAvatar()%>" >
                                                    <div>
                                                        <p><a href="" style="text-decoration: none; color:#626262;"><%=business.getBrandName()%></a> </p>
                                                    </div>
                                                </div>
                                                <div>
                                                    <div class ="post-input-container" id="post-input-container">
                                                        <textarea id="NewPostTextarea" rows ="3" placeholder="Your content...."></textarea>    
                                                        <img id="previewImage" src="#" alt="Preview Image" style="display: none; max-height: 300px">
                                                        <input type="file" accept="image,gif/*,capture=camera" name="photo" id="fileInput"> 
                                                    </div> 
                                                    <button onclick="askForAddAds('<%=BID%>')">add new ads</button>
                                                </div>
                                            </div>
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- overview area end -->
                    <!-- market value area start -->
                    <!-- market value area end -->
                    <!-- row area start -->
                    <!-- row area end -->
                    <!-- row area start-->
                </div>
            </div>
            <!-- main content area end -->
            <!-- footer area start-->
            <footer>
                <div class="footer-area">
                    <p>© Copyright 2023. All right reserved. Template by <a href="https://colorlib.com/wp/">Colorlib</a>.</p>
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
        <script src="js/addads.js"></script>
    </body>

</html>
