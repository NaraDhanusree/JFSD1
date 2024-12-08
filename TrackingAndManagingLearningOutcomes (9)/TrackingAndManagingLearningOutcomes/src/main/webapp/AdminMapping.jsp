<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Mapping Dashboard</title>
    <link rel="stylesheet" href="css/styles.css" />
    <style>
        /* Base styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            height: 100vh;
            background-color: #f4f4f4;
        }

        h3 {
            margin-bottom: 20px;
            font-size: 1.2em;
            text-align: center;
        }

        /* Navbar styling */
        .navbar {
            display: flex;
            justify-content: space-between;
            background-color: #2C3E50;
            color: white;
            padding: 15px 30px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            font-size: 1.1em;
        }

        .navbar label {
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
            font-weight: bold;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s ease;
            color: white;
        }

        .navbar label:hover {
            background-color: #1ABC9C;
        }

        /* Content area */
        .content {
            margin-top: 80px;
            padding: 40px;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow-y: auto;
        }

        /* Registration window */
        .registrationWindow {
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        /* Buttons */
        .registerButton {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .registerButton:hover {
            background-color: #0056b3;
        }

        /* Responsive layout for smaller screens */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar label {
                margin: 5px 0;
                width: 100%;
                text-align: center;
            }
        }

    </style>
</head>
<body>
    <div class="navbar">
        <h3>Admin Dashboard</h3>
        <div>
            <label class="signuplabel" onClick="StudentCourseMapping()">Student Course Mapping</label>
            <label class="signuplabel" onClick="FacultyCourseMapping()">Faculty Course Mapping</label>
            <label class="signuplabel" onClick="Logout()">Logout</label>
        </div>
    </div>
    
    <div class="content">
        <div id="registrationForm" class="registrationWindow">
            <!-- Add your content here -->
            <h2>Welcome to Admin Dashboard</h2>
            <p>Select a section from the navigation bar to manage Student or Faculty records.</p>
        </div>
    </div>

    <script>
        function BACK_HOME_PAGE() {
            location.replace("/AdminHome.jsp");
        }
        
        function StudentCourseMapping() {
            location.replace("StudentCourseMapping.jsp");
        }
        
        function Logout() {
            location.replace("/index.jsp");
        }

        function FacultyCourseMapping() {
            location.replace("/FacultyCourseMapping.jsp");
        }
    </script>
</body>
</html>