package com.example.PRG381Proj.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;

import com.example.PRG381Proj.dao.DatabaseConnection;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Registration Servlet";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        boolean isValid = true;
        StringBuilder errorMessage = new StringBuilder();

        // Email validation
        String emailPattern = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        if (email == null || !email.matches(emailPattern)) {
            errorMessage.append("Please enter a valid email address.<br>");
            isValid = false;
        }

        // Phone number validation (10 digits)
        String phonePattern = "^\\d{10}$";
        if (phone == null || !phone.matches(phonePattern)) {
            errorMessage.append("Please enter a valid 10-digit phone number.<br>");
            isValid = false;
        }

        // Password validation (minimum 8 characters, at least one digit, one uppercase letter, one lowercase letter, and one special character)
        String passwordPattern = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).{8,}$";
        if (password == null || !password.matches(passwordPattern)) {
            errorMessage.append("Password must be at least 8 characters long and contain at least one digit, one uppercase letter, one lowercase letter, and one special character.<br>");
            isValid = false;
        }

        // Check if the username already exists
        try {
            boolean usernameExists = checkIfUsernameExists(username);
            if (usernameExists) {
                errorMessage.append("Username is already taken!<br>");
                isValid = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorMessage.append("An error occurred while checking the username.<br>");
            isValid = false;
        }

        if (isValid) {

            String registerQuery = "INSERT INTO register (username, name, surname, password, phone, email) VALUES (?, ?, ?, ?, ?, ?)";
            String loginQuery = "INSERT INTO login (username, password) VALUES (?, ?)";

            try (Connection connection = DatabaseConnection.initializeDatabase();
                 PreparedStatement registerStatement = connection.prepareStatement(registerQuery);
                 PreparedStatement loginStatement = connection.prepareStatement(loginQuery)) {

                // Set parameters for the register table
                registerStatement.setString(1, username);
                registerStatement.setString(2, name);
                registerStatement.setString(3, surname);
                registerStatement.setString(4, password);
                registerStatement.setString(5, phone);
                registerStatement.setString(6, email);

                loginStatement.setString(1, username);
                loginStatement.setString(2, password);

                int rowsInsertedRegister = registerStatement.executeUpdate();
                int rowsInsertedLogin = loginStatement.executeUpdate();

                if (rowsInsertedRegister > 0 && rowsInsertedLogin > 0) {
                    // Registration successful, redirect to index.jsp
                    response.sendRedirect("index.jsp");
                } else {
                    response.getWriter().println("Registration failed. Please try again.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("An error occurred during registration.");
            }
        } else {
            request.setAttribute("errorMessage", errorMessage.toString());
            RequestDispatcher dispatcher = request.getRequestDispatcher("Register.jsp");
            dispatcher.forward(request, response);
        }
    }

    private boolean checkIfUsernameExists(String username) throws SQLException {

        String query = "SELECT COUNT(*) FROM login WHERE username = ?";

        try (Connection connection = DatabaseConnection.initializeDatabase();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, username);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0; // If count is greater than 0, username exists
                }
            }
        }
        return false; // Username does not exist
    }

    public void destroy() {
    }


}