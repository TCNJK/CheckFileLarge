<%-- 
    Document   : BoxChat
    Created on : Jun 5, 2023, 9:34:49 AM
    Author     : TCNJK
--%>

<%@page import="model.User"%>
<%@page import="dao.BoxChatFriendListDAO"%>
<%@page import="java.util.Hashtable"%>
<%@page import="model.FriendBoxChat"%>
<%@page import="model.FriendAndLastChat"%>
<%@page import="model.BoxChatFriend"%>

<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="styles.css"/>

    </head>
    <body onload="sendMessage()" style="margin: 0">
        <header style="width: 96%">
            <%@include file="../block/header.jsp" %>
        </header>
        <div class="container">
            <div class="sidebar">
                <ul class="friend-list">
                    <%
                       
                        String FID = request.getParameter("Friendid");

                        BoxChatFriendListDAO e = new BoxChatFriendListDAO();
                        BoxChatFriend data = e.getData(id);
                        FriendBoxChat box = e.getBoxChat(id, FID);
                        if (data != null) {
                    %>
                    <p id="UserID" class="userID" style="display: none;"><%=data.getUserID()%></p>
                    <%}
                        for (FriendAndLastChat last : data.getList()) {
                            String friendName = last.getFriendID();
                            User friendInfo = new dao.UserDAO().getUserByID(last.getFriendID());
                            String lastMessage = last.getLastChat();
                    %>
                    <!--GetFriendAndBoxChat-->
                    <a href="BoxChat.jsp?Friendid=<%=friendName%>">
                        <li class="friend-item">
                            <div class="friendV">
                                <div class="friend-avatar" style="text-align: center">
                                    <img style="width: 42px; height: 42px; " class="avatar" src="<%= friendInfo.getImgUser()%>" alt="alt"/>
                                </div>
                                <div class="friend-info">
                                    <div class="friend-name"><%= friendInfo.getFullName()%></div>
                                    <div class="friend-last-message"><%= lastMessage%></div>
                                </div>
                            </div>
                        </li>
                    </a>
                    <%}%>
                    <!-- Thêm các m?c b?n bè khác vào ?ây -->
                </ul>

            </div>
            <%
                String FriendId = "";
                String FriendName = "";
                String FriendImg = "";
                User friendInfo = null;
                if (box != null) {
                    friendInfo = new dao.UserDAO().getUserByID(box.getFriendID());
                    FriendId = box.getFriendID();
                    FriendName = friendInfo.getFullName();
                    FriendImg = friendInfo.getImgUser();
                }


            %>
            <div class="chat-container">
                <div class="chat-header">
                    <div class="friend-avatar" style="margin-right: 10px">
                        <img style="width: 42px; height: 42px;" class="avatar" src="<%= FriendImg%>" alt="alt"/>

                    </div>
                    <div class="friendID" id="friendID" style="display: none;"><%=FriendId%></div>
                    <div class="FriendName" id="FriendName" ><%=FriendName%></div>
                </div>
                <div class="chat-messages" id="chat-messages">
                    <%
                        if (box != null) {
                            Hashtable<Integer, String> boxChat = box.getList();
                            Hashtable<Integer, String> boxChatID = box.getListChatID();
                            Hashtable<Integer, Boolean> boxChatWho = box.getListWho();
                            for (int i = 0; i < boxChat.size(); i++) {
                                String ChatID = boxChatID.get(i);
                                String mess = boxChat.get(i);
                                Boolean who = boxChatWho.get(i);
                    %><div><q style="display: none;"><%=ChatID%></q><%
                        if (who) {
                        %>
                        <div class="user">

                            <%=mess%>
                        </div><%
                        } else {
                        %><div class="user friend"><%=mess%></div><%
                            }
                        %></div><%
                                }
                            }%>
                    <!-- Tin nh?n trong box chat s? ???c ?? vào ?ây -->
                </div>
                <div class="chat-input-container">
                    <input type="text" class="chat-input" id="chat-input" placeholder="Type a message" >
                    <button class="send-button" id="send-button" ><i class="fas fa-paper-plane" ></i></button>
                </div>
            </div>
        </div>
        <script></script>
        <!-------------------------------------------------------------------->
        <script src="script.js">
        ocument.addEventListener('DOMContentLoaded', function () {
            // L?y t?t c? các ph?n t? <img> trên trang
            var images = document.getElementsByTagName('img');

            // Duy?t qua t?ng ph?n t? <img> và ki?m tra src
            for (var i = 0; i < images.length; i++) {
                var img = images[i];

                // Ki?m tra n?u src c?a hình ?nh là r?ng
                if (img.src === '') {
                    img.style.display = 'none'; // ?n hình ?nh
                }
            }
        });
        </script>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>

</html>
