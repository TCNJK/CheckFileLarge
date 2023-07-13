<%@page import="model.User"%>
<%@ page errorPage="../error/errorPage.jsp" %>  
<%@page import="model.PostShare"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.PostUser"%>
<%@page import="model.Business"%>
<%@page import="dao.BusinessDAO"%>
<%@page import="model.Post"%>
<%@page import="model.PostShare"%>
<%@page import="model.PostUser"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.Privacy"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <link rel="icon" href="/SocialNetworkIRCNV/data/img/logo.jpg" type="image/i-con">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
              integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/post.css">
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/postshare.css">
        <title class="title-page" id="title-page">Home Page</title>
        <style>
            *{
                margin:0;
                padding:0;
                box-sizing: border-box;
                font-family: sans-serif;
            }

            nav{
                height:70px;
                width:100%;
                padding: 0 2rem;
                position: sticky;
                display:flex;
                justify-content: space-between;
                background-color: #fff;
                box-shadow: 0px 1px 3px #ccc;
                top:0;
                z-index:99;
            }

            nav .nav-left, nav .nav-right{
                display:flex;
                align-items: center;
            }

            nav .nav-left > img{
                width:40px;
                height: 40px;
                border-radius: 50%;
            }

            nav .nav-left > input{
                height:40px;
                padding:5px 10px;
                border:none;
                border-radius: 25px;
                outline:none;
                background-color: #eee;
                margin-left: 10px;
            }

            nav .nav-middle{
                display:flex;
                align-items:flex-end;
                padding-bottom: 5px;
            }

            nav .nav-middle a{
                text-decoration: none;
                color:#333;
                padding:10px;
                margin:0px 10px;
            }

            nav .nav-middle a.active{
                color:royalblue;
                position:relative;
            }

            nav .nav-middle a.active::after{
                content:'';
                width:100%;
                height:3px;
                position:absolute;
                bottom:0;
                left:0;
                background:royalblue;
            }

            nav .nav-middle a > i{
                font-size: 25px;
            }

            nav .nav-right .profile img, .container .left-panel .profile img{
                height:40px;
                width:40px;
                background-size: cover;
                border-radius: 50%;
                cursor: pointer;
            }

            nav .nav-right a{
                text-decoration: none;
                color:#333;
                height:40px;
                width:40px;
                border-radius: 50%;
                background:#eee;
                display:grid;
                place-items: center;
                margin-left:1rem;
            }

            nav .nav-right a > i{
                font-size:18px;
            }


            .container{

                background:#cdf1ff;
                display:flex;
                left: 0;
                right: 0;
            }

            .container .left-panel, .container .right-panel{
                position: sticky;
                top:70px;

                width:250px;
                height:calc(100vh - 70px);
            }

            .container .left-panel ul{
                padding:10px 0px;
                margin-left: 10px
            }

            .container .left-panel ul li{
                list-style: none;
                display: flex;
                padding:.7rem 1rem;
                align-items: center;
                transition: .3s;
                border-radius: 5px;
                cursor: pointer;
            }

            .container .left-panel ul li:hover{
                background:#ddd;
            }

            .container .left-panel ul li > p{
                margin-left: 10px;
            }

            .container .left-panel ul li > i{
                font-size:20px;
                color:#00587c;
            }

            .container .left-panel ul li > i.fa-calendar-week{
                color:tomato;
            }

            .container .left-panel ul li i.fa-briefcase{
                color:green;
            }

            .container .left-panel ul li i.fa-star{
                color:yellowgreen;
            }

            .container .left-panel ul li i.fa-hands-helping{
                color:indianred;
            }

            .container .left-panel .footer-links{
                padding:5px 1rem;
            }

            .container .left-panel .footer-links a{
                text-decoration: none;
                color:#333;
                font-size:12px;
            }

            .middle-panel{
                flex:1;
                display:flex;
                flex-direction: column;
                align-items:center;
            }
            .share{
                max-width:750px;
                background:#fff;
                border-radius:10px;
                margin: 10px;
            }

            .post{
                max-width:750px;
                background:#fff;
                border-radius:10px;
                margin: 10px 0;
            }

            .post .post-top{
                display:flex;
                align-items: center;
                padding:10px;
            }

            .post .post-top .dp{
                width:40px;
                height:40px;
                border-radius: 50%;
                overflow:hidden;
            }

            .post .post-top .dp > img{
                width:100%;
                cursor:pointer;
            }

            .post .post-top .post-info{
                margin-left:10px;
                font-weight: bold;
            }

            .post .post-top .post-info .name{
                cursor:pointer;
                font-size:13px;
            }

            .post .post-top .post-info .time{
                font-size:12px;
                cursor:pointer;
            }

            .post .post-top i{
                margin-left:auto;
                cursor: pointer;
            }

            .post .post-top > input{
                height:40px;
                padding:5px 10px;
                border-radius:25px;
                outline:none;
                border:none;
                flex:1;
                background:#eee;
                margin-left:10px;
            }

            .post .post-content{
                font-size:16px;
                font-weight:normal;
                padding:10px;
                max-height: 1000px;
            }

            .post .post-content > img{
                height: 95%;
                margin:5px 0px;
            }

            .post .post-bottom{
                box-shadow: 1px solid #ddd;
                display:flex;
                justify-content: space-between;
                padding:5px 5px 0px 5px;

            }

            .post .post-bottom .action{
                padding:10px;
                border-radius:10px;
                transition: .3s ease-in;
                cursor: pointer;

            }

            .post-bottom .action{
                color:  #00abfd;
            }

            .post .post-bottom .action:hover{
                background:#eee;
            }

            .post.create .post-bottom > .action{
                color:#d74;
            }

            .container .right-panel{
                padding:1rem;
            }

            .right-panel .pages-section,
            .right-panel .friends-section{
                margin:1rem 0px;
            }

            .right-panel .pages-section h4,
            .right-panel .friends-section h4{
                margin-bottom:10px;
            }

            .right-panel .pages-section .page,
            .right-panel .friends-section .friend{
                display: flex;
                align-items:center;
                text-decoration: none;
                transition: .3s ease-in-out;
                border-radius: 5px;
                padding:7px 10px;
                color:#333;
            }

            .right-panel .pages-section .page:hover,
            .right-panel .friends-section .friend:hover{
                background:#ddd;
            }

            .right-panel .pages-section .page > .dp,
            .right-panel .friends-section .friend > .dp{
                height:40px;
                width:40px;
                border-radius: 50%;
                overflow:hidden;
                cursor: pointer;
            }

            .right-panel .pages-section .page > .dp > img,
            .right-panel .friends-section .friend > .dp > img{
                width:100%;
            }

            .right-panel .pages-section .name, .right-panel .friends-section .name{
                font-size:16px;
                cursor:pointer;
                margin-left:8px;
            }
            .left-panel .pages-section,
            .right-panel .friends-section{
                margin:1rem 0px;
                margin-left: 20px;
            }

            .left-panel .pages-section h4
            {
                margin-bottom:10px;
            }

            .left-panel .pages-section .page{
                display: flex;
                align-items:center;
                text-decoration: none;
                transition: .3s ease-in-out;
                border-radius: 5px;
                padding:7px 10px;
                color:#333;
            }

            .left-panel .pages-section .page:hover{
                background:#ddd;
            }

            .left-panel .pages-section .page > .dp{
                height:40px;
                width:40px;
                overflow:hidden;
                cursor: pointer;
            }

            .left-panel .pages-section .page > .dp > img{
                width:100%;
            }

            .left-panel .pages-section .name{
                font-size:18px;
                cursor:pointer;
                margin-left:8px;
            }
        </style>

    </head>

    <body>
        <div id="offset" style="display: none"  >1</div>
        <jsp:useBean id="apiPrivacy" class="dao.PrivacyDao"/>
        <header>
            <%@include file="../block/header.jsp" %>
        </header>
        <%            //String id = (String) session.getAttribute("id");
            if (id != null) {
            ArrayList<Business> businessList= new BusinessDAO().getBusinessByUserID(id);
        %>
        <div class="container" style="max-width: 1850px; width: 100%; min-width: 1045px; padding: 0;">
            <div class="left-panel">
                <ul>
                    <a href="${pageContext.request.contextPath}/PersonalPage/ProfileInfo.jsp">
                        <li>
                            <p class="profile" >

                                <img src="<%=user.getImgUser()%>" alt="alt"/>


                            </p>
                            <p style="text-decoration: none; color: black"><%=user.getFullName()%></p>

                        </li>
                    </a>
                    <li>
                        <i class="fa fa-home"></i>
                        <p> Home</p>
                    </li>
                    <a href="${pageContext.request.contextPath}/PersonalPage/FriendList.jsp" style="text-decoration: none">
                    <li>
                        <i class="fa fa-user-friends"></i>
                        <p>Friends</p>
                    </li>
                    </a>
                    <a href="../BoxChat/GetFriendAndBoxChat" style="text-decoration: none; color: black">
                        <li>
                            <i class="fas fa-comments"></i>
                            <p>Inbox</p>
                        </li>
                    </a>
                </ul>
                    <div class="pages-section">
                    <% if(businessList!= null || businessList.size()!=0){%>
                      
                        <h4>Advertisements</h4>
                        <%for(int i=0 ; i < businessList.size(); i++){%>
                            <a class='page' href="/SocialNetworkIRCNV/Business/BusinessIndex.jsp?BID=<%=businessList.get(i).getBusinessID()%>">
                                <div class="dp">
                                    <img src="<%= businessList.get(i).getImageAvatar() %>" alt="">
                                </div>
                                <p class="name"><%= businessList.get(i).getBrandName()%></p>
                            </a>
                        <%}; %>
                    <% } %>
                    <div class="action" onclick="addBusiness()">
                        <a>
                            <i class="fa-brands fa-adversal fa-2x"></i>
                            <span>Advertisement</span>
                        </a>
                    </div>
                    </div>
                    
                    
                <div class="footer-links">
                    <a href="#">Privacy</a>
                    <a href="#">Terms</a>
                    <a href="#">Advance</a>
                    <a href="#">More</a>
                </div>
            </div>
            <div class="middle-panel" style="   ">
                
                <div>
                    <div class ="post-container"  id="post" style="margin: 0; padding: 0">

                    </div>
                    <div id="btnloadmore">
                        <button onclick="loadMorePost('homepage', '<%=id%>', document.getElementById('offset').innerHTML)">load more </button>
                    </div>
                </div>
                        
                </div>
            <% ArrayList<User> friendList= new dao.UserDAO().getUserFriend(id, 1, 9);
                int size= (9>friendList.size())?friendList.size(): 9;
            %>
            <div class="right-panel">

                    <div class="friends-section">
                        <h4>Friends</h4>
                        <%for(int i=0; i< size; i++){%>
                        <a class='friend' href="/SocialNetworkIRCNV/PersonalPage/ProfileUser.jsp?UID=<%=friendList.get(i).getUserID()%>">
                            <div class="dp">
                                <img src="<%=friendList.get(i).getImgUser()%>" alt="">
                            </div>
                            <p class="name"><%=friendList.get(i).getFullName()%></p>
                        </a>
                        <%}%> 
                    </div>
                </div>
        </div>
        <%} else {%>
        <img src="https://cdn-icons-png.flaticon.com/512/202/202770.png" alt="welcome"/>
        <%}%>
                <div>
                    <div class="modal" id = "changeinfo" tabindex="-1" role="dialog">

                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Change Information</h5>

                                </div>
                                <div class="modal-body">
                                    <form action="/SocialNetworkIRCNV/UpdateInfo" method = "post" enctype="multipart/form-data">
                                        <div class="form-group">
                                            <label for="cover-image" class="col-form-label">Cover Image:</label>
                                            <img id="previewImage3" src="<%=user.getCoverImg()%>" alt="Preview Image" style="width: 100%;
                                                                                                                                                border-radius: 3px;
                                                                                                                                                margin-bottom: 14px;
                                                                                                                                                object-fit: cover;
                                                                                                                                                height: 200px;
                                                                                                                                            }">
                                            <input  type="file" accept="image,gif/*,capture=camera" name="coverimage" id="fileInput3">
                                        </div>

                                        <div class="form-group">
                                            <label for="avatar" class="col-form-label">Avatar:</label>
                                            <img id="previewImage4" src="<%=user.getImgUser()%>" alt="Preview Image" style="width: 130px;
                                                                                                                            height: 130px;
                                                                                                                            margin-right: 30px;
                                                                                                                            border-radius: 3px;
                                                                                                                            object-fit: cover;">
                                            <input  type="file" accept="image/*,capture=camera" name="avatar" id="fileInput4">
                                        </div>

                                        <div class="form-group">
                                            <label for="full-name" class="col-form-label">Full Name:</label>
                                            <input value = "<%=user.getFullName()%>"type="text" id="fullname" name="fullname" class="form-control border-primary">
                                        </div>

                                        <div class="form-group">
                                            <label for="date-of-birth" class="col-form-label">Date of Birth:</label>
                                            <input value = "<%=user.getDOB()%>"type="date" id="dateofbirth" name="dateofbirth" class="form-control border-primary">
                                        </div>

                                        <div class="form-group">
                                            <label for="gender" class="col-form-label">Gender:</label>
                                            <select id="gender" name="gender" class="form-control border-primary">
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>

                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="current-city" class="col-form-label">Address:</label>
                                            <input value = "<%=user.getAddress()%>"type="text" id="address" name="address" class="form-control border-primary">
                                        </div>

                                        <div class="form-group">
                                            <label for="nationality" class="col-form-label">Nationality:</label>
                                            <input value = "<%=user.getNation()%> "type="text" id="nation" name="nation" class="form-control border-primary">
                                        </div>

                                        <div class="form-group">
                                            <label for="phone-number" class="col-form-label">Phone Number:</label>
                                            <input value = "<%=user.getPhoneNumber()%> " type="tel" id="phone-number" name="phonenumber" class="form-control border-primary">
                                        </div>

                                        <div class="form-group">
                                            <label for="email-address" class="col-form-label">Email Address:</label>
                                            <input value = "<%=user.getMail()%> " type="email" id="email-address" name="emailaddress" class="form-control border-primary">
                                        </div>
                                        <input type="submit" class="btn btn-primary" value="Save changes">
                                        <!--<button type="submit" class="btn btn-primary">Save  changes</button>-->
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </form>
                                </div>

                                <div class="modal-footer">

                                </div>

                            </div>
                        </div>             


                    </div>
                </div>
                <div class="modal" id = "modalShare" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Modal title</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div id="PostIDPostShareModel"></div>
                                <div class="share-head">
                                    <div style="display: flex">
                                        <div class="dp" >
                                            <img src="<%=user.getImgUser()%>" alt="" style="width: 45px;
                                                 height: 45px;
                                                 border-radius: 50%;
                                                 margin-right: 10px;
                                                 object-fit: cover;" >
                                        </div>
                                        <div class="share-info">
                                            <p class="name" style="color: #003140;"><%=user.getFullName()%></p>
                                        </div>
                                    </div>

                                    <p>What's you think?</p>
                                    <div class="share-content" style="margin-bottom: 20px">
                                        <input id="contentPostShareModel" type="text" name="contentPostShareModel" style="width: 100%">
                                    </div>
                                    
                                    <select id="privacyPostShareModel" name = "privacyPostShareModel" style="color:#626262;">
                                    <c:forEach items="${apiPrivacy.allPrivacy}" var="ele">
                                        <option style="color:#626262; background-color:#cdf1ff;  ">${ele.getPrivacyName()}</option>
                                    </c:forEach>
                                </select>
                                    <div class="share-body" style="border: 1px solid black">
                                        <div class="share-top"  style="margin-left: 10px">
                                            <div class="dp">
                                                <img id="imgUserDown" src="" alt="" style="width: 45px;
                                                     height: 45px;
                                                     border-radius: 50%;
                                                     margin-right: 10px;
                                                     object-fit: cover;" >
                                            </div>
                                            <div class="share-info">
                                                <p id="name_userDown" class="name" style="color: #003140"></p>
                                            </div>
                                        </div>
                                        <div class="share-content" style="text-align: center;" >
                                            <p id='contentDown' style="text-align: left;"></p>
                                            <img id='img_postDown' src="" style="width: 100%"/>
                                        </div>

                                    </div> 
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" onclick="load('Share')">Save changes</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="myProfile">
                    <div class="modal" id = "modifyModal" tabindex="-1" role="dialog" style="font-size: 15px;">
                        <style>
                            .post-top{
                                display:flex;
                                align-items: center;
                                padding:10px;
                                padding-bottom: 0;
                            }

                            .post-top .dp{
                                width:60px;
                                height:60px;
                                border-radius: 50%;
                                overflow:hidden;
                            }

                            .post-top .dp > img{

                                cursor:pointer;
                            }

                            .post-top .post-info{
                                margin-left:10px;
                                font-weight: bold;
                            }

                            .post-top .post-info .name{
                                cursor:pointer;
                                font-size:23px;
                                margin-bottom: 0;
                            }

                            .post-top .post-info .time{
                                font-size:14px;
                                cursor:pointer;
                            }
                        </style>
                        <div class="modal-dialog" role="document">
                            <div class="modal-content" style="width: 700px;">
                                <div class="modal-header" style="font-size: 15px;">
                                    <h5 class="modal-title">Edit Post</h5>                      
                                </div>
                                <div class="modal-body">
                                    <div class="post-top">
                                        <p style="display: none" id="IDpost"></p>
                                        <div class="dp" >
                                            <img id="imgUser" src="" alt="" style="width: 100%;" >
                                        </div>
                                        <div class="post-info">
                                            <p class="name" style="color: #003140" id="FullNameU"></p>
                                            <span class="time" style="color: #70d8ff" id="timePost"></span>

                                            <select id="isPublic" name = "privacy" style="color:#626262;">
                                                <option style="color:#626262; background-color:#cdf1ff;" value="Public">Public</option>
                                                <option style="color:#626262;background-color:#cdf1ff;" value="Private">Private</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="post-content" style="text-align: center;">
                                        <textarea rows ="2" style="width: 100%; border: none;" id="contentPost"></textarea>
                                        <img id="imgPost" src="" style=" max-width: 660px; max-height: 660px;"/>
                                        <br>
                                        <input type="file" accept="image/*,capture=camera" name="photoPost" id="fileInput2" />
                                        <button class="btn btn-primary" style="font-size: 15px;" type="button" onclick="clearFileInput()">Clear File Input</button>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary" style="font-size: 15px;" onclick="loadUpdate()">Save changes</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal" style="font-size: 15px;">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        <div class="modal" id = "createBusiness" tabindex="-1" role="dialog">

                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Change Information</h5>

                            </div>
                            <div class="modal-body">
                                <div>

                                    <div class="form-group">
                                        <label for="full-name" class="col-form-label">Brand Name:</label>
                                        <input type="text" id="name"  required name="name" class="form-control border-primary">
                                    </div>

                                    <div class="form-group">
                                        <label for="current-city" class="col-form-label">Address:</label>
                                        <input type="text" id="address" name="address" class="form-control border-primary" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="current-city" class="col-form-label">Mail: </label>
                                        <input type="text" id="mail" name="mail" class="form-control border-primary" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="current-city" class="col-form-label">Phone: </label>
                                        <input type="text" id="phone" name="phone" class="form-control border-primary" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="current-city" class="col-form-label">Intro: </label> <br>
                                        <textarea id="intro" name="intro" rows="5" cols="60"></textarea>
                                    </div>
                                     <div class="form-group">
                                        <label for="avatar" class="col-form-label">Avatar:</label>
                                        <img id="previewImage" alt="Preview Image" style="width: 130px;
                                             height: 130px;
                                             margin-right: 30px;
                                             border-radius: 3px;
                                             object-fit: cover;">
                                        <input  type="file" accept="image/*,capture=camera" name="photo" id="fileInput">
                                    </div>   
                                    <input type="submit" class="btn btn-primary" value="Save changes" onclick="insertBusiness()">
                                    <!--<button type="submit" class="btn btn-primary">Save  changes</button>-->
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>

                            <div class="modal-footer">

                            </div>

                        </div>
                    </div>             

                    <script>
                        document.getElementById('fileInput').addEventListener('change', function (event) {
                            var file = event.target.files[0];
                            // T?o ??i t??ng FileReader ?? ??c t?p tin
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var previewImage = document.getElementById('previewImage');
                                previewImage.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        });

                    </script>
                </div>
        <script src="/SocialNetworkIRCNV/js/load.js" ></script>
        <script src="/SocialNetworkIRCNV/js/controlPost.js"></script>
        <script src="/SocialNetworkIRCNV/HomePage/homepage.js" ></script>
        <script src="/SocialNetworkIRCNV/js/like.js" ></script>
        
    </body>

</html>