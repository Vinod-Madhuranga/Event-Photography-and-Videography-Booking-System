<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(request.getParameter("error") != null) { %>
<div class="alert alert-danger">
    <%= request.getParameter("error") %>
</div>
<% } %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Login</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles -->
    <link href="css/main.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>

<body>

<div class="background"></div>
<div class="container">
    <!--<div class="content">
        <h2 class="logo"><i class="fas fa-key"></i>Brand</h2>
        <div class="text-sci">
            <h2><span>Create an Account</span></h2>
        </div>
    </div>-->
    <div class="logreg-box">
        <div class="form-container active">
            <div class="form-box">
                <form class="user" style="margin-top: 2rem;" action="LoginServlet" method="post">
                    <h2>Welcome Back!</h2>
                    <div class="input-box">
                        <input type="text" id="email email-input" name="email" required placeholder=" ">
                        <label id="email-label" for="email">Email</label>
                        <i class="icon fas fa-envelope"></i>
                    </div>
                    <div class="input-box">
                        <input type="password" id="password password-input" minlength="" name="password" required
                               placeholder=" ">
                        <label id="password-label" for="password">Password</label>
                        <i class="icon fas fa-lock"></i>
                    </div>
                    <button type="submit" class="btn">
                        Login
                    </button>
                    <div class="login-register">
                        <p>Need an Account? <a href="register.jsp">Create an Account!</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Custom scripts for all pages-->
<script src="js/main.js"></script>

</body>

</html>
