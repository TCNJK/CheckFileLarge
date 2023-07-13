<%@page import="model.User"%>
<%@page import="model.PostShare"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.PostUser"%>
<%@page import="model.Post"%>
<%@page import="model.PostShare"%>
<%@page import="model.PostUser"%>
<%@page import="dao.UserDAO"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <link rel="icon" href="/SocialNetworkIRCNV/data/img/logo.jpg" type="image/i-con">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
              integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/post.css">
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/postshare.css">
        <title>MediaBook</title>
        <style>
                        * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Rubik", sans-serif;

            }
            * ul {
                list-style: none;
            }
            * a {
                text-decoration: none;
            }


            main {
                width: 100%;
                height: 100%;
                display: grid;
                place-items: center;
            }
            main section.comment-module {
                width: 100%;
                height: auto;
                background: #fff;
                border-radius: 10px;
                padding: 20px 30px;
            }
            main section.comment-module ul {
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                row-gap: 50px;
                margin-left: 0px;
            }
            main section.comment-module ul li {
                width: 100%;
                position: relative;
            }
            main section.comment-module ul li .comment {
                width: 100%;
                display: flex;
                column-gap: 20px;
            }
            main section.comment-module ul li .comment .comment-img {
                width: 9%;
            }
            main section.comment-module ul li .comment .comment-img img {
                width: 50px;
                height: 50px;
            }
            main section.comment-module ul li .comment .comment-content {
                width: 93%;
                display: flex;
                flex-direction: column;
                row-gap: 12px;
            }
            main section.comment-module ul li .comment .comment-content .comment-details {
                width: 100%;
                display: flex;
                column-gap: 15px;
                align-items: center;
                justify-content: flex-start;
            }
            main section.comment-module ul li .comment .comment-content .comment-details .comment-name {
                text-transform: capitalize;
                font-size: 20px;
            }
            main section.comment-module ul li .comment .comment-content .comment-details .comment-log {
                color: #7a7a7a;
                font-size: 15px;
            }
            main section.comment-module ul li .comment .comment-content .comment-data {
                width: 100%;
                display: flex;
                justify-content: flex-start;
                align-items: center;
                column-gap: 20px;
            }
            main section.comment-module ul li .comment .comment-content .comment-data .comment-likes {
                display: flex;
                align-items: center;
                column-gap: 12px;
            }
            main section.comment-module ul li .comment .comment-content .comment-data .comment-likes > div {
                display: flex;
                column-gap: 4px;
                align-items: center;
            }
            main section.comment-module ul li .comment .comment-content .comment-data .comment-likes > div img {
                cursor: pointer;
            }
            main section.comment-module ul li .comment .comment-content .comment-data .comment-likes > div span {
                font-weight: 600;
            }
            main section.comment-module ul li .comment .comment-content .comment-data .comment-reply a,
            main section.comment-module ul li .comment .comment-content .comment-data .comment-report a {
                color: #272727;
                font-weight: 400;
            }
            main section.comment-module ul li::before {
                content: "";
                position: absolute;
                top: 60px;
                left: 50px;
                transform: translateX(-25px);
                width: 2px;
                height: calc(100% - 60px);
                background: #c5c5c5;
            }
            main section.comment-module ul li ul {
                margin-top: 35px;
                margin-left: 70px;
                width: calc(100% - 70px);
            }

            
            @media screen and (max-width: 768px) {
                main section.comment-module {
                    width: 96%;
                }
                main section.comment-module ul li .comment {
                    column-gap: 12px;
                }
                main section.comment-module ul li .comment .comment-img {
                    width: 15%;
                }
                main section.comment-module ul li .comment .comment-img img {
                    width: 40px;
                    height: 40px;
                }
                main section.comment-module ul li .comment .comment-content {
                    width: 85%;
                }
                main section.comment-module ul li .comment .comment-content .comment-details {
                    flex-direction: column;
                    align-items: flex-start;
                }
                main section.comment-module ul li .comment .comment-content .comment-data {
                    column-gap: 12px;
                }
                main section.comment-module ul li::before {
                    top: 50px;
                    left: 50px;
                    transform: translateX(-30px);
                    height: calc(100% - 60px);
                }
                main section.comment-module ul li ul {
                    margin-top: 25px;
                    margin-left: 50px;
                    width: calc(100% - 50px);
                }
            }
            .write-comment{
                margin-top: 10px;
                margin-left:-10px;
                width: 100%;
                display: inline-flex;
                text-align: center;
                align-items: center;
            }
            .comment-img{
                width: 50px;
                height: 50px;
                border-radius: 50%;
                overflow:hidden;
            }
            .input-group {
                margin: 15px;
                
                display: block;
                width: 79%;
                height: 55px;
                border: solid 1px #00abfd;
                background-color: #ffffff;
                border-bottom-left-radius: 41px;
                border-bottom-right-radius: 41px;
                border-top-left-radius: 41px;
                border-top-right-radius: 41px;
                box-shadow: 0 17px 40px 0 rgba(75, 128, 182, 0.07);
                margin-bottom: 22px;
                position: relative;
                font-size: 17px;
                color: #a7b4c1;
                transition: opacity 0.2s ease-in-out, filter 0.2s ease-in-out,
                    box-shadow 0.1s ease-in-out;
            }

            .input-group:hover {
                box-shadow: 0 14px 44px 0 rgba(0, 0, 0, 0.077);
            }

            .input-group input {
                position: absolute;
                border: 0;
                box-shadow: none;
                background-color: rgba(255, 255, 255, 0);
                top: 0;
                height: 55px;
                width: 79%;
                padding: 0 53px;
                box-sizing: border-box;
                z-index: 3;
                display: block;
                color: #1a6fc4;
                font-size: 17px;
                font-family: "Oxygen", sans-serif;
                transition: top 0.1s ease-in-out;
            }

            .input-group input::placeholder {
                color: rgba(0, 0, 0, 0);
            }



            .input-group label {
                position: absolute;
                border: 0;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                z-index: 2;
                display: flex;
                align-items: center;
                padding: 0 53px;
                box-sizing: border-box;
                transition: all 0.1s ease-in-out;
                cursor: text;
            }

            .input-group input:focus + label,
            .input-group input:not(:placeholder-shown) + label {
                bottom: 20px;
                font-size: 13px;
                opacity: 0;
            }

            .req-mark {
                position: absolute;
                pointer-events: none;
                top: 0;
                right: 33px;
                bottom: 0;
                display: flex;
                align-items: center;
                justify-content: flex-end;
                font-size: 22px;
                color: #e0e0e0;
                font-family: "Ubuntu", sans-serif;
            }
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


            .post{
                width:700px;
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
                max-height: 600px;
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
            .comment-desc img{
                height:150px;
                width: 150px;   
            }
        </style>

    </head>

    <body>
        <header>
            <%@include file="../block/header.jsp" %>
        </header>

        <%            //String id = (String) session.getAttribute("id");
            if (id != null) {
        %>
        <div class="container col-md-12" style="max-width: 1850px; width: 100%; min-width: 1045px; padding: 0;">
            
            <div class="middle-panel col-md-6" style="   ">
                
                <jsp:include page="/post" />
                <%
                    ArrayList<Post> std = (ArrayList<Post>) request.getAttribute("ListPost");

                    for (int i = 0; i < std.size(); i++)
                        if (std.get(i) instanceof PostUser) {
                %>

                
                    <%try {%>
                    <div id="showpost">
                    <jsp:include page="../BlockPost/BlockPost.jsp">
                        <jsp:param name="post_id" value="<%=std.get(i).getPostID()%>" />
                        <jsp:param name="img_pro" value="<%=((PostUser) std.get(i)).getImagePost()%>" />
                        <jsp:param name="img_user" value="<%=user.getImgUser()%>"/>
                        <jsp:param name="uName" value="<%=((PostUser) std.get(i)).getFullNameUser()%>" />

                        <jsp:param name="time" value="<%=std.get(i).getTimePost()%>" />

                        <jsp:param name="Public" value="<%=std.get(i).isPublic()%>" />

                        <jsp:param name="content" value="<%=std.get(i).getContent()%>" />
                        <jsp:param name="img_post" value="<%=((PostUser) std.get(i)).getImagePost()%>" />
                        <jsp:param name="num_like" value="<%=std.get(i).getNumInterface()%>" />
                        <jsp:param name="num_cmt" value="<%=std.get(i).getNumComment()%>" />
                        <jsp:param name="num_share" value="<%=((PostUser) std.get(i)).getNumShare()%>" />
                    </jsp:include>
                     </div>
                    <%} catch (Exception e) {

                        }%>
               
                <%} else if (std.get(i) instanceof PostShare) {%>
                
                    <%try {%>
                    <div id="showpost">
                    <jsp:include page="../BlockPost/BlockPostShare.jsp">
                        <jsp:param name="UserIDownPost" value="<%=((PostShare) std.get(i)).getUserIDownPost()%>" />
                        <jsp:param name="nameUserDown" value="<%=((PostShare) std.get(i)).getNameUserDown()%>" />
                        <jsp:param name="imgUserDown" value="<%=((PostShare) std.get(i)).getImgUserDown()%>" />

                        <jsp:param name="timePostDown" value="<%=((PostShare) std.get(i)).getTimePostDown()%>" />
                        <jsp:param name="contentDown" value="<%=((PostShare) std.get(i)).getContentDown()%>" />
                        <jsp:param name="PostID" value="<%=((PostShare) std.get(i)).getPostID()%>" />
                        <jsp:param name="IDshare" value="<%=((PostShare) std.get(i)).getIDshare()%>" />
                        <jsp:param name="UserID" value="<%=((PostShare) std.get(i)).getUserID()%>" />

                        <jsp:param name="NameShare" value="<%= ((PostShare) std.get(i)).getNameShare()%>" />
                        <jsp:param name="img_UserShare" value="<%=((PostShare) std.get(i)).getImg_UserShare()%>" />
                        <jsp:param name="Content" value="<%=((PostShare) std.get(i)).getContent()%>" />

                        <jsp:param name="timePost" value="<%=((PostShare) std.get(i)).getTimePost()%>" />
                        <jsp:param name="NumInterface" value="<%=((PostShare) std.get(i)).getNumInterface()%>" />
                        <jsp:param name="NumComment" value="<%=((PostShare) std.get(i)).getNumComment()%>" />
                        <jsp:param name="Public" value="<%=((PostShare) std.get(i)).isPublic()%>" />
                        <jsp:param name="img_post" value="<%=((PostShare) std.get(i)).getImg_post()%>" />
                    </jsp:include>
                        </div>
                    <% } catch (Exception e) {

                            }
                        }%>
                        
            </div>
            <div class = "block-comment col-md-6">
                <script>
                                let likesUpParent = document.getElementsByClassName("comment-likes-up");
                                let likesDownParent = document.getElementsByClassName("comment-likes-down");

                                let likesEl = [];
                                for (let i = 0; i < likesUpParent.length; i++) {
                                    let likesUp = likesUpParent[i].getElementsByTagName("img")[0];
                                    let likesDown = likesDownParent[i].getElementsByTagName("img")[0];

                                    likesEl.push(likesUp, likesDown);
                                }

                                likesEl.forEach((el) => {
                                    el.addEventListener("click", function () {
                                        let likesClosestCountEl = this.parentElement.getElementsByTagName("span")[0];
                                        let likesCount = likesClosestCountEl.innerText;

                                        if (likesCount.trim().length === null) {
                                            likesCount = 0;

                                        } else {
                                            likesCount++;
                                        }
                                        likesClosestCountEl.innerText = likesCount;
                                    });
                                });

                            </script>
                <div>
                    <div>
                 
                    </div>
                                        <br>
                                         <div>
           <div class="comment" style="width: 100%;">
                <main>
                    <section class="comment-module" style=" max-height: 700px; overflow-y: auto;">
                        <ul>
        
                            <li>
                                <div class="comment" style="background-color: pink;">
                                    <div class="comment-img">
                                        <img src="https://i.pinimg.com/564x/00/96/dc/0096dc386bbeca215bc5f42deef14d6a.jpg" alt="?nh" style="border-radius: 50%;">
                                    </div>
                                    <div class="comment-content">
                                        <div class="comment-details">
                                            <h4 class="comment-name" style="color: #003140; margin-top: 7px;">andrew231</h4>
                                            <span class="comment-log" style="color: #70d8ff">20 hours ago</span>
                                        </div>
                                        <div class="comment-desc">
                                            <p>Thanks for making this, super helpful happi happi happi happi happi happi happi happi happi happi happi happi happi happi happihappi happi happi<br>
                                                <img src="https://i.pinimg.com/564x/67/08/ce/6708ce18672409459dbdabf30d661c15.jpg"></p>
                                        </div>
                                        <div class="comment-data">
                                            <div class="comment-likes">
                                                <div class="comment-likes-up">
                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Up.svg" alt="">
                                                    <span>2</span>
                                                </div>
                                                <div class="comment-likes-down">
                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Down.svg" alt="">
                                                    <span></span>
                                                </div>
                                            </div>
                                            <div class="comment-reply">
                                                <a href="#!">Reply</a>
                                            </div>
                                            <div class="comment-report">
                                                <a href="#!">Report</a>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        let likesUpParent = document.getElementsByClassName("comment-likes-up");
                                        let likesDownParent = document.getElementsByClassName("comment-likes-down");
        
                                        let likesEl = [];
                                        for (let i = 0; i < likesUpParent.length; i++) {
                                            let likesUp = likesUpParent[i].getElementsByTagName("img")[0];
                                            let likesDown = likesDownParent[i].getElementsByTagName("img")[0];
        
                                            likesEl.push(likesUp, likesDown);
                                        }
        
                                        likesEl.forEach((el) => {
                                            el.addEventListener("click", function () {
                                                let likesClosestCountEl = this.parentElement.getElementsByTagName("span")[0];
                                                let likesCount = likesClosestCountEl.innerText;
        
                                                if (likesCount.trim().length === null) {
                                                    likesCount = 0;
        
                                                } else {
                                                    likesCount++;
                                                }
                                                likesClosestCountEl.innerText = likesCount;
                                            });
                                        });
        
                                    </script>
                                </div>
                                
                            </li>
                            
                        </ul>
                        <ul>
                            <li>
                                <div class="comment">
                                    <div class="comment-img">
                                        <img src="https://rvs-comment-module.vercel.app/Assets/User Avatar.png" alt="">
                                    </div>
                                    <div class="comment-content">
                                        <div class="comment-details">
                                            <h4 class="comment-name">Adamsdavid</h4>
                                            <span class="comment-log">20 hours ago</span>
                                        </div>
                                        <div class="comment-desc">
                                            <p>I genuinely think that Codewell's community is AMAZING. It's just starting out but the templates on there amazing.<br>
                                                <img src="https://i.pinimg.com/564x/67/08/ce/6708ce18672409459dbdabf30d661c15.jpg"></p>
                                        </div>
                                        <div class="comment-data">
                                            <div class="comment-likes">
                                                <div class="comment-likes-up">
                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Up.svg" alt="">
                                                    <span>2</span>
                                                </div>
                                                <div class="comment-likes-down">
                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Down.svg" alt="">
                                                    <span></span>
                                                </div>
                                            </div>
                                            <div class="comment-reply">
                                                <a href="#!">Reply</a>
                                            </div>
                                            <div class="comment-report">
                                                <a href="#!">Report</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <ul>
                                    <li>
                                        <div class="comment">
                                            <div class="comment-img">
                                                <img src="https://rvs-comment-module.vercel.app/Assets/User Avatar-1.png" alt="">
                                            </div>
                                            <div class="comment-content">
                                                <div class="comment-details">
                                                    <h4 class="comment-name">saramay</h4>
                                                    <span class="comment-log">16 hours ago</span>
                                                </div>
                                                <div class="comment-desc">
                                                    <p>I agree. I've been coding really well (pun intended) ever since I started practicing on their templates hehe.<br>
                                                        <img src="https://i.pinimg.com/564x/67/08/ce/6708ce18672409459dbdabf30d661c15.jpg"></p>
                                                </div>
                                                <div class="comment-data">
                                                    <div class="comment-likes">
                                                        <div class="comment-likes-up">
                                                            <img src="https://rvs-comment-module.vercel.app/Assets/Up.svg" alt="">
                                                            <span>5</span>
                                                        </div>
                                                        <div class="comment-likes-down">
                                                            <img src="https://rvs-comment-module.vercel.app/Assets/Down.svg" alt="">
                                                            <span></span>
                                                        </div>
                                                    </div>
                                                    <div class="comment-reply">
                                                        <a href="#!">Reply</a>
                                                    </div>
                                                    <div class="comment-report">
                                                        <a href="#!">Report</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                       
                                    </li>
                                </ul>
                                 <ul>
                                            <li>
                                                <div class="comment">
                                                    <div class="comment-img">
                                                        <img src="https://rvs-comment-module.vercel.app/Assets/User Avatar-2.png" alt="">
                                                    </div>
                                                    <div class="comment-content">
                                                        <div class="comment-details">
                                                            <h4 class="comment-name">Jessica21</h4>
                                                            <span class="comment-log">14 hours ago</span>
                                                        </div>
                                                        <div class="comment-desc">
                                                            <p>Okay, this comment wins.<br><img src="https://i.pinimg.com/564x/67/08/ce/6708ce18672409459dbdabf30d661c15.jpg"></p>
                                                        </div>
                                                        <div class="comment-data">
                                                            <div class="comment-likes">
                                                                <div class="comment-likes-up">
                                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Up.svg" alt="">
                                                                    <span>5</span>
                                                                </div>
                                                                <div class="comment-likes-down">
                                                                    <img src="https://rvs-comment-module.vercel.app/Assets/Down.svg" alt="">
                                                                    <span></span>
                                                                </div>
                                                            </div>
                                                            <div class="comment-reply">
                                                                <a href="#!">Reply</a>
                                                            </div>
                                                            <div class="comment-report">
                                                                <a href="#!">Report</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                            </li>
                            
                        </ul>

                        
                    </section>
                </main>
                <div class="write-comment col-12" >
                    
                    <label for="file-upload" class="custom-file-upload">
                    <i class="fa-solid fa-paperclip" style="font-size:25px;color:#00abfd;margin-left:15px;"></i> 
                    </label>
                    <input id="file-upload" type="file" style="display: none;">
                    <div class="input-group col-8" style="width: 85%;">
                        <input id="writecomment" style="width: 100%" value="" class="form-control" type="text" name="text-1542372332072" id="text-1542372332072" required="required" placeholder="Write comment.......">

                       
                    </div>  
                    

                    <div class="col-1"><a href=""><i class="material-icons" style="font-size:48px;color:#00abfd">send</i></a></div> 
                </div>
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
                                            <img id="previewImage3" src="/SocialNetworkIRCNV/<%=user.getCoverImg()%>" alt="Preview Image" style="width: 100%;
                                                                                                                                                border-radius: 3px;
                                                                                                                                                margin-bottom: 14px;
                                                                                                                                                object-fit: cover;
                                                                                                                                                height: 200px;
                                                                                                                                            }">
                                            <input  type="file" accept="image/*,capture=camera" name="coverimage" id="fileInput3">
                                        </div>

                                        <div class="form-group">
                                            <label for="avatar" class="col-form-label">Avatar:</label>
                                            <img id="previewImage4" src="/SocialNetworkIRCNV/<%=user.getImgUser()%>" alt="Preview Image" style="width: 130px;
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
                                            <img src="/SocialNetworkIRCNV/<%=user.getImgUser()%>" alt="" style="width: 45px;
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
                                    <div>
                                        <input type="radio" id="privacyPostShareModel" name="privacy" value="Public">
                                          <label for="Public">Public</label><br>
                                         <input type="radio" id="privacyPostShareModel" name="privacy" value="Private">
                                          <label for="Private">Private</label><br>
                                    </div>
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
        <script src="/SocialNetworkIRCNV/js/controlPost.js">

        </script>


    </body>

</html>