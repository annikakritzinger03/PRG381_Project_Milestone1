<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');

            if (error) {
                const errorMsgElement = document.getElementById('errorMessage');

                errorMsgElement.textContent = error;

                document.getElementById('username').style.borderColor = 'red';
                document.getElementById('password').style.borderColor = 'red';
            }
        });

        function redirectToRegister() {
            window.location.href = 'Register.jsp';
        }
    </script>
</head>
<body style="border: 2px solid white;">
<div class="login-container">
    <h1>User Login</h1>
    <form action="LoginServlet" method="post">
        <label for="username">Username:</label><br>
        <input id="username" type="text" name="username" required><br>
        <label for="password">Password:</label><br>
        <input id="password" type="password" name="password" required><br>
        <button><a>Login</a></button>
        <p id="errorMessage"></p>
    </form>
</div>
<div class="signup-container">
    <div class="signup-content">
        <h2>New Here?</h2>
        <p>Sign Up Below</p>
        <button id="signUpButton" onclick="redirectToRegister()">Sign Up</button>
    </div>
</div>
</body>
</html>