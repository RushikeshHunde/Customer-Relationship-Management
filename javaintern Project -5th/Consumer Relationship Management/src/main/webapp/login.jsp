<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<link rel = "stylesheet" href = "css/nav.css" type='text/css'>
<link rel = "stylesheet" href = "css/login.css" type='text/css'>
</head>
<body>   
<form method="POST" action="LoginServlet">
  <h1>Login</h1>
  
  <h2>E-mail:</h2> <input type="email" placeholder="Email" name="gmail" required><br>
  <h2>Password:</h2> <input type="password" placeholder="Password" name="password" required><br>
   <h2>Login As:</h2>
    <select name="userType" required>
      <option value="">-- Select Role --</option>
      <option value="admin">Admin</option>
      <option value="consumer">Consumer</option>
    </select><br><br>
    
  <button type="submit">Login</button>
</form>
</body>
</html>