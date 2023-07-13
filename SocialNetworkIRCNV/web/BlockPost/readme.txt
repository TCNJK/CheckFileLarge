 <%
                    ArrayList<Comment> cmt = (ArrayList<Comment>) request.getAttribute("ListCmt");
                    cmt.toString();
                    System.out.println("length: " + cmt.size() + cmt.toString());
                    for (int i = 0; i < cmt.size(); i++) {%>
                <div class="comment" style="width: 100%">
                    <%try {%>
                    <jsp:include page="BlockComment.jsp">
                        <jsp:param name="img_user" value="<%=cmt.get(i).getImgUser()%>" />

                        <jsp:param name="n_user_cmt" value="<%= cmt.get(i).getNameUser()%>" />

                        <jsp:param name="time_cmt" value="<%=cmt.get(i).getTimeCmt()%>" />

                        <jsp:param name="content_cmt" value="<%=cmt.get(i).getContentCmt()%>" />
                        <jsp:param name="img_cmt" value="<%=cmt.get(i).getImgCmt()%>" />
                        <jsp:param name="num_like_cmt" value="<%=cmt.get(i).getNumInter()%>" />
                        
                </jsp:include>
                <%} catch (Exception e) {
                             
                         }%>
                </div>
                <%}%>
                    