<%-- 
    Document   : FriendList
    Created on : Jun 8, 2023, 8:54:03?PM
    Author     : LENOVO
--%>
<%@ page errorPage="../error/errorPage.jsp" %>  

<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script> 
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        

    </head>
    <style>
        body{
            margin-top:20px;
            background:#cdf1ff;
        }
        .avatar.avatar-xl {
            width: 5rem;
            height: 5rem;
        }
        .avatar {
            width: 2rem;
            height: 2rem;
            line-height: 2rem;
            border-radius: 50%;
            display: inline-block;
            background: #ced4da no-repeat center/cover;
            position: relative;
            text-align: center;
            color: #868e96;
            font-weight: 600;
            vertical-align: bottom;
        }
        .card {
            background-color: #fff;
            border: 0 solid #eee;
            border-radius: 0;
        }
        .card {
            margin-bottom: 30px;
            -webkit-box-shadow: 2px 2px 2px rgba(0,0,0,0.1), -1px 0 2px rgba(0,0,0,0.05);
            box-shadow: 2px 2px 2px rgba(0,0,0,0.1), -1px 0 2px rgba(0,0,0,0.05);
        }
        .card-body {
            padding: 1.25rem;
        }
        .tile-link {
            position: absolute;
            cursor: pointer;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
            z-index: 30;
        }
        .card-body .align-items-center{
            display: flex;
            align-items:flex-start;
        }
        .card-body .align-items-center .avatar{
            width:60px;
            height:60px;
            margin-right:30px;
            border-radius: 7px;
            object-fit: cover;
        }
        .card-body .align-items-center i{
            margin-top:20px;
            margin-right:10px;
            font-size: 25px;
            margin-left:20px;
        }
    </style>
    <body>
        <header>
            <%@include file="../block/header.jsp" %>
        </header>
        <p id="offset-friendList" style="display: none">1</p>
        <div class="container-friendList" >
            <div class="row" id="container-friendList">
                
            </div>
        </div>
        <button id="load-more-button" onclick="loadFriendList()" >
            load more
        </button>
        <script>

            document.addEventListener('DOMContentLoaded', function () {
                var offset = document.getElementById('offset-friendList');
                var conntain = document.getElementById('container-friendList');
                var btnloadmore = document.getElementById('load-more-button');
                $.ajax({
                    url: "/SocialNetworkIRCNV/LoadListFriend",
                    type: "POST",
                    data: {offset:'1'},
                    success: function (data) {
                        if (data.trim() === "null") {
                            btnloadmore.setAttribute('style', 'display: none');
                             conntain.innerHTML +="That all";
                        } else {
                            var currentOffset = parseInt(offset.innerHTML);
                            offset.innerHTML = currentOffset + 1;
                            conntain.innerHTML =data;
                        }

//            var currentOffset = parseInt(offsett.innerHTML);
//            offsett.innerHTML = currentOffset + 1;
//            post.innerHTML = currentOffset+1;
                    },
                    error: function (xhr) {
                        console.log("?ã x?y ra l?i: ");
                    }
                });
            });
            function loadFriendList() {
                var offset = document.getElementById('offset-friendList');
                var conntain = document.getElementById('container-friendList');
                var btnloadmore = document.getElementById('load-more-button');
                $.ajax({
                    url: "/SocialNetworkIRCNV/LoadListFriend",
                    type: "POST",
                    data: {offset: offset.innerHTML},
                    success: function (data) {
                        if (data.trim() === "null") {
                            btnloadmore.setAttribute('style', 'display: none');
                             conntain.innerHTML += "That all";
                        } else {
                            var currentOffset = parseInt(offset.innerHTML);
                            offset.innerHTML = currentOffset + 1;
                            conntain.innerHTML += data;
                        }

//            var currentOffset = parseInt(offsett.innerHTML);
//            offsett.innerHTML = currentOffset + 1;
//            post.innerHTML = currentOffset+1;
                    },
                    error: function (xhr) {
                        console.log("?ã x?y ra l?i: ");
                    }
                });
            }
        </script>
    </body>
</html>
