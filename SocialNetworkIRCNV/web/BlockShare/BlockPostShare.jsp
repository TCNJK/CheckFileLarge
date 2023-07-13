

<%@page import="java.util.ArrayList"%>
<%@page import="model.Comment"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
              integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>share Share</title>
        <style>
            body{

            }

            .share{
                background:#fff;
                border-radius:10px;
                padding-right: 0;
                margin-right: 0;
            }
            .share .share-top, .share .share-head{
                display:flex;
                align-items: center;
                padding:10px;
                padding-bottom: 0;
            }

            .share .share-body{
                margin-top: 2%;
                border: 1px #00587c solid;
                border-radius: 10px;
                width: 94%;
                margin-left: 3%;

            }

            .share .dp{
                width:60px;
                height:60px;
                border-radius: 50%;
                overflow:hidden;
            }

            .share .share-top .dp > img{
                cursor:pointer;
            }

            .share .share-info{
                margin-left:10px;
                font-weight: bold;
            }

            .share .share-info .name{
                cursor:pointer;
                font-size:23px;
                margin-bottom: 0;
                padding-bottom: 0;
            }

            .share .share-info .time{
                font-size:14px;
                cursor:pointer;
            }

            .share .share-head i{
                margin-left:auto;
                cursor: pointer;
            }

            .share .share-head > input{
                height:40px;
                padding:5px 10px;
                border-radius:25px;
                outline:none;
                border:none;
                flex:1;
                background:#eee;
                margin-left:10px;
            }

            .share .share-content{
                font-size:20px;
                font-weight:normal;
                padding:10px;
                max-height: 1000px;
            }

            .share .share-body .share-content  > img{
                height: 95%;
                margin:5px 0px;
                max-height: 530px;
            }
            .share .share-bottom, .share .counter{
                box-shadow: 1px solid #ddd;
                display:flex;
                justify-content: space-between;
                padding:0 10%;
                font-size: 18px;
                font-family: sans-serif;

            }
            .share .counter{
                padding: 10px 10%;
                color: #00587c;
            }
            .share .share-bottom .action{
                padding:10px;
                border-radius:10px;
                transition: .3s ease-in;
                cursor: pointer;
            }

            .share .share-bottom .action:hover{
                background:#eee;
            }
            
        </style>
    </head>
    <body>
         <%
            String img_pro = request.getParameter("img_pro");
            String name_user = request.getParameter("name_user");
            String timePost = request.getParameter("timePost");
            String Content = request.getParameter("Content");
            String img_post = request.getParameter("img_post");
            
            String img_pros = request.getParameter("img_pros");
            String name_users = request.getParameter("name_users");
            String timePosts = request.getParameter("timePosts");
            String Publics = request.getParameter("Publics");
            String Contents = request.getParameter("Contents");
            
            String num_like = request.getParameter("num_like");
            String num_cmt = request.getParameter("num_cmt");
            String num_share = request.getParameter("num_share");
        %>
        <div class="share">
            <div class="share-head">
                <div class="dp" >
                    <img src="<%=img_pros%>" alt="" style="width: 100%;" >
                </div>
                <div class="share-info">
                    <p class="name" style="color: #003140"><%=name_users%></p>
                    <span class="time" style="color: #70d8ff"><%=timePosts%></span>
                    <i style="">
                        <select class="fas fa-ellipsis-h">
                            <option value="<%=Publics%>">Private</option>
                            <option value="<%=Publics%>">Public</option>
                        </select> 
                    </i>
                </div>
                <i class="fas fa-ellipsis-h"></i>
            </div>
            <div class="share-content">
                <%=Contents%>
            </div>
            <div class="share-body">
                <div class="share-top" >
                    <div class="dp" >
                        <img src="<%=img_pro%>" alt="" style="width: 100%;" >
                    </div>
                    <div class="share-info">
                        <p class="name" style="color: #003140"><%=name_user%></p>
                        <span class="time" style="color: #70d8ff"><%=timePost%></span>
                    </div>

                </div>

                <div class="share-content" style="text-align: center;">
                    <p style="text-align: left;"><%=Content%></p>
                    <img src="<%=img_post%>" />
                </div>
            </div> 
               
            <div class="counter">
                <div class="count-like">
                    <span><%=num_like%></span>
                </div>
                <div class="count-cmt">
                    <span><%=num_cmt%></span>
                </div>
                <div class="count-share">
                    <span><%=num_share%></span>
                </div>
            </div>
            <div class="share-bottom" style=" width: 90%; color:  #00abfd; border-top: 1px #00587c solid; margin-left: 5%; padding: 0 5%;">
                <div class="action">
                    <i class="far fa-thumbs-up"></i>
                    <span>Like</span>
                </div>
                <div class="action">
                    <a href="#writecomment-share" style="text-decoration: none; color:  #00abfd;">
                        <i class="far fa-comment"></i>
                        <span>Comment</span>
                    </a>
                </div>
                <div class="action">
                    <i class="fa fa-share">
                        <select class="fas fa-ellipsis-h">
                            <option >Share Public</option>
                            <option >Share Private</option>
                        </select> 
                    </i>
                    <span>Share</span>
                </div>
            </div>
        
        </div>
        
</body>
</html>
