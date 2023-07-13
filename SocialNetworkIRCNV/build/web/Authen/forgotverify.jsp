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
        <section class="login-block" >

            <div class="col-xl-5 col-lg-6 col-md-7 col-sm-9 col-11  login-sec container">
                <h2 class="text-center">Wellcome User ${name} with account ${user}</h2>
                <h4>Check your mail ${mail}</h4>
                
                <form action="/SocialNetworkIRCNV/ForgotPass" method="post" class="login-form" onsubmit="return validateForm()">
                    <input name="mail" value="${mail}" style="display: none">
                     <input name="user" value="${user}" style="display: none">
                    <div class="form-group">
                        <label class="text-uppercase">Your Code: </label>
                        <input class="form-control" type="text" name="code" placeholder="Enter your code">
                    </div>
                    <div class="form-group">
                        <input class="btn btn-login float-right" type="submit" value="Confirm">
                    </div>
                </form>
                     <p style="color: red">${status}</p>
                <div>
                    <a href="${pageContext.request.contextPath}/Authen/forgotpass.jsp">Forgot password</a> <br>
                    <a href="${pageContext.request.contextPath}/Authen/login.jsp">You already have account?</a>
                </div>


        </section>
    </body>
</html>
