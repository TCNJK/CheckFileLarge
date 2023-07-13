<%-- 
    Document   : index
    Created on : 19 thg 5, 2023, 10:06:51
    Author     : van12
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Your Profile</title>
        <meta charset="UTF-8">
        <link rel="icon" href="/SocialNetworkIRCNV/data/img/logo.jpg" type="image/i-con">
        <link rel="shortcut icon" href="./images/logo.png" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
              integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <button onclick="askUpdateComment('CID00000079', 'name', 'imguser', 'image', 'content')">load</button>
        <div class="modal" id = "changeinfo" tabindex="-1" role="dialog">

            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Change Information</h5>

                    </div>
                    <div class="modal-body">
                        <ul><li id="comment-CID00000079"><div class="comment" id="CID00000079">        
                                    <div class="comment-img" id="modal-user-image">
                                        <img src="/SocialNetworkIRCNV/data/user/UID00000001/avatar/Cosmic_Flight_Anivia_Wallpaper_LOL_1200x675-720x480.jpg" alt="">
                                    </div>
                                    <div class="comment-content">
                                        <div class="comment-details">
                                            <a class="suggestion-href" href="/SocialNetworkIRCNV/PersonalPage/ProfileInfo.jsp" style="display: inline">
                                                <h4 class="comment-name" id="modal-name">Nguyen Anh Viet</h4>
                                            </a>
                                            
                                        </div>
                                        <div class="comment-desc">
                                            <p>Mình là best anivia thông thạo 7<br>
                                                <img src="/SocialNetworkIRCNV/data/post/PID00000130/CID00000079/Cosmic_Flight_Anivia_Wallpaper_LOL_1200x675-720x480.jpg">
                                            </p>
                                        </div>
                                    </div>

                                </div>
                            </li></ul>
                    </div>

                    <div class="modal-footer">

                    </div>

                </div>
            </div>             

            <script>
                document.getElementById('fileInput4').addEventListener('change', function (event) {
                    var file = event.target.files[0];
                    // T?o ??i t??ng FileReader ?? ??c t?p tin
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var previewImage = document.getElementById('previewImage4');
                        previewImage.src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                });

            </script>
        </div>

        <script>
            function askUpdateComment(id, name, imguser, image, content) {
                var Mname = document.getElementById()
                $('#changeinfo').modal('show');
            }
        </script>
    </body>
</html>
