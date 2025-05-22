<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "css/nav.css" type='text/css'>
<link rel = "stylesheet" href = "css/admin_dashboard.css" type='text/css'>
    <title>Admin Dashboard</title>
    <style>
    h2{margin-left: 45%; font-size: 25px;}
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; margin-top: 5%; }
        th{background-color: grey; padding: 15px; text-align: center; border-bottom: 1px solid #ddd; font-size:20px;}
        td { padding: 15px; text-align: center; border-bottom: 1px solid #ddd; }
    </style>
</head>
<body>
 <nav>
    <div class="nav-container">
       <a href="home.jsp">Home</a>
      <a href="login.jsp">Login</a>
      <a href="feedback.jsp">Feedback</a>
      <a href="report.jsp">Report</a>
    </div>
  </nav>
    <h1>Admin Dashboard</h1>
    
    <div class="section">
        <h2>User Logins</h2>
        <table>
            <tr>
                <th>Email</th>
                <th>User Type</th>
                <th>Last Login</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/crm", "root", "#rushi@2183#");
                    
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT gmail, userType, created_at FROM crm_users ORDER BY created_at DESC");
                    
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("gmail") %></td>
                            <td><%= rs.getString("userType") %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
    
    <div class="section">
        <h2>Feedback</h2>
        <table>
            <tr>
                <th>Email</th>
                <th>Message</th>
                <th>Submitted At</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/crm", "root", "#rushi@2183#");
                    
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT gmail, message, created_at FROM feedback ORDER BY created_at DESC");
                    
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("gmail") %></td>
                            <td><%= rs.getString("message") %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
    
    <div class="section">
        <h2>Reports</h2>
        <table>
            <tr>
                <th>Email</th>
                <th>Message</th>
                <th>Submitted At</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/crm", "root", "#rushi@2183#");
                    
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(
                        "SELECT gmail, message, created_at FROM report ORDER BY created_at DESC");
                    
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getString("gmail") %></td>
                            <td><%= rs.getString("message") %></td>
                            <td><%= rs.getTimestamp("created_at") %></td>
                        </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='3'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>
</body>
</html>