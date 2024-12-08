<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Faculty Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        /* Top Navbar */
        .topnav {
            background-color: #34495e;
            color: white;
            padding: 14px 20px;
            text-align: center;
            font-size: 26px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }

        /* Horizontal Navbar */
        .navbar {
            display: flex;
            justify-content: center;
            background-color: #2c3e50;
            padding: 10px 0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }

        .navbar ul {
            display: flex;
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .navbar ul li {
            padding: 12px 20px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .navbar ul li a {
            color: white;
            text-decoration: none;
            display: block;
        }

        .navbar ul li:hover {
            background-color: #2980b9; /* Highlight on hover */
            border-radius: 5px;
            transform: scale(1.1); /* Slight zoom effect */
        }

        .navbar ul li a:hover {
            color: #ecf0f1; /* Change text color on hover */
        }

        /* Container for content */
        .container {
            display: flex;
            flex-direction: column;
            height: calc(100vh - 100px); /* Adjusted for topnav and navbar height */
        }

        /* Content area */
        .content {
            flex-grow: 1;
            padding: 20px;
            background-color: #fff;
            margin: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        /* Faculty registration form */
        #facultyForm {
            display: none;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            background-color: #ecf0f1;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-size: 16px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            font-size: 16px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1abc9c;
        }
        /* Acknowledgment message */
        #ack {
            font-size: 16px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- Top Navbar with centered title -->
    <div class="topnav">
        Admin Faculty Dashboard
    </div>

    <!-- Horizontal Navbar -->
    <div class="navbar">
        <ul>
            <li><a href="#" onclick="displayFacultyForm()">Register Faculty</a></li>
            <li><a href="#" onclick="ReterivewALLFaculties()">View Faculty</a></li>
            <li><a href="#" onclick="Back_To_AdminHome()">Back to Admin Home</a></li>
        </ul>
    </div>

    <!-- Main container for content -->
    <div class="container">
        <!-- Dashboard Overview -->
        <div class="content">
            <h2>Faculty Dashboard Overview</h2>
            <p>Welcome to the Faculty Management System. Here you can manage faculty registrations, view details, and track faculty-related data.</p>
            
        </div>

        <!-- Faculty Registration Form (Initially hidden) -->
        <form id="facultyForm">
            <label for="facultyid">Faculty ID:</label>
            <input type="text" id="facultyid" name="facultyid" required>

            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="department">Department:</label>
            <select id="department" name="department" required>
                <option value="">Select Department</option>
                <option value="BT">Biotechnology (BT)</option>
                <option value="CSE">Computer Science and Engineering (CSE)</option>
                <option value="ECE">Electronics and Communication Engineering (ECE)</option>
                <option value="CE">Civil Engineering (CE)</option>
                <option value="BCA">Bachelor of Computer Applications (BCA)</option>
                <option value="BBA">Bachelor of Business Administration (BBA)</option>
                <option value="MBA">Master of Business Administration (MBA)</option>
                <option value="M.Tech">Master of Technology (M.Tech)</option>
            </select>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="button" onclick="submitFaculty()">Register</button>
        </form>

        <!-- Acknowledgment message display -->
        <p id="ack"></p>
    </div>

    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        // Function to display the Faculty Registration form when "Register Faculty" is clicked
        function displayFacultyForm() {
            var form = document.getElementById('facultyForm');
            form.style.display = 'block'; // Show the form
        }

        // Function to handle Faculty registration
        function submitFaculty() {
            // Prepare the faculty data as JSON
            var data = JSON.stringify({
                facultyid: parseInt(document.getElementById('facultyid').value, 10),  // Convert facultyid to long
                name: document.getElementById('name').value,  // Faculty name
                department: document.getElementById('department').value,  // Faculty department
                email: document.getElementById('email').value,  // Faculty email
                password: document.getElementById('password').value  // Faculty password
            });

            // API URL for saving faculty details
            var url = "http://localhost:8080/faculty/save";

            // Call the API with method POST and send the data
            callApi("POST", url, data, getResponse);  // callApi is from main.js
        }

        // Callback function to handle the API response
        function getResponse(res) {
            var ack = document.getElementById("ack");  // Reference the ack element
            // If response code is 401, show Faculty ID already exists message
            if (res == 401) {
                ack.style.color = "red";
                ack.innerHTML = "Faculty ID already exists!";
            } else if (res == 200) {
                ack.style.color = "green";
                ack.innerHTML = "Faculty registered successfully!";
            } else {
                ack.style.color = "red";
                ack.innerHTML = "Error: " + res;
            }
        }

        function Back_To_AdminHome() {
            location.replace("/AdminHome.jsp");
        }

        function ReterivewALLFaculties() {
            location.replace("/AdminAllFaculties.jsp");
        }
    </script>

</body>
</html>