

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
    <head>

        <title>JSP Page</title>
        <style>
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

            nav .nav-left  img{
                width:40px;
                height: 40px;
                border-radius: 50%;
            }

            nav .nav-left  input{
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
            /* CSS for the search container */
            .search-container {
                position: relative;
                width: 300px;
                margin: 20px auto;
            }
            /* CSS for the suggestions container */
            .suggestions-container {
                position: absolute;
                width: 100%;
                max-height: 200px;
                overflow-y: auto;
                background-color: #fff;
                border: 1px solid #ccc;
                border-top: none;
                border-radius: 0 0 4px 4px;
                z-index: 1;
            }

            /* CSS for the suggestion items */
            .suggestion-item {
                display: flex;
                align-items: center;
                padding: 10px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .suggestion-item:hover,
            .suggestion-item.active {
                background-color: #f2f2f2;
            }

            .suggestion-item img {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .suggestion-item span {
                font-size: 14px;
                font-weight: bold;
            }

            .suggestion-item .mutual-friends {
                margin-left: auto;
                font-size: 12px;
                color: #999;
            }



            .notification-icon {
                position: relative;
                cursor: pointer;
            }

            .notification-badge {
                position: absolute;
                top: -8px;
                right: 200px;
                background-color: red;
                color: white;
                width: 18px;
                height: 18px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 12px;
            }

            .notification-dropdown {
                position: absolute;
                top: 30px;
                right: 0;
                width: 470px;
                max-height: 300px;
                overflow-y: auto;
                background-color: white;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
                padding: 10px;
                display: none;
            }

            .notification-item {
                padding: 5px;
                border-bottom: 1px solid #ccc;
            }

            .notification-item:last-child {
                border-bottom: none;
            }

            .notification-item .profile-pic {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .notification-item .username {
                font-weight: bold;
            }

            .notification-item .message {
                margin-top: 5px;
                font-size: 14px;
            }

            .notification-dropdown.show {
                display: block;
            }
            * {
                box-sizing: border-box;
            }
            .friend-list {
                font-family: 'Montserrat', sans-serif;
                .friend-box {
                    position: relative;
                    display: inline-block;
                    width: 170px;
                    height: 140px;
                    background-color: #eee;
                    margin: 20px;
                    border-radius: 10px;

                }
                .friend-profile {
                    position: absolute;
                    left: 50%;
                    transform: translateX(-50%);
                    top: -20px;
                    border-radius: 50%;
                    height: 70px;
                    width: 70px;
                    background-size: cover;
                    background-position: center;
                    border: 3px rgba(255, 255, 255, 0.7) solid;
                    box-shadow: 0px 0px 15px #aaa;
                }

                .name-box {
                    text-align: center;
                    position: absolute;
                    top: 55px;
                    left: 50%;
                    transform: translateX(-50%);
                    width: 100%;
                    color: #4F7091;
                    font-size: 18px;
                    /*// font-weight: bold;*/
                }
                .user-name-box {
                    position: absolute;
                    top: 80px;
                    left: 50%;
                    transform: translateX(-50%);
                    width: 100%;
                    text-align: center;
                    font-size: 12px;
                }

                .level-indicator {
                    background-color: #00a5db;
                    color: #fff;
                    display: inline-block;
                    padding: 5px 10px;
                    border-radius: 10px;
                    position: absolute;
                    bottom: 10px;
                    left: 50%;
                    transform: translateX(-50%);
                    font-size: 12px;
                }


            }


            .friend-requests {
                font-family: 'Montserrat', sans-serif;
                text-align: center;
                .friend-box {
                    position: relative;
                    display: inline-block;
                    width: 370px;
                    height: 140px;
                    background-color: #eee;
                    margin: 20px;
                    border-radius: 10px;

                }
                .friend-profile {
                    position: absolute;
                    left: 10px;
                    /*                // transform: translateX(-50%);*/
                    top: 10px;
                    border-radius: 50%;
                    height: 70px;
                    width: 70px;
                    background-size: cover;
                    background-position: center;
                    border: 3px rgba(255, 255, 255, 0.7) solid;
                    box-shadow: 0px 0px 15px #aaa;
                }

                .name-box {
                    text-align: left;
                    position: absolute;
                    top: 20px;
                    left: 90px;
                    /*// transform: translateX(-50%);*/
                    width: 300px;
                    color: #4F7091;
                    font-size: 18px;
                    /*// font-weight: bold;*/
                }
                .user-name-box {
                    position: absolute;
                    top: 50px;
                    left: 90px;
                    width: 270px;
                    text-align: left;
                    font-size: 12px;
                    line-height: 16px;
                }
                .request-btn-row {
                    position: absolute;
                    left: 10px;
                    width: calc(100% - 20px);
                    bottom: 10px;
                    text-align: center;

                    .friend-request {
                        width: 35%;
                        margin: 5px 5%;
                        border-radius: 5px;
                        border: 2px solid transparent;
                        padding: 5px;
                        cursor: pointer;
                    }
                    .decline-request {
                        background-color: #FF6666;
                        color: #fff;
                        &:hover {
                            background-color: #993333;
                        }
                    }
                    .accept-request {
                        background-color: #41c764;
                        color: #fff;
                        &:hover {
                            background-color: #419764;
                        }
                    }

                    .fr-request-pending {
                        position: relative;
                        top: -10px;
                        color: #17406f;
                        font-weight: bold;
                    }
                }

                .request-btn-row.disappear {
                    display: none;
                }
            </style>
        </head>
        <body>
            <div id="offset-note" style="display: none"  >1</div>
                <nav style="background-color: #70d8ff;
                min-width: 1045px;">
                <div class="nav-left">
                    <a href="/SocialNetworkIRCNV/HomePage/HomePage.jsp">
                        <img src="/SocialNetworkIRCNV/data/img/logo.jpg" alt="Logo">
                    </a>

                    <div class="search-container">
                        <input id="searchInput" type="text" class="search-input" placeholder="Search...">
                        <div class="suggestions-container" id="searchResults"></div>
                    </div>

                </div>
                <jsp:include page = "/GetInfor"></jsp:include>


                    <div class="nav-right">
                        <span class="profile">
                            <a href="${pageContext.request.contextPath}/PersonalPage/ProfileInfo.jsp    ">
                            <img src="@@user" alt="alt" style="width: 100%;"/>
                        </a>
                    </span>



                    <a href="../BoxChat/GetFriendAndBoxChat">
                        <i class="fas fa-comments"></i>
                    </a>

                    <a id="note-container" class="container" onclick="handleClick(event)" style="padding: 0">
                            <div class="notification-icon" onclick="toggleNotificationDropdown()" >
                                <i class="fa fa-bell shake-icon" style = "font-size : 20px;"></i>

                        </div>
                        <div class="notification-dropdown" id="notificationDropdown">

                            <div class="friend-requests">
                                <!-- Existing friend request boxes -->
                                <div class="friend-box">
                                    <div class="friend-profile" style="background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN7wdqBsoj0Wnr9900iQM4pWkC1nJ322ldLA&usqp=CAU);"></div>
                                    <div class="name-box">Nguyen Ho Ngoc An 1234 </div>
                                    <div class="user-name-box">Nguyen Ho Ngoc An sent you a friend request.</div>
                                    <div class="request-btn-row" data-username="silvergoose115">
                                        <form class="friend-request-form" data-username="silvergoose115">
                                            <button class="friend-request accept-request" data-username="silvergoose115">Accept</button>
                                            <button class="friend-request decline-request" data-username="silvergoose115">Decline</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="friend-requests" id="#NoteID#" onclick="otherProfile('UID00000003')">
                                <!-- Existing friend request boxes -->

                                <div class="friend-box" id="NoteID">
                                    <div class="friend-profile" style="#i">#img#</div>
                                    <div class="name-box">#Name User# </div>
                                    <div class="user-name-box">#Time# <br> #Name User# send you a friend request.</div>
                                    <div class="request-btn-row" data-username="silvergoose115">

                                    </div>
                                </div>
                            </div>
                          
                        </div>
                    </a>
                    <form action="/SocialNetworkIRCNV/CheckLogin" method="post">
                        <button type="submit" style="background: none;
                                border: none">
                                    <a href="#">
                                        <i class="fa-solid fa-right-from-bracket"></i>
                                    </a>
                                </button>
                        </form>

                        <a href="#">
                            <i class="fas fa-ellipsis-h"></i>
                        </a>

                    </div>

                </nav>
                <script src="/SocialNetworkIRCNV/js/search.js"></script>
                <script src="/SocialNetworkIRCNV/js/friend.js" ></script>
                <script src="/SocialNetworkIRCNV/js/note.js" ></script>
                <script src="/SocialNetworkIRCNV/js/openOtherProfile.js" ></script>
                <script>

                                    function toggleNotificationDropdown() {
                                        noteload('load');
                                        var dropdown = document.getElementById('notificationDropdown');
                                        dropdown.classList.toggle('show');

                                        var icon = document.querySelector('.notification-icon');
                                        var iconRect = icon.getBoundingClientRect();

                                        var dropdownHeight = dropdown.offsetHeight;
                                        dropdown.style.top = iconRect.bottom + 'px';
                                        dropdown.style.right = (window.innerWidth - iconRect.right) + 'px';
                                    }

                                    function handleClick(event) {

                                        var $target = $(event.target);

                                        // Check if the click event occurred on a friend request button
                                        if ($target.hasClass('friend-request')) {
                                            event.preventDefault();
                                            var $form = $target.closest('.friend-request-form');
                                            var username = $form.attr('data-username');
                                            var type = $target.hasClass('accept-request');

                                            // Process the friend request
                                            if (type) {
                                                var message = $('<div>', {'class': 'fr-request-pending', text: 'Friend request accepted.'});
                                            } else {
                                                var message = $('<div>', {'class': 'fr-request-pending', text: 'Friend request declined.'});
                                            }

                                            $form.replaceWith(message);
                                        }
                                    }
                </script>

            </body>
        </html>