package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/crop_db";

    private static final String USER = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);

        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found!");
            e.printStackTrace();

        } catch (SQLException e) {
            System.err.println("Database connection failed! Check MySQL server and crop_db database.");
            e.printStackTrace();
        }

        return null;
    }

    public static boolean isConfigured() {
        return URL.contains("crop_db");
    }
}