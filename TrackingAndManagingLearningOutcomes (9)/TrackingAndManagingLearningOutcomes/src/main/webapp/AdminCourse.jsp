<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Course Management</title>
    <link rel="stylesheet" href="css/styles.css" />
    <style>
        body {
            display: flex;
            margin: 0;
            height: 100vh;
            flex-direction: column; /* Ensure the body has a column layout */
            font-family: Arial, sans-serif;
            background-color: #F4F6F9; /* Light gray background */
        }

        /* Horizontal Navigation Bar */
        .navbar {
            width: 100%;
            background-color: #2C3E50; /* Dark blue-gray */
            color: white;
            padding: 12px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            display: flex;
            justify-content: space-around; /* Centers navigation links */
            align-items: center;
        }

        .navbar h3 {
            margin: 0;
            font-size: 18px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-size: 16px;
        }

        .navbar a:hover {
            background-color: #34495E; /* Slightly lighter blue-gray */
        }

        /* Content section layout */
        .content {
            margin: 20px;
            padding: 20px;
            flex-grow: 1;
            overflow-y: auto;
        }

        .registrationWindow {
            border: 1px solid #BDC3C7; /* Light gray border */
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .registrationHeader {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2C3E50; /* Dark blue-gray */
        }

        /* Make the course form inputs look nicer */
        .registrationWindow input {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #BDC3C7; /* Light gray border */
            border-radius: 5px;
            font-size: 16px;
            background-color: #ECF0F1; /* Light gray background */
        }

        .registerButton {
            background-color: #2980B9; /* Professional blue */
            color: white;
            padding: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .registerButton:hover {
            background-color: #3498DB; /* Lighter blue on hover */
        }

        /* Optional courses display styling */
        #coursesList {
            margin-top: 20px;
        }

        /* Make the confirmation message look better */
        #courseAck {
            font-size: 16px;
            margin-top: 10px;
        }

        #courseAck.success {
            color: #27AE60; /* Green for success */
        }

        #courseAck.failure {
            color: #E74C3C; /* Red for failure */
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h3>Navigation</h3>
        <a href="#" onclick="displayCourseRegistration()">Course Registration</a>
       
        <a href="#" onclick="AdminHome()">Back To Admin Home</a>
    </div>

    <div class="content">
        <!-- Course Registration Form -->
        <div id="courseRegistrationForm" class="registrationWindow" style="display:none;">
            <div class="registrationHeader">Register Course</div>
            <div class="registrationContent">
                <div style="display:block;padding-top:20px">Course ID*</div>
                <input type="number" id="courseId" />
                
                <div style="display:block;padding-top:20px">Course Name*</div>
                <input type="text" id="courseName" />
                
                <div style="display:block;padding-top:20px">Course Description*</div>
                <input type="text" id="courseDescription" />
                
                <button class="registerButton" onclick="registerCourse()">Register</button>
                <div style="display:block;height:80px;line-height:80px">
                    <label id="courseAck"></label>
                </div>
            </div>
        </div>

        <!-- Course Display Section (Optional) -->
        <div id="coursesList" class="registrationWindow" style="display:none;">
            <div class="registrationHeader">All Courses</div>
            <div id="coursesTable" style="padding-top:20px;">
                <!-- The courses will be displayed here dynamically -->
            </div>
        </div>
    </div>

    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        function displayCourseRegistration() {
            document.getElementById('courseRegistrationForm').style.display = 'block';
            document.getElementById('coursesList').style.display = 'none'; // Hide courses list if open
        }

        function registerCourse() {
            var data = JSON.stringify({
                courseid: document.getElementById('courseId').value,
                coursename: document.getElementById('courseName').value,
                coursedescription: document.getElementById('courseDescription').value
            });

            var url = "http://localhost:8080/courses/save"; // Adjust URL as needed
            callApi("POST", url, data, getCourseResponse);
        }

        function getCourseResponse(res) {
            if (res === "200") {
                document.getElementById('courseAck').style.color = "green";
                document.getElementById('courseAck').innerHTML = "Course registration successful!";
            } else {
                document.getElementById('courseAck').style.color = "red";
                document.getElementById('courseAck').innerHTML = "Course registration failed!";
            }
        }

       function ReterivewALLCourses()
       {
    	   location.replace("/AdminAllCourses.jsp")
       }
        function AdminHome() {
            location.replace("/AdminHome.jsp");
        }
    </script>
</body>
</html>
