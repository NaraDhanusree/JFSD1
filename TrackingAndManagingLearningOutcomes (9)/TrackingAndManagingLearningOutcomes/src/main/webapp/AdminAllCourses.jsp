<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Courses</title>
    <link rel="stylesheet" type="text/css" href="css/student.css">
    <style>
       /* General Styles */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

h3 {
    margin: 0;
    font-weight: normal;
}

/* Top Navigation Bar */
.topnav {
    background-color: #2C3E50;
    color: white;
    padding: 16px 20px;
    text-align: center;
    font-size: 22px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    font-weight: bold;
}

/* Sidebar */
.sidebar {
    width: 220px;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    background-color: #34495E;
    padding-top: 30px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.sidebar ul li {
    padding: 12px;
    border-radius: 4px;
    margin-bottom: 5px;
}

.sidebar ul li a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 10px;
    font-size: 16px;
    font-weight: 500;
}

.sidebar ul li a:hover {
    background-color: #1ABC9C;
    border-radius: 5px;
}

/* Content Container */
.container {
    margin-left: 240px; /* Adjust for sidebar width */
    padding: 20px;
    background-color: white;
    min-height: 100vh;
    box-sizing: border-box;
}

/* Table Styling */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table, th, td {
    border: 1px solid #BDC3C7;
}

th, td {
    padding: 12px;
    text-align: left;
    font-size: 16px;
}

th {
    background-color: #2C3E50;
    color: white;
}

td {
    background-color: #ECF0F1;
}

/* Button Styles */
.update-btn, .delete-btn {
    padding: 8px 16px;
    margin-right: 8px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}

.update-btn {
    background-color: #1ABC9C;
    color: white;
    border: none;
}

.update-btn:hover {
    background-color: #16A085;
}

.delete-btn {
    background-color: #E74C3C;
    color: white;
    border: none;
}

.delete-btn:hover {
    background-color: #C0392B;
}

/* Update Form Styling */
#updateForm {
    display: none;
    margin-top: 20px;
    padding: 20px;
    background-color: #ECF0F1;
    border-radius: 6px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

#updateForm h3 {
    font-size: 20px;
    color: #2C3E50;
    margin-bottom: 10px;
}

#updateForm form {
    display: flex;
    flex-direction: column;
}

#updateForm label {
    margin-bottom: 5px;
    color: #7F8C8D;
}

#updateForm input[type="text"], #updateForm input[type="email"], #updateForm input[type="password"] {
    padding: 12px;
    margin-bottom: 15px;
    border: 1px solid #BDC3C7;
    border-radius: 4px;
    font-size: 16px;
}

#updateForm button {
    background-color: #1ABC9C;
    color: white;
    border: none;
    padding: 12px 24px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
}

#updateForm button:hover {
    background-color: #16A085;
}

/* Responsive Design */
@media (max-width: 768px) {
    .sidebar {
        width: 100%;
        height: auto;
        position: relative;
        box-shadow: none;
    }

    .sidebar ul li {
        text-align: center;
    }

    .container {
        margin-left: 0;
    }

    .topnav {
        font-size: 18px;
    }
}

    </style>
</head>
<body>

     <!-- Top Navbar -->
    <div class="topnav">
        <span class="project-title">Student Learning Management System</span>
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul>
            <li><a href="AdminCourse.jsp">Dashboard</a></li>
            <li><a href="#">ALL COURSES</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="container">
        <table id="courseTable">
            <thead>
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Description</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="courseData">
                <!-- Data will be populated here using JavaScript -->
            </tbody>
        </table>

        <!-- Update Form (Initially Hidden) -->
        <div id="updateForm">
            <h3>Update Course</h3>
            <form id="courseUpdateForm">
                <label for="updateCourseName">Course Name:</label><br>
                <input type="text" id="updateCourseName" name="updateCourseName" required><br>

                <label for="updateDescription">Description:</label><br>
                <input type="text" id="updateDescription" name="updateDescription" required><br>

                <!-- Hidden input to store Course ID -->
                <input type="hidden" id="updateId" name="updateId">

                <br>
                <button type="button" onclick="submitCourseUpdate()">Submit Update</button>
            </form>
        </div>
    </div>

    <!-- Script to handle API calls and update functionality -->
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        // Function to fetch all course data from the backend
        function loadCourseData() {
            var url = "http://localhost:8080/courses/readAllCourses";  // API endpoint to get all courses
            console.log("Loading course data from: ", url);
            callApi("GET", url, null, displayCourseData);  // Call API using callApi() method defined in main.js
        }

        // Callback function to display course data in the table
        function displayCourseData(response) {
            console.log("Received course data: ", response);
            var courseData = JSON.parse(response);  // Parse JSON response
            var courseTable = document.getElementById("courseData");

            // Clear existing table rows
            courseTable.innerHTML = "";

            // Populate table with course data
            courseData.forEach(function(course) {
                var row = "<tr>" +
                            "<td>" + course.courseid + "</td>" +
                            "<td>" + course.coursename + "</td>" +
                            "<td>" + course.coursedescription + "</td>" +
                            "<td>" +
                                "<button class='update-btn' onclick='populateCourseUpdateForm(" + JSON.stringify(course) + ")'>Update</button>" +
                                "<button class='delete-btn' onclick='deleteCourse(" + course.courseid + ")'>Delete</button>" +
                            "</td>" +
                          "</tr>";
                courseTable.innerHTML += row;
            });
        }

        // Function to populate update form with selected course's data
        function populateCourseUpdateForm(course) {
            document.getElementById("updateCourseName").value = course.coursename;
            document.getElementById("updateDescription").value = course.coursedescription;
            document.getElementById("updateId").value = course.courseid;

            // Show the update form
            document.getElementById("updateForm").style.display = "block";
        }

        // Function to submit update form
        function submitCourseUpdate() {
            var updateId = document.getElementById("updateId").value;
            var updatedName = document.getElementById("updateCourseName").value;
            var updatedDescription = document.getElementById("updateDescription").value;

            // Create the update data object
            var updateData = {
                courseid: updateId,
                coursename: updatedName,
                coursedescription: updatedDescription
            };

            var url = "http://localhost:8080/courses/update"; // Update API endpoint
            callApi("PUT", url, JSON.stringify(updateData), function(response) {
                console.log("Update response: ", response);
                loadCourseData();  // Reload course data
                document.getElementById("updateForm").style.display = "none";  // Hide form after update
                
                alert("Course updated successfully.");
            });
        }

        // Function to delete a course
        function deleteCourse(id) {
            // Show confirmation dialog before deletion
            var confirmDelete = confirm("Are you sure you want to delete this course?");
            
            if (confirmDelete) {
                var url = "http://localhost:8080/courses/delete/" + id;  // Updated URL for delete API
                callApi("DELETE", url, null, function(response) {
                    console.log("Delete response: ", response);
                    loadCourseData();  // Reload course data
                    alert("Course deleted successfully.");  // Success message
                }, function(error) {
                    console.error("Delete error: ", error);
                    alert("An error occurred while deleting the course.");  // Error message
                });
            } else {
                alert("Deletion canceled.");  // Message if user cancels deletion
            }
        }

        // Load course data on page load
        window.onload = loadCourseData;
    </script>
</body>
</html>
    