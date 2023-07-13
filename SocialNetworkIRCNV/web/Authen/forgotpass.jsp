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
                        <h2 class="text-center">Forgot password</h2>
                        <form id="myForm" action="/SocialNetworkIRCNV/ForgotPass" method="get" class="login-form">
                            <div class="form-group">
                                <label class="text-uppercase">Mail</label>
                                <input name="mail" type="text" class="form-control" placeholder="" value="${mail}">
                            </div>   
                             <div class="form-group">
                                <label class="text-uppercase">Account </label>
                                <input name="user" type="text" class="form-control" placeholder="" value="${user}">
                            </div>   
                            <input class="btn btn-login float-right" type="submit" value="submit">
                            <p style="color: red">${status}</p>
                            <div>
                                <a href="login.jsp"> </a>
                            </div>
                        </form>
                        <div style="margin-top: 10px">
                            <a href="${pageContext.request.contextPath}/Authen/login.jsp">Already have account?</a> <br>
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
            function myFunction() {
                document.getElementById("myForm").submit();
            }
        </script> 
    </body>
</html>
