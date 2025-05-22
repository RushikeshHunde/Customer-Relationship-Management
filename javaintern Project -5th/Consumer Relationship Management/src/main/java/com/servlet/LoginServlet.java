package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/crm";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "#rushi@2183#";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gmail = request.getParameter("gmail");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        if (gmail == null || password == null || userType == null) {
            response.getWriter().println("Missing login fields.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("admin".equalsIgnoreCase(userType)) {
                // Admin login (plaintext comparison)
                if ("admin2183@gmail.com".equals(gmail) && "admin@210803".equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("gmail", gmail);
                    session.setAttribute("userType", "admin");
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.getWriter().println("Invalid admin credentials.");
                }
            } else if ("consumer".equalsIgnoreCase(userType)) {
                String hashedPassword = hashPassword(password);

                // Check if user exists
                PreparedStatement checkUser = conn.prepareStatement(
                    "SELECT password FROM crm_users WHERE gmail = ? AND userType = 'consumer'");
                checkUser.setString(1, gmail);
                ResultSet rs = checkUser.executeQuery();

                if (rs.next()) {
                    // Validate hashed password
                    String storedHashed = rs.getString("password");
                    if (storedHashed.equals(hashedPassword)) {
                        // Correct login
                        HttpSession session = request.getSession();
                        session.setAttribute("gmail", gmail);
                        session.setAttribute("userType", "consumer");
                        response.sendRedirect("home.jsp");
                    } else {
                        response.getWriter().println("Incorrect password.");
                    }
                } else {
                    // New user → register
                    PreparedStatement insertUser = conn.prepareStatement(
                        "INSERT INTO crm_users (gmail, password, userType, created_at) VALUES (?, ?, ?, NOW())");
                    insertUser.setString(1, gmail);
                    insertUser.setString(2, hashedPassword);
                    insertUser.setString(3, "consumer");
                    insertUser.executeUpdate();

                    // Login after registration
                    HttpSession session = request.getSession();
                    session.setAttribute("gmail", gmail);
                    session.setAttribute("userType", "consumer");
                    response.sendRedirect("home.jsp");
                }

                rs.close();
                checkUser.close();
            } else {
                response.getWriter().println("Invalid user type selected.");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Server error: " + e.getMessage());
        }
    }

    // Password hashing function (SHA-256)
    private String hashPassword(String password) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));

        // Convert bytes to hex string
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashedBytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
}
