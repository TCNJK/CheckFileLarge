<%-- 
    Document   : FriendList
    Created on : Jun 8, 2023, 8:54:03 PM
    Author     : LENOVO
--%>


<!DOCTYPE html>
<html>
    <head>
              <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap-5.0.2-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="bootstrap-5.0.2-dist/js/bootstrap.bundle.min.js"></script> 
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/24c45437f2.js" crossorigin="anonymous"></script>
        <jsp:useBean id="a" class="dao.UserDAO" scope="request" />
        
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
            <%@include file="block/header.jsp" %>
        </header>
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div><div class="col-md-6 col-xl-4">                       
                    <div class="card">
                        <div class="card-body">
                            <div class="media align-items-center">
                                <img src = "https://bootdey.com/img/Content/avatar/avatar6.png" class="avatar avatar-xl mr-3">
                                <div class="media-body overflow-hidden">
                                    <h5 class="card-text mb-0">Nielsen Cobb</h5>
                                    <p class="card-text text-uppercase text-muted">Memora</p>
                                </div>
                                <i class="icon fa-regular fa-message"></i>
                                <i class="fa-solid fa-user-minus"></i>  
                                
                            </div><a href="#" class="tile-link"></a>
                            
                        </div>
                    </div>
                </div>                
                
                
            </div>
        </div>
    </body>
</html>
