<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Notification Form</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
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


            }
        </style>
    </head>
    <body onclick="handleClick(event)">
        <div class="container">
            <h1>Notification Form</h1>
            <div class="notification-icon" onclick="toggleNotificationDropdown()">
                <i class="fa fa-bell shake-icon"></i>
                <div class="notification-badge">3</div>
            </div>
            <div class="notification-dropdown" id="notificationDropdown">
                <!--      <div class="notification-item">
                        <img class="profile-pic" src="https://via.placeholder.com/40" alt="Profile Picture">
                        <span class="username">John Doe</span>
                        <div class="message">John Doe sent you a friend request.</div>
                        <div class="notification-actions">
                          <button class="btn btn-success accept-btn">Accept</button>
                          <button class="btn btn-danger decline-btn">Decline</button>
                        </div>
                      </div>-->
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
                
            </div>
        </div>

        <script>
                function toggleNotificationDropdown() {
                    var dropdown = document.getElementById('notificationDropdown');
                    dropdown.classList.toggle('show');
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
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </body>
</html>