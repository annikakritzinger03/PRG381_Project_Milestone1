package com.example.PRG381Proj.dao;

import java.sql.*;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/LibraryManagementDB";
    private static final String USER = "postgres"; // Your DB username
    private static final String PASSWORD = "'q=mB)`I9"; // Your DB password

    // Establish a connection to the PostgreSQL database
    public static Connection initializeDatabase() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC Driver not found. Include it in your library path.");
            e.printStackTrace();
        }


        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // test if the database connection is successful
    public static boolean isConnectionValid() {
        try (Connection connection = initializeDatabase()) {
            if (connection != null && !connection.isClosed()) {
                System.out.println("Connection to the database is successful!");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database: " + e.getMessage());
        }
        return false;
    }


}
