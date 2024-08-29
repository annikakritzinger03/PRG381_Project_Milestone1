package com.example.PRG381Proj.controller;

import com.example.PRG381Proj.dao.DatabaseConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {


    public void init(){};

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isValid = true;

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Username cannot be empty");
            isValid = false;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("passwordError", "Password cannot be empty");
            isValid = false;
        }

        if (!isValid) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            try (Connection connection = DatabaseConnection.initializeDatabase()) {
                String sql = "SELECT * FROM login WHERE username = ? AND password = ?";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, username);
                    statement.setString(2, password);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            // Credentials are correct
                            request.setAttribute("username", username);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            // Invalid credentials
                            response.sendRedirect("index.jsp?error=Invalid+username+or+password");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }

    public void destroy() {
    }
}