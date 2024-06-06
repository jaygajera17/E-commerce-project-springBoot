package com.jtspringproject.JtSpringProject.dao;
import org.apache.log4j.Logger;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/newuserregister")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        String url = "jdbc:mysql://localhost:3306/ecommjava";
        String user = "root";
        String passwordDB = "Chet123$";

        Logger logger = Logger.getLogger(RegisterServlet.class);

        try (Connection conn = DriverManager.getConnection(url, user, passwordDB)) {
            String sql = "INSERT INTO customer (username, email, password, address) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, password);
            statement.setString(4, address);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                // Registration successful
                response.sendRedirect("registration_success.html");
            } else {
                // Registration failed
                response.sendRedirect("registration_failed.html");
            }
        } catch (SQLException ex) {
            // Log the exception
            logger.error("Error occurred during database operation", ex);

            // Handle SQL exceptions
            response.sendRedirect("registration_failed.html");
        }
    }
}

