package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@SuppressWarnings("serial")
@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/crm";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "#rushi@2183#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String gmail = (String) session.getAttribute("gmail");
        String userType = (String) session.getAttribute("userType");
        String feedback = request.getParameter("feedback");

        if (feedback == null || feedback.trim().isEmpty()) {
            response.sendRedirect("feedback.jsp?error=empty");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO feedback (gmail, userType, message) VALUES (?, ?, ?)");
            ps.setString(1, gmail);
            ps.setString(2, userType);
            ps.setString(3, feedback);
            ps.executeUpdate();
            
            conn.close();
            response.sendRedirect("home.jsp?success=feedback");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?error=server");
        }
    }
}