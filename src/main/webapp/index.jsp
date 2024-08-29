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
        function togglePasswordVisibility() {
            var passwordField = document.getElementById("password");
            var toggleText = document.getElementById("togglePasswordText");
            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleText.innerText = "Hide";
            } else {
                passwordField.type = "password";
                toggleText.innerText = "Show";
            }
        }
    </script>
</head>
<body style="border: 2px solid white;">
<div class="login-container">
    <h1>User Login</h1>
    <form action="LoginServlet" method="post">
        <label for="username">Username:</label><br>
        <input id="username" type="text" name="username" required><br>
        <div class="password-container">
            <label for="password">Password:</label>
            <input id="password" type="password" name="password" required>
            <button type="button" id="togglePasswordText" class="toggle-password" onclick="togglePasswordVisibility()">Show</button>
        </div>
        <button type="submit">Login</button>
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