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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Authen/signup.css">
    </head>
    <body>
        <section class="login-block" style="">

            <div class="col-xl-5 col-lg-6 col-md-7 col-sm-9 col-11  login-sec container" >
                <h2 class="text-center">Sign up now</h2>
                <form action="/SocialNetworkIRCNV/Verify" method="get" class="login-form" onsubmit="return validateForm()" style="overflow-x:hidden; overflow-y:auto;">
                    <div class="form-group">
                        <label>User Name</label>
                        <input name="user" id="username" value="${user}" type="text" class="form-control" placeholder="Enter user name" onblur="validateUsername()">
                        <small id="usernameError" style="color: red;"></small>
                    </div>
                    <div class="form-group">
                        <label >Password</label>
                        <input name="pass" value="${pass}" type="password" class="form-control" placeholder="Enter password"id="pass" onsubmit="return validateForm()" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                               title="Must contain at least one number and one uppercase and lowercase letter, 
                               and at least 8 or more characters" required> 
                        <small id="usernameError" style="color: red;"></small>
                    </div>
                    <div class="form-group">

                        <input type="password" class="form-control" placeholder="Repeat Password"id="repeat" onsubmit="return validateForm()"
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                               title="Password are not same" required>
                        <small id="usernameError" style="color: red;"></small>
                    </div>
                    <div class="form-group">
                        <label >Full Name</label>
                        <input name="name" value="${name}" type="text" class="form-control" placeholder="Enter your full name" required>
                    </div>
                    <div class="form-group">
                        <label >Mail</label>
                        <input name="mail" value="${mail}" type="email" class="form-control" placeholder="Enter your mail" required>
                    </div>
                    <div class="form-group">
                        <label >Date of birth</label>
                        <input name="dob" value="${dbo}" type="date" class="form-control" required>
                    </div>

                    <div class="gender">
                        <div> 
                            <label class=""><b>Gender</b></label>
                        </div>
                        <div> 
                            <input type="radio" id="Male" name="gender" value="Male" >Male
                        </div>
                        <div> 
                            <input type="radio" id="Female" name="gender" value="Female"> Female 
                        </div>
                    </div>
                    <div class="form-check">
                        <input type="submit" class="btn btn-login float-right" value="Submit">
                    </div>
                    <div>
                        <a href="login.jsp"> </a>
                    </div>
                    <p id="mess" style="color: red">${mess}</p>
                </form>
                <div>
                    <a href="${pageContext.request.contextPath}/Authen/forgotpass.jsp">Forgot password</a> <br>
                    <a href="${pageContext.request.contextPath}/Authen/login.jsp">You already have account?</a>
                </div>
                <script>
                    function validateForm() {
                        var username = document.getElementById("username").value;
                        var pass = document.getElementById("pass").value;
                        var repeat = document.getElementById("repeat").value;
                        var regex = /^[a-zA-Z0-9]+$/;
                        var errorElement = document.getElementById("usernameError");

                        if (!regex.test(username)) {
                            errorElement.textContent = "Invalid username!";
                            return false;
                        } else {
                            errorElement.textContent = "";
                            return true;
                        }
                        if (!regex.test(pass)) {
                            errorElement.textContent = "Invalid Password!";
                            return false;
                        } else {
                            errorElement.textContent = "";
                            return true;
                        }
                        if (!regex.test(repeat)) {
                            errorElement.textContent = "Invalid Password Repeat!";
                            return false;
                        } else {
                            errorElement.textContent = "";
                            return true;
                        }
                    }

                </script>
            </div>



        </section>
    </body>
</html>
