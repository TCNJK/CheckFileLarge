

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <body>
        <%
            String UserIDownPost = request.getParameter("UserIDownPost");
            String nameUserDown = request.getParameter("nameUserDown");
            String imgUserDown = request.getParameter("imgUserDown");

            String timePostDown = request.getParameter("timePostDown");
            String contentDown = request.getParameter("contentDown");
            String PostID = request.getParameter("PostID");
            String IDshare = request.getParameter("IDshare");
            String UserID = request.getParameter("UserID");

            String NameShare = request.getParameter("NameShare");
            String img_UserShare = request.getParameter("img_UserShare");
            String Content = request.getParameter("Content");

            String timePost = request.getParameter("timePost");
            String NumInterface = request.getParameter("NumInterface");
            String NumComment = request.getParameter("NumComment");
            String Public = request.getParameter("Public");
            String img_post = request.getParameter("img_post");

        %>
        <div class="share"  style="margin: 10px; width: 700px;" id="<%=IDshare%>">
            <div class="share-head">
                <div class="dp" >
                    <img src="<%=img_UserShare%>" alt="" style="width: 100%;" >
                </div>
                <div class="share-info">
                    <p class="name" style="color: #003140"><%=NameShare%></p>
                    <span class="time" style="color: #70d8ff"><%=timePost%></span>
                    <span class="time" style="color: #003140"><%=Public%></span>
                </div>
                <i class=" dropdown fas fa-ellipsis-h">
                    <div >

                        <div class="dropdown-content">
                            <a href="#" onclick="deletePost('<%=IDshare%>', 'Share')">Delete</a>
                            <a href="#" onclick="modifyPost('<%=IDshare%>', '<%=img_UserShare%>', '<%=NameShare%>', '<%=timePost%>',
                                            '<%=Public%>', '<%=Content.trim()%>', '<%=img_post%>')">Modify</a>
                        </div>
                    </div>
                </i>

            </div>
            <div class="share-content">
                <%=Content%>
            </div>
            <div class="share-body">
                <div class="share-top" >
                    <div class="dp" >
                        <img src="<%=imgUserDown%>" alt="" style="width: 100%;" >
                    </div>
                    <div class="share-info">
                        <p class="name" style="color: #003140"><%=nameUserDown%></p>
                        <span class="time" style="color: #70d8ff"><%=timePostDown%></span>
                    </div>

                </div>

                <div class="share-content" style="text-align: center;" >
                    <p style="text-align: left;"><%=contentDown%></p>
                    <img style="max-width: 100%" src="<%=img_post%>" />
                </div>
            </div> 

            <div class="counter">
                <div class="count-like">
                    <span><%=NumInterface%></span>
                </div>
                <div class="count-cmt">
                    <span><%=NumComment%></span>
                </div>
                <div class="count-share">
                    <span><%=NumComment%></span>
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
                <div class="action" onclick="SharePost('<%=PostID%>', '<%=imgUserDown%>', '<%=UserIDownPost%>', '<%=Content%>', '<%=img_post%>')">
                    <i class=" dropdown fa fa-share">
                        <span>Share</span>
                    </i>
                </div>
            </div>
        </div>

    </body>
</html>