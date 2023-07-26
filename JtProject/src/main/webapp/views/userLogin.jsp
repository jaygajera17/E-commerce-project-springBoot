<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <script src="https://code.jquery.com/jquery-3.7.0.slim.min.js" integrity="sha256-tG5mcZUtJsZvyKAxYLVXrmjKBVLd6VpVccqz/r4ypFE=" crossorigin="anonymous"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Autour+One&family=Cabin:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="style.css">
        <title>Welcome</title>

        <script type="text/javascript">
            $(document).ready(function () {
                let isLogin = false;

                let loginPanel = $("#login");
                let registerPanel = $("#register");

                // Toggle between login and register
                $(".link-control").on("click", toggleLoginOrRegister);

                // Toggle between login and register
                function toggleLoginOrRegister() {
                    loginPanel.toggleClass("disabled");
                    loginPanel.toggleClass("enabled");
                    registerPanel.toggleClass("disabled");
                    registerPanel.toggleClass("enabled");

                    isLogin = !isLogin;
                }
            });
        </script>
    </head>

    <body id="login-body">
        <!-- Welcome  -->
        <div id="welcome">
            <img id="logo" src="images/nyan_logo_nobg_large.png" alt="Store icon" width="166px" height="166px">

            <h2 id="store-name">
                Nyan <br>
                Groceries
            </h2>

            <h2 id="store-motto">
                The colorful store for your <br>
                better day :)
            </h2>
        </div>

        <!-- Login -->
        <div id="login">
            <div>
                <h3>Login</h3>
                <span class="account-message">Don't have an account? <a class="link-control">Register here!</a></span> <br><br>
                <form action="userloginvalidate" method="post">
                    <div class="form-group">
                        <label for="username">Username</label><br>
                        <input type="text" name="username" id="username" placeholder="Bob123" required class="form-control form-control-lg">
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label><br>
                        <input type="password" class="form-control form-control-lg" placeholder="***********" required name="password" id="password">
                    </div>

                    <div class="btn-container">
                        <input type="submit" value="Submit" class="btn btn-primary">
                    </div>
                    <br>
                    <h3>${message }</h3>
                    <br>
                </form>
            </div>
        </div>

        <!-- Register -->
        <div id="register" class="disabled">
            <div>
                <h3>Register</h3>
                <span class="account-message">Already have an account? <a class="link-control">Login here!</a></span> <br><br>
                <form action="newuserregister" method="post">
                    <div class="form-group">
                        <label for="firstName">User Name</label><br>
                        <input type="text" name="username" id="firstName" required placeholder="Bob123" required class="form-control form-control-lg">
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label><br>
                        <input type="password" class="form-control form-control-lg" required placeholder="***********" required name="password" id="password">
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label><br>
                        <input type="email" class="form-control form-control-lg" required minlength="6" placeholder="user@email.com" required name="email" id="email" aria-describedby="emailHelp">
                    </div>

                    <div class="form-group">
                        <label for="Address">Address</label><br>
                        <textarea class="form-control form-control-lg" rows="2" placeholder="123, Main St" name="address"></textarea>
                    </div>

                    <div class="btn-container">
                        <input type="submit" value="Register" class="btn btn-primary"><br>
                    </div>
                </form>
            </div>
        </div>
    </body>

</html>