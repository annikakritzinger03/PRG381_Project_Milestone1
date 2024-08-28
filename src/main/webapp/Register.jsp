<%--
  Created by IntelliJ IDEA.
  User: encry
  Date: 2024/08/27
  Time: 08:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function validateForm() {
            // Clear previous error messages
            document.getElementById("emailError").innerText = "";
            document.getElementById("phoneError").innerText = "";
            document.getElementById("passwordError").innerText = "";

            var isValid = true;

            var email = document.getElementById("email").value;
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                document.getElementById("emailError").innerText = "Please enter a valid email address.";
                isValid = false;
            }

            var phone = document.getElementById("phone").value;
            var phonePattern = /^\d{10}$/; // Example for 10-digit phone numbers
            if (!phonePattern.test(phone)) {
                document.getElementById("phoneError").innerText = "Please enter a valid 10-digit phone number.";
                isValid = false;
            }

            var password = document.getElementById("password").value;
            var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$/;
            if (!passwordPattern.test(password)) {
                document.getElementById("passwordError").innerText = "Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character.";
                isValid = false;
            }

            return isValid;
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
<body>
<div class="register-container">
    <h1>Register</h1>
    <form action="RegisterServlet" method="post" onsubmit="return validateForm()">

        <label for="username">Username:</label>
        <input id="username" type="text" name="username" required>
        <br>

        <div class="password-container">
            <label id="lblPassword" for="password">Password:</label>
            <input id="password" type="password" name="password" required>
            <button type="button" id="togglePasswordText" class="toggle-password" onclick="togglePasswordVisibility()">Show</button>
        </div>
        <div id="passwordError" class="error"></div>


        <label for="name">Name:</label>
        <input id="name" type="text" name="name" required>
        <br>

        <label for="surname">Surname:</label>
        <input id="surname" type="text" name="surname" required>
        <br>

        <label for="phone">Phone:</label>
        <input id="phone" type="text" name="phone" required>
        <div id="phoneError" class="error"></div>


        <label for="email">Email:</label>
        <input id="email" type="text" name="email" required>
        <div id="emailError" class="error"></div>


        <button type="submit">Register</button>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <p class="error"><%= errorMessage %></p>
        <% } %>
    </form>
</div>
</body>
</html>
