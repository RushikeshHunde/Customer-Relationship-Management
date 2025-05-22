package com.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@SuppressWarnings("serial")
@WebServlet("/SubmitReport")
public class SubmitReport extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/crm";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "#rushi@2183#";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("SubmitReport servlet reached!"); // Debug line
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("gmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String gmail = (String) session.getAttribute("gmail");
        String userType = (String) session.getAttribute("userType");
        String report = request.getParameter("report");

        if (report == null || report.trim().isEmpty()) {
            response.sendRedirect("report.jsp?error=empty");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement ps = conn.prepareStatement(
                 "INSERT INTO report (gmail, userType, message) VALUES (?, ?, ?)")) {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            ps.setString(1, gmail);
            ps.setString(2, userType);
            ps.setString(3, report);
            ps.executeUpdate();
            
            response.sendRedirect("home.jsp?success=report");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("report.jsp?error=server");
        }
    }
}