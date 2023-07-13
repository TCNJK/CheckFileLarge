<%@page import="controller.Text"%>
<%@page import="model.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    
    <body>

        <%
            Text text= new Text();
            String post_id = request.getParameter("post_id");
            String img_pro = request.getParameter("img_pro");

            String name_user =text.changeUTF8(request.getParameter("uName"));
            //String name_user =request.getParameter("uName");
            String img_user = request.getParameter("img_user");

            String timePost = request.getParameter("time");
            String Public = request.getParameter("Public");
            String content = request.getParameter("content");
            String Content1 = content;
            String img_post = request.getParameter("img_post");
            String num_like = request.getParameter("num_like");
            String num_cmt = request.getParameter("num_cmt");
            String num_share = request.getParameter("num_share");
            request.setAttribute("img_post", img_post);
        %>
        <div class="post" style="margin: 10px; background: white; border-radius: 10px" id="<%=post_id%>">
            <div class="post-top">
                <p style="display: none"><%=post_id%></p>
                <div class="dp" >
                    <img src="<%=img_user%>" alt="" style="width: 100%;" >
                </div>
                <div class="post-info">
                    <p class="name" style="color: #003140"><%=name_user%></p>
                    <span class="time" style="color: #70d8ff"><%=timePost%></span>
                    <span class="time" style="color: #003140"><%=Public%></span>
                </div>
                <i class=" dropdown fas fa-ellipsis-h">
                    <div >

                        <div class="dropdown-content">
                            <a href="#" onclick="deletePost('<%=post_id%>', 'Post')">Delete</a>
                            <a href="#" onclick="modifyPost('<%=post_id%>', '<%=img_user%>', '<%=name_user%>', '<%=timePost%>',
                                            '<%=Public%>', '<%=content.trim()%>', '<%=img_post%>')">Modify</a>
                        </div>
                    </div>
                </i>
            </div>

            <div class="post-content" style="text-align: center;">
                <p style="text-align: left;"><%=content%></p>
                <c:if test="${img_post!=null && img_post!=''}">
                    <img src="<%=img_post%>"style="margin: 0 auto; max-width: 100%"/>
                </c:if>
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


            <div class="post-bottom" style=" width: 90%; color:  #00abfd; border-top: 1px #00587c solid; margin-left: 5%; padding: 0 5%;">
                <div class="action">
                    <i class="far fa-thumbs-up"></i>
                    <span>Like</span>
                </div>
                <div class="action">
                    <a href="#writecomment" style="text-decoration: none; color:  #00abfd;">
                        <i class="far fa-comment"></i>
                        <span>Comment</span>
                    </a>
                </div>
                <div class="action" onclick="SharePost('<%=post_id%>', '<%=img_user%>', '<%=name_user%>', '<%=content.trim()%>', '<%=img_post%>')">
                    <i class=" dropdown fa fa-share">
                    </i>
                    <span>Share</span>
                </div>
            </div>
        </div>                  
    </body>

</html>
