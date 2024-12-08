<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/styles.css" />
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Horizontal Menu Styling */
        .horizontal-navbar {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 15px;
            background-color: #2c3e50;
            box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .horizontal-navbar a {
            color: #ecf0f1;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #34495e;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .horizontal-navbar a:hover {
            background-color: #1abc9c;
        }

        /* Main Content Styling */
        .content {
            padding: 30px;
            flex-grow: 1;
        }

        .content h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #2980b9;
        }

        .content p {
            font-size: 1.2em;
            color: #7f8c8d;
            line-height: 1.8;
        }

        /* Form Styling */
        .registrationWindow {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .registrationHeader {
            font-size: 1.8em;
            margin-bottom: 15px;
            color: #34495e;
        }

        .registrationContent {
            margin-top: 20px;
        }

        .registrationContent label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
            color: #34495e;
        }

        .registrationContent input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 1em;
        }

        .registerButton {
            background-color: #3498db;
            color: white;
            padding: 12px 25px;
            border-radius: 6px;
            font-size: 1.1em;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .registerButton:hover {
            background-color: #2980b9;
        }

        .acknowledgement {
            margin-top: 20px;
            font-size: 1.2em;
        }

        .acknowledgement.green {
            color: green;
        }

        .acknowledgement.red {
            color: red;
        }

    </style>
</head>
<body>
    <!-- Horizontal Navbar -->
    <div class="horizontal-navbar">
        <a href="#" onclick="displayStudentRegistration()">Register New Student</a>
        <a href="#" onclick="ReterivewALLStudent()">View All Students</a>
        <a href="#" onclick="AdminHome()">Back to Admin Home</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h1>Welcome to the Admin Dashboard</h1>
        <p>This dashboard allows you to manage student registrations, view all registered students, and navigate back to the admin home. Use the top menu to access different features.</p>

        <div id="registrationForm" class="registrationWindow" style="display:none;">
            <div class="registrationHeader">Register New Student</div>
            <div class="registrationContent">
                <label for="username">Username*</label>
                <input type="text" id="username" />
                
                <label for="firstName">First Name*</label>
                <input type="text" id="firstName" />
                
                <label for="lastName">Last Name*</label>
                <input type="text" id="lastName" />
                
                <label for="email">Email*</label>
                <input type="email" id="email" />
                
                <label for="password">Password*</label>
                <input type="password" id="password" />
                
                <button class="registerButton" onclick="registerStudent()">Register</button>

                <div class="acknowledgement" id="ack"></div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        function displayStudentRegistration() {
            document.getElementById('registrationForm').style.display = 'block';
        }

        function registerStudent() {
            var data = JSON.stringify({
                username: document.getElementById('username').value,
                firstname: document.getElementById('firstName').value,
                lastname: document.getElementById('lastName').value,
                email: document.getElementById('email').value,
                password: document.getElementById('password').value
            });

            var url = "http://localhost:8080/student/save"; // Adjust URL as needed
            callApi("POST", url, data, getResponse);
        }

        function getResponse(res) {
            var ackLabel = document.getElementById('ack');
            if (res === "200") {
                ackLabel.classList.add('green');
                ackLabel.classList.remove('red');
                ackLabel.innerHTML = "Registration successful!";
            } else {
                ackLabel.classList.add('red');
                ackLabel.classList.remove('green');
                ackLabel.innerHTML = "Registration failed, please try again.";
            }
        }

        function ReterivewALLStudent() {
            location.replace("/AdminAllStudents.jsp");
        }

        function AdminHome() {
            location.replace("/AdminHome.jsp");
        }
    </script>
</body>
</html>