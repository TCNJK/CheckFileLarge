<%@page import="model.PostShare"%>
<%@page import="model.Privacy"%>
<%@page import="controller.Text"%>
<%@page import="model.PostUser"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Post"%>
<%@page import="model.PostShare"%>
<%@page import="model.PostUser"%>
<%@ page errorPage="../error/errorPage.jsp" %>  
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Your Profile</title>
        <meta charset="UTF-8">
        <link rel="icon" href="/SocialNetworkIRCNV/data/img/logo.jpg" type="image/i-con">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
              integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>

        <jsp:useBean id="a" class="dao.UserDAO" scope="request" />
    </head>
    <link rel="stylesheet" href="/SocialNetworkIRCNV/css/post.css">
    <link rel="stylesheet" href="/SocialNetworkIRCNV/css/postshare.css">
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
        <div id="offset" style="display: none"  >1</div>

        <jsp:useBean id="apiPrivacy" class="dao.PrivacyDao"/>
        <header>
            <%@include file="../block/header.jsp" %>
        </header>

        <jsp:include page = "/GetInfor"></jsp:include>
        <%            ArrayList<User> friendList = new dao.UserDAO().getUserFriend(id, 1, 9);
        %>

        <div class ="profile-container ">

            <img src="<%=user.getCoverImg()%>"  onclick="openchangeimagebackground()" class="cover-img"/> <!-- ?nh b?a -->
            <!-- Ph?n ??u -->
            <div class = "profile-details">
                <div class ="pd-left">
                    <div class ="pd-row">
                        <img src ="<%=user.getImgUser()%>" class ="pd-image" onclick="openchangeimageavatar()">
                        <div class = "profile-name">
                            <h3><a href="" style="text-decoration: none; color:#626262;"><%=user.getFullName()%></a></h3>
                            <p><%= user.getNumFriend()%> Friends</p>
                            <%
                                int size = (5 > friendList.size()) ? friendList.size() : 5;
                                for (int i = 0; i < size; i++) {%>
                                <img src="<%=friendList.get(i).getImgUser()%>" alt="alt" onclick="otherProfile('<%=friendList.get(i).getUserID()%>')"  />
                                
                            <%}%>  
                        </div>
                    </div>
                </div>
                <div class = "pd-right">
                    <button type = "button"> 
                        <a href ="#" onclick="changeInfo()" style = "font-size: 17px; text-decoration: none; color:#626262;">  <i class="icon fa-solid fa-pen " style = " background:#e4e6eb;
                                                                                                                                  color:#000;"></i> Change Information</a></button>
                    <br>

                </div>
            </div>


            <!-- Ph?n bên trái c?a trang (bao g?m introduce và b?n bè... -->
            <div class ="profile-info col-md-12" style="padding: 0;">
                <div class ="info-col col-md-4" style="">
                    <div class ="profile-intro">

                        <!-- Introduce -->
                        <h3>Intro</h3>
                        <p class = "intro-text"><%=user.getIntro()%></p>
                        <hr>
                        <ul>
                            <li><i class="intro fa-solid fa-house" style="width: 26px; margin: 0"></i><span>Lives in</span>  <span style="margin-right: 5px;"></span><span><strong><%=user.getAddress()%></strong></span></li>
                            <li><i class="intro fa-solid fa-location-dot" style="width: 26px; margin: 0"></i><span>From</span> <span style="margin-right: 5px;"></span> <span><strong><%=user.getNation()%></strong></span></li>
                        </ul>
                    </div>
                    <div class = "profile-intro">
                        <!--  Friends -->
                        <div class ="title-box">
                            <h3>Friends</h3>
                            <a href ="/SocialNetworkIRCNV/PersonalPage/FriendList.jsp" style="margin-top:-18px;">All Friends</a>
                        </div>
                        <div class = "friend-box">
                            <%
                                size = (9 > friendList.size()) ? friendList.size() : 9;
                                for (int i = 0; i < size; i++) {%>
                            <div onclick="otherProfile('<%=friendList.get(i).getUserID()%>')">
                                <img src="<%=friendList.get(i).getImgUser()%>">
                                <span onmouseover="displayName(this)" onmouseout="hideName(this)" style="display: none"><%=friendList.get(i).getFullName()%></span>
                            </div>
                            <%}%>
                        </div>

                    </div>
                </div>

                <!-- Up bài -->
                <div class ="post-col col-md-8" style="">
                    <div class ="write-post-container">
                        <div class ="user-profile">
                            <img src="<%=user.getImgUser()%>" >
                            <div>
                                <p><a href="" style="text-decoration: none; color:#626262;"><%=user.getFullName()%></a> </p>
                                <select id="privacy" name = "privacy" style="color:#626262;">
                                    <c:forEach items="${apiPrivacy.allPrivacy}" var="ele">
                                        <option style="color:#626262; background-color:#cdf1ff;  ">${ele.getPrivacyName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div class ="post-input-container" id="post-input-container">
                                <textarea id="NewPostTextarea" rows ="3" placeholder="What's on your mind?"></textarea>    
                                <img id="previewImage" src="#" alt="Preview Image" style="display: none">
                                <input type="file" accept="image,gif/*,capture=camera" name="photo" id="fileInput">
                            </div> 
                            <button onclick="load('Post')">add new post</button>
                        </div>
                    </div>



                    <!-- Bài Post -->
                    <div class ="post-container"  id="post" style="margin: 0; padding: 0">

                    </div>
                    <div id="btnloadmore">
                        <button onclick="loadMorePost('profileinfo', '<%=id%>', document.getElementById('offset').innerHTML)">load more </button>
                    </div>
                </div>
                <div class="modal" id = "change-image-background" tabindex="-1" role="dialog">

                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Change Back ground</h5>

                            </div>
                            <div class="modal-body">
                                <form action="/SocialNetworkIRCNV/UpdateImage" method = "post" enctype="multipart/form-data">
                                    <div class="form-group">
                                            <label for="cover-image" class="col-form-label">Cover Image:</label>
                                            <img id="previewImage3" src="<%=user.getCoverImg()%>" alt="Preview Image" style="width: 100%;
                                                                                                                            border-radius: 3px;
                                                                                                                            margin-bottom: 14px;
                                                                                                                            object-fit: cover;
                                                                                                                            height: 200px;
                                                                                                                        }">
                                            <input type="hidden" name="type"value="cover"> 
                                            <input  type="file" accept="image/*,capture=camera" name="image" id="fileInput3">
                                            
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

                    <script>
                        document.getElementById('fileInput3').addEventListener('change', function (event) {
                            var file = event.target.files[0];
                            // T?o ??i t??ng FileReader ?? ??c t?p tin
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var previewImage = document.getElementById('previewImage3');
                                previewImage.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        });

                    </script>
                </div>          
                <div class="modal" id = "change-image-avatar" tabindex="-1" role="dialog">

                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Change Information</h5>

                            </div>
                            <div class="modal-body">
                                <form action="/SocialNetworkIRCNV/UpdateImage" method = "post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="avatar" class="col-form-label">Avatar:</label>
                                        <img id="previewImage4" src="<%=user.getImgUser()%>" alt="Preview Image" style="width: 130px;
                                             height: 130px;
                                             margin-right: 30px;
                                             border-radius: 3px;
                                             object-fit: cover;">
                                        <input  type="file" accept="image/*,capture=camera" name="image" id="fileInput4">
                                    </div>
                                    <input type="hidden"  name="type"value="avatar"> 
                                    <input type="submit" class="btn btn-primary" value="Save changes">
                                    
                                    <!--<button type="submit" class="btn btn-primary">Save  changes</button>-->
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>     
                                </form>
                            </div>

                            <div class="modal-footer">

                            </div>

                        </div>
                    </div>             

                    <script>
                        document.getElementById('fileInput4').addEventListener('change', function (event) {
                            var file = event.target.files[0];
                            // T?o ??i t??ng FileReader ?? ??c t?p tin
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var previewImage = document.getElementById('previewImage4');
                                previewImage.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        });

                    </script>
                </div>     
                <div class="modal" id = "changeinfo" tabindex="-1" role="dialog">

                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Change Information</h5>

                            </div>
                            <div class="modal-body">
                                <form action="/SocialNetworkIRCNV/UpdateInfo" method = "post" enctype="multipart/form-data">

                                    <div class="form-group">
                                        <label for="full-name" class="col-form-label">Full Name:</label>
                                        <input value = "<%=user.getFullName()%>"type="text" id="fullname" name="fullname" class="form-control border-primary">
                                    </div>



                                    <div class="form-group">
                                        <label for="date-of-birth" class="col-form-label">Date of Birth:</label>
                                        <input value = "<%=user.getDOB()%>"type="date" id="dateofbirth" name="dob" class="form-control border-primary">
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
                                    <div class="form-group">
                                        <label for="intro" class="col-form-label">Introduce:</label>
                                        <textarea class="form-control border-primary" id="intro" name="intro"  rows="8" cols="60"><%=user.getIntro()%></textarea>
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

                    <script>
                        document.getElementById('fileInput4').addEventListener('change', function (event) {
                            var file = event.target.files[0];
                            // T?o ??i t??ng FileReader ?? ??c t?p tin
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var previewImage = document.getElementById('previewImage4');
                                previewImage.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        });

                    </script>
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
                        <script>
                            document.getElementById('fileInput2').addEventListener('change', function (event) {
                                var file = event.target.files[0];

                                // T?o ??i t??ng FileReader ?? ??c t?p tin
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    var previewImage = document.getElementById('imgPost');
                                    previewImage.src = e.target.result;
                                    previewImage.style = " max-width:660px; max-height:660px;";
                                };
                                reader.readAsDataURL(file);
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
        <script src="/SocialNetworkIRCNV/js/load.js" ></script>
        <script src="/SocialNetworkIRCNV/js/controlPost.js"></script>
        <script src="/SocialNetworkIRCNV/PersonalPage/ProfileInfo.js" ></script>
        <script src="/SocialNetworkIRCNV/js/like.js" ></script>
        <script src="/SocialNetworkIRCNV/js/friend.js" ></script>
    </body>
</html>
