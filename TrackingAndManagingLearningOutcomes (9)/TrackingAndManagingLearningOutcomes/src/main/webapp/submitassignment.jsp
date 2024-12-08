<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Page</title>
</head>
<body>
    <h1>Welcome to the Assignment Submission System</h1>

    <% 
        // Display a message dynamically
        String userMessage = "You have successfully logged in!";
    %>
    
    <p><%= userMessage %></p>
</body>
</html>
