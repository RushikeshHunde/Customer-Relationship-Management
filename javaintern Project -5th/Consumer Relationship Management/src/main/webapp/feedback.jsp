<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Feedback Page</title>
<link rel = "stylesheet" href = "css/nav.css" type='text/css'>
<link rel = "stylesheet" href = "css/feedback.css" type='text/css'>
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
<form method="POST" action="FeedbackServlet">
  <h2>Submit Feedback</h2>
  <textarea name="feedback" rows="6" cols="50" required></textarea><br>
  <button type="submit">Submit</button>
</form>
</body>
</html>