<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.InterFaceObject"%>
<%@page import="model.CommentChild"%>
<%@page import="model.Comment"%>
<%@page import="model.User"%>
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
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/post.css">
        <link rel="stylesheet" href="/SocialNetworkIRCNV/css/postshare.css">
        <title>MediaBook</title>
        <style>

            .post-input-container{
                width: 100%
            }
            .post-input-container textarea{
                width:100%;
                border:0;
                outline:0;
                border-bottom: 1px solid #ccc;
                background:transparent;
                resize: none;
            }
            #previewImage{
                margin:5px 0px;
                max-height: 530px;
            }




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
            .img-post-comment{
                margin-left: 0;
                margin:5px 0px;
                max-height: 100px;
                max-width: 100%;
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
        <div class="container col-md-12" style="max-width: 1850px; width: 100%; min-width: 1045px; padding: 0;">

            <div class="middle-panel col-md-6" style="   ">


                <div class = "block-comment col-md-6">
                    <div>
                        <div>
                            <div class="comment" style="width: 100%;">
                                <main>
                                    <section id="PID00000006" class="comment-module" style=" max-height: 700px; overflow-y: auto;">
                                        <ul>

                                            <li>
                                                <div class="comment">
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
                                                </div>

                                            </li>

                                        </ul>
                                        <ul id="PID00000006">
                                            <%
                                                 String id = (String) session.getAttribute("id");
                                                Connection cnn = new connection.connection().getConnection();
                                                ArrayList<Comment> commentList = new dao.CommentDAO().getCommentByPostID("PID00000006");
                                                commentList.forEach((t) -> {
                                                   
                                                    User userComment = new dao.UserDAO(cnn).getUserByID(t.getUserID());
                                                    InterFaceObject interFaceObject = new dao.InterFaceObjectDAO(cnn).getInterFaceObjectByID(t.getCmtID(), id);
                                            %>
<li id="<%=t.getCmtID()%>">
    <div class="comment">
        <div class="comment-img">
            <img src="<%=userComment.getImgUser()%>" alt="">
        </div>
        <div class="comment-content">
            <div class="comment-details">
                <h4 class="comment-name"><%=userComment.getFullName()%></h4>
                <span class="comment-log"><%=t.getTimeComment()%></span>
            </div>
            <div class="comment-desc">
                <p><%=t.getContent()%><br>
                    <%if (t.getImageComment() != null && !t.getImageComment().isEmpty()) {%>
                    <img src="<%=t.getImageComment()%>">
                    <%}%>
                </p>
            </div>
            <div class="comment-data">
                <div class="comment-likes">
                    <div class="comment-likes-up" onclick="like('<%=t.getCmtID()%>', '<%=interFaceObject.getInterFaceID()%>')">
                        <%=interFaceObject.getInterFaceDiv()%>

                    </div>
                    <span><%=t.getNumInterface()%></span>
                </div>
                <div class="comment-reply" onclick="reply('<%=t.getPostID()%>', '<%=userComment.getFullName()%>')">
                    <a href="#!">Reply</a>
                </div>
                <div class="comment-report">
                    <a href="#!">Report</a>
                </div>
            </div>
        </div>
    </div>
</li>

                                            <%
                                                t.getCommentChild().forEach((e) -> {
                                                    CommentChild commentChild = new dao.CommentDAO(cnn).getCommentChildByChildID(e.getChilID());
                                                    User userCommentChild = new dao.UserDAO(cnn).getUserByID(commentChild.getUserID());
                                                    InterFaceObject interFaceObjectChild = new dao.InterFaceObjectDAO(cnn).getInterFaceObjectByID(e.getChilID(), id);

                                            %>
                                            <ul >
                                                <li id="<%=commentChild.getChilID()%>">
                                                    <div class="comment">
                                                        <div class="comment-img">
                                                            <img src="<%=userCommentChild.getImgUser()%>" alt="">
                                                        </div>
                                                        <div class="comment-content">
                                                            <div class="comment-details">
                                                                <h4 class="comment-name"><%=userCommentChild.getFullName()%></h4>
                                                                <span class="comment-log"><%=commentChild.getTimeComment()%></span>
                                                            </div>
                                                            <div class="comment-desc">
                                                                <p><%=commentChild.getContent()%><br>
                                                                    <%if (commentChild.getImageComment() != null && !commentChild.getImageComment().isEmpty()) {%>
                                                                    <img src="<%=commentChild.getImageComment()%>">
                                                                    <%}%>
                                                                </p>
                                                            </div>
                                                            <div class="comment-data">
                                                                <div class="comment-likes">
                                                                    <div class="comment-likes-up" onclick="like('<%=commentChild.getChilID()%>', '<%=interFaceObjectChild.getInterFaceID()%>')">
                                                                        <%=interFaceObjectChild.getInterFaceDiv()%>

                                                                    </div>
                                                                    <span><%=commentChild.getNumInterface()%></span>
                                                                </div>
                                                                <div class="comment-reply" onclick="reply('<%=commentChild.getCmtID()%>', '<%=userCommentChild.getFullName()%>')">
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
                                            <%});%>
                                            </li>
                                            <% });%>
                                        </ul>


                                    </section>
                                </main>

                                <div class="write-comment" style="background: white">
                                    <div class ="post-input-container" id="post-input-container">
                                        <div style="display: inline"> 
                                            <textarea style="width: 80%; align-items: start" id="NewPostTextarea" rows ="3" placeholder="What's on your mind?"></textarea>   
                                            <div id="button-load-comment" style="width: 10%" onclick="loadComment('')"><a href=""><i style="font-size:27px;color:#00abfd" class="fa-solid fa-paper-plane"></i></a></div> 
                                        </div>
                                        <img id="previewImage" src="#" alt="Preview Image" style="display: none">
                                        <input type="file" accept="image/*,capture=camera" name="photo" id="fileInput">
                                    </div> 
                                </div>

                            </div>
                        </div>
                    </div> 
                </div>
            </div>
            <script src="/SocialNetworkIRCNV/js/controlComment.js"></script>
            <script src="/SocialNetworkIRCNV/js/controlPost.js"></script>
            <script src="/SocialNetworkIRCNV/js/like.js"></script>

    </body>

</html>