<%-- 
    Document   : SmallBoxChat
    Created on : Jun 5, 2023, 8:24:48 AM
    Author     : TCNJK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .chat-container {
                position: fixed;
                bottom: 0;
                right: 0;
                margin-bottom: 50px;
                margin-right: 50px;
                width: 328px;
                height: 455px;
            }

            .chat-box {
                width: 100%;
                height: 100%;
                border: 1px solid #ccc;
                padding: 10px;
                display: flex;
                flex-direction: column;
            }

            .chat-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                /* Thêm dòng này để căn giữa các phần tử trong chat-header */
                margin-bottom: 10px;
            }

            .avatar {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                margin-right: 10px;
                background-image: url('img/friend/avt.png');
                background-size: cover;
            }

            .friend-name {
                font-weight: bold;
            }

            .chat-messages {
                flex-grow: 1;
                overflow-y: scroll;
            }

            .chat-input-container {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            .chat-input {
                flex-grow: 1;
                margin-right: 10px;
            }

            .chat-buttons {
                display: flex;
            }

            .chat-button,
            .like-button {
                padding: 6px 12px;
                background-color: #1f0999;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            .user {
                background-color: #2e17ff;
                color: #fff;
                padding: 8px;
                border-radius: 10px;
                margin-bottom: 5px;
                align-self: flex-end;
                max-width: 195px;
                width: fit-content;
                padding-right: 10px;
                margin-left: auto;
                word-wrap: break-word;
            }
            .friend {
                align-self: flex-start;
                background-color: #f0f0f0;
                color: black;
                margin-left: 10px;
                margin-right: auto;
            }
            /* Thêm CSS cho các biểu tượng */
            .chat-header-icons {
                display: flex;
                align-items: center;
            }

            .exit-icon,
            .minimize-icon {
                margin-left: 10px;
                cursor: pointer;
            }

            .minimize-icon {
                margin-bottom: 50px;
            }
        </style>
    </head>

    <body>
        <div class="chat-container">
            <div class="chat-box">
                <div class="chat-header">
                    <div class="avatar"></div>
                    <div class="friend-name">Ai đó</div>
                    <div class="icons">
                        <span class="exit-icon">X</span>
                        <span class="minimize-icon">--</span>
                    </div>
                </div>
                <div class="chat-messages">
                    <!-- Tin nhắn trong box chat sẽ được đổ vào đây -->
                </div>
                <div class="chat-input-container">
                    <input type="text" class="chat-input" placeholder="Nhập tin nhắn">
                    <div class="chat-buttons">
                        <button class="chat-button"><i class="fas fa-camera"></i></button>
                        <button class="like-button"><i class="fas fa-thumbs-up"></i></button>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
        <script>
            // Xử lý sự kiện khi nhấn nút Gửi hình ảnh
            document.querySelector('.chat-button').addEventListener('click', function () {
                // TODO: Xử lý gửi hình ảnh
                console.log('Gửi hình ảnh');
            });
            // Xử lý sự kiện khi nhấn nút Like
            document.querySelector('.like-button').addEventListener('click', function () {
                // TODO: Xử lý like
                var chatMessages = document.querySelector('.chat-messages');
                chatMessages.innerHTML += '<div class="user"><i class="fas fa-thumbs-up"></i></div>';
                chatMessages.scrollTop = chatMessages.scrollHeight;
                console.log('Like');
            });

            // Xử lý sự kiện khi nhấn phím Enter trên input
            document.querySelector('.chat-input').addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault(); // Ngăn chặn hành vi mặc định của phím Enter

                    var message = event.target.value;
                    if (message.trim() !== '') {
                        var chatMessages = document.querySelector('.chat-messages');
                        chatMessages.innerHTML += '<div class="user">' + message + '</div>';
                        chatMessages.innerHTML += '<div class="user friend">' + message + '</div>';
                        chatMessages.scrollTop = chatMessages.scrollHeight;
                        event.target.value = ''; // Xóa nội dung trong input sau khi in ra
                    }
                }
            });

            // Xử lý sự kiện khi nhấn vào biểu tượng "Exit"
            document.querySelector('.exit-icon').addEventListener('click', function () {
                // Xóa box chat
                document.querySelector('.chat-container').remove();
            });

            // Xử lý sự kiện khi nhấn vào biểu tượng "Minimize"
            document.querySelector('.minimize-icon').addEventListener('click', function () {
                // Ẩn box chat
                var chatBox = document.querySelector('.chat-box');
                chatBox.style.display = 'none';

                // Tạo minimizeAvatar
                var avatar = document.querySelector('.avatar');
                var minimizeAvatar = document.createElement('div');
                minimizeAvatar.classList.add('minimize-avatar');
                minimizeAvatar.style.backgroundImage = avatar.style.backgroundImage;
                minimizeAvatar.style.width = avatar.style.width;
                minimizeAvatar.style.height = avatar.style.height;
                minimizeAvatar.style.borderRadius = avatar.style.borderRadius;
                minimizeAvatar.style.position = 'fixed';
                minimizeAvatar.style.bottom = '50px';
                minimizeAvatar.style.right = '50px';
                minimizeAvatar.style.cursor = 'pointer';
                minimizeAvatar.addEventListener('click', function () {
                    // Hiển thị lại box chat khi nhấp vào minimizeAvatar
                    chatBox.style.display = 'flex';
                    minimizeAvatar.remove();
                });

                // Thêm minimizeAvatar vào body
                document.body.appendChild(minimizeAvatar);
            });



        </script>
    </body>
</html>