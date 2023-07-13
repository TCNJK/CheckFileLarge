<div class="container col-md-12" style="max-width: 1850px; width: 100%; min-width: 1045px; padding: 0;">

            <div class="middle-panel col-md-6" style="   ">


                <div class = "block-comment col-md-6">
                    <div>
                        <div>
                            <div class="comment" style="width: 100%;">
                                <main>
                                    <section class="comment-module" style=" max-height: 700px; overflow-y: auto;">
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
                                        <ul id="#Post">
                                            <li id="CID00000001">
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
                                                <%
                                                    String id = (String) session.getAttribute("id");
                                                    CommentChild commentChild = new dao.CommentDAO(cnn).getCommentChildByChildID("ILD00000003");
                                                    User userCommentChild = new dao.UserDAO(cnn).getUserByID(commentChild.getUserID());
                                                    InterFaceObject interFaceObject = new dao.InterFaceObjectDAO(cnn).getInterFaceObjectByID(commentChild.getChilID(), id);

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
                                                                        <div class="comment-likes-up" onclick="like('<%=commentChild.getChilID()%>', '<%=interFaceObject.getInterFaceID()%>')">
                                                                            <%=interFaceObject.getInterFaceDiv()%>

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
                                                <ul id="#ChildID">
                                                    <li>
                                                        <div class="comment">
                                                            <div class="comment-img">
                                                                <img src="#AVATARUSER" alt="">
                                                            </div>
                                                            <div class="comment-content">
                                                                <div class="comment-details">
                                                                    <h4 class="comment-name">#USERNAME</h4>
                                                                    <span class="comment-log">#time</span>
                                                                </div>
                                                                <div class="comment-desc">
                                                                    <p>#contentcomment<br>
                                                                        <img src="#imgcomment">
                                                                    </p>
                                                                </div>
                                                                <div class="comment-data">
                                                                    <div class="comment-likes">
                                                                        <div class="comment-likes-up" onclick="like('ChildID', '#interFaceObject.getInterFaceID()')" id="ChildID">
                                                                            <i class="fa-solid fa-thumbs-up"></i>

                                                                        </div>
                                                                        <span>5</span>
                                                                    </div>
                                                                    <div class="comment-reply" onclick="reply('#cmtID', '#username')">
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

                                <div class="write-comment" style="background: white">
                                    <div class ="post-input-container" id="post-input-container">
                                        <div style="display: inline"> 
                                            <textarea style="width: 80%; align-items: start" id="NewPostTextarea" rows ="3" placeholder="What's on your mind?"></textarea>   
                                            <div id="button-load-comment" style="width: 10%" onclick="loadComment('<%=commentChild.getCmtID()%>')"><a href=""><i style="font-size:27px;color:#00abfd" class="fa-solid fa-paper-plane"></i></a></div> 
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
            
    
        