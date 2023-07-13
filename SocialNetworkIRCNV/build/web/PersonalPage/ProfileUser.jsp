<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.User"%>
<%@ page errorPage="../error/errorPage.jsp" %>  
<%@page import="model.PostShare"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.PostUser"%>
<%@page import="model.Post"%>
<%@page import="model.PostShare"%>
<%@page import="model.PostUser"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.Privacy"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Profile User</title>
        <link rel="icon" href="/SocialNetworkIRCNV/data/img/logo.jpg" type="image/i-con">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script> 
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>

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
            flex-basis:36%;
            margin-right:20px;
        }
        .post-col{
            flex-basis: 63%;
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
        .pd-right .sendmessage button  {
            background:#1876f2;
            color: white;
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
            padding:20px;
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


        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f1f1f1;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 10px;
        }

        .dropdown-content a:hover {
            background-color: #ddd;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: #3e8e41;
        }

        .post .post-top{
            display:flex;
            align-items: center;
            padding:10px;
            padding-bottom: 0;
        }

        .post .post-top .dp{
            width:60px;
            height:60px;
            border-radius: 50%;
            overflow:hidden;
        }

        .post .post-top .dp > img{

            cursor:pointer;
        }

        .post .post-top .post-info{
            margin-left:10px;
            font-weight: bold;
        }

        .post .post-top .post-info .name{
            cursor:pointer;
            font-size:20px;
            margin-bottom: 0;
        }

        .post .post-top .post-info .time{
            font-size:14px;
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
            font-size:20px;
            font-weight:normal;
            padding: 10px;
            max-height: 1000px;
        }

        .post .post-content > img{
            margin:5px 0px;
            max-height: 530px;
        }
        .post .post-content p{
            margin-left: 20px;
        }
        .post .counter{
            padding: 10px 10%;
            color: #00587c;
        }
        .post .counter{
            box-shadow: 1px solid #ddd;
            display:flex;
            justify-content: space-between;
            padding:0 10%;
            font-size: 18px;
            font-family: sans-serif;

        }
        .post .post-bottom{
            box-shadow: 1px solid #ddd;
            display:flex;
            justify-content: space-between;
            padding:0 10%;
            font-size: 18px;
            font-family: sans-serif;

        }

        .post .post-bottom .action{
            padding:10px;
            border-radius:10px;
            transition: .3s ease-in;
            cursor: pointer;
        }

        .post .post-bottom .action:hover{
            background:#eee;
        }
    </style>
    <body style="margin: 0">
        <div id="offset" style="display: none"  >1</div>
        <div id="UID" style="display: none"  >${param.UID}</div>
        <jsp:useBean id="apiPrivacy" class="dao.PrivacyDao"/>
        <header>
            <%@include file="../block/header.jsp" %>
        </header>
        <%            if (profileUser == null) {
                throw new Exception("User not fount");
            }
            System.out.println("id and UID" + id + UID);
            String FriendStatus = new dao.RelationDao("relate").getDivRelation(id, UID);
            ArrayList<User> friendList = new dao.UserDAO().getUserFriend(UID, 1, 9);

            //request.setAttribute("profileUser", profileUser);
        %>
        
        <div class ="profile-container">
            <img src="<%=profileUser.getCoverImg()%>" class="cover-img"/>
            <div class = "profile-details">
                <div class ="pd-left">
                    <div class ="pd-row">
                        <img src ="<%=profileUser.getImgUser()%>" class ="pd-image">
                        <div>
                            <h3><a href="" style="text-decoration: none; color:#626262;"><%=profileUser.getFullName()%></a></h3>
                            <p><%=profileUser.getNumFriend()%> Friends</p>
                            <%
                                int size = (5 > friendList.size()) ? friendList.size() : 5;
                                for (int i = 0; i < size; i++) {%>
                            <img src="<%=friendList.get(i).getImgUser()%>" alt="alt" onclick="otherProfile('<%=friendList.get(i).getUserID()%>')"/>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class = "pd-right" >
                    <span class ="friendstatus" id="friendstatus">
                        <%=FriendStatus%>
                    </span>
                    <span class = "sendmessage">    
                        <a href="/SocialNetworkIRCNV/BoxChat/BoxChat.jsp?Friendid=<%=profileUser.getUserID()%>">
                            <button type = "button"> 
                            <i class="icon fa-regular fa-message"></i> Send Message
                        </button>
                        </a>
                        
                    </span><br>
                    <a href ="" onclick="askReportUser('<%=UID%>', '<%=id%>')"> 
                        <i class="fa-sharp fa-solid fa-flag more" style= "background:#e4e6eb;color:#000;" ></i>
                        
                    </a>
                </div>
            </div>

            <div class ="profile-info">
                <div class ="info-col">
                    <div class ="profile-intro">
                        <h3>Intro</h3>
                        <p class = "intro-text"><%=profileUser.getIntro()%></p>
                        <hr>
                        <ul>
                            <li><i class="intro fa-solid fa-house" style="width: 26px;  margin: 0" ></i>Lives in  <span style="margin-right: 5px;"></span><strong><%=profileUser.getAddress()%></strong></li>
                            <li><i class="intro fa-solid fa-location-dot" style="width: 26px; margin: 0"></i>From  <span style="margin-right: 5px;"></span><strong><%=profileUser.getNation()%></strong></li>
                        </ul>
                    </div>
                    <div class = "profile-intro">
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
                                
                            </div>
                            <%}%>
                        </div>



                    </div>



                </div>
                <div>
                    <div class ="post-container"  id="post" style="margin: 0; padding: 0">

                    </div>
                    <div id="btnloadmore">
                        <button onclick="loadMorePost('profileuser', '<%=UID%>', document.getElementById('offset').innerHTML)">load more </button>
                    </div>
                </div>
            </div>
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
                                            <input  type="file" accept="image/*,capture=camera" name="coverimage" id="fileInput3">
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
        </div>
        <script src="/SocialNetworkIRCNV/PersonalPage/ProfileUser.js" >


        </script>
        <script src="/SocialNetworkIRCNV/js/load.js" >


        </script>
        <script src="/SocialNetworkIRCNV/js/controlPost.js">

        </script>
        <script src="/SocialNetworkIRCNV/js/like.js" ></script>



    </body>
</html>
