<%-- 
    Document   : login.jsp
    Created on : 16 thg 5, 2023, 07:38:52
    Author     : 84384
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Authen/login.css">
    </head>
    <body>
        <section class="login-block">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 login-sec">
                        <h2 class="text-center">Hello user ${user}</h2>
                        <form id="myForm" action="/SocialNetworkIRCNV/ResetPass" method="get" class="login-form">
                            <input style="display: none" name="user" value="${user}">
                            <div class="form-group">
                                <label >Password</label>
                                <input name="pass" value="${pass}" type="password" class="form-control" placeholder="Enter password"id="pass" 
                                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                                       title="Must contain at least one number and one uppercase and lowercase letter, 
                                       and at least 8 or more characters" required> 
                            </div>
                            <div class="form-group">

                                <input type="password" class="form-control" placeholder="Repeat Password"id="repeat"
                                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                                       title="Password are not same" required>
                            </div>  
                            <input class="btn btn-login float-right" type="submit" value="submit">
                            <p style="color: red">${status}</p>
                            <div>
                                <a href="login.jsp"> </a>
                            </div>
                        </form>
                        <div style="margin-top: 10px">
                            <a href="${pageContext.request.contextPath}/Authen/forgotpass.jsp">Forgot password</a> <br>
                            <a href="${pageContext.request.contextPath}/Authen/signup.jsp">You dont have account?</a>
                        </div>
                        <p style="text-align: center; color: red">${status}</p>
                    </div>
                    <div class="col-md-8 banner-sec">
                        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                            </ol>
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="https://static.pexels.com/photos/33972/pexels-photo.jpg" alt="First slide">
                                    <div class="carousel-caption d-none d-md-block">
                                        <div class="banner-text">
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="https://images.pexels.com/photos/7097/people-coffee-tea-meeting.jpg" alt="First slide">
                                    <div class="carousel-caption d-none d-md-block">
                                        <div class="banner-text">
                                            <h2>This is Heaven</h2>
                                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img class="d-block img-fluid" src="https://images.pexels.com/photos/872957/pexels-photo-872957.jpeg" alt="First slide">
                                    <div class="carousel-caption d-none d-md-block">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>

            var pass = document.getElementById("pass");


            var repeat = document.getElementById("repeat");
            var user = document.getElementById("user");
            var mail = document.getElementById("mail");

            myInput.onfocus = function () {
                document.getElementById("message").style.display = "block";
            }
            ;

            repeat.onblur = function () {
                if (repeat.value !== pass.value)
                    document.getElementById("id").innerHTML = "Repeat pass didn't match pass";
            }
            ;

            myInput.onblur = function () {
                document.getElementById("message").style.display = "none";
            }
            ;


            function validateForm() {

                if (pass.value !== repeat.value) {
                    document.getElementById("mess").innerHTML = "Repeat pass didn't match pass";
                    return false;
                }
                return true;
            }
            // When the user starts to type something inside the password field



        </script>
    </body>
</html>
