<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Faculties</title>
    <link rel="stylesheet" type="text/css" href="css/faculty.css">
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
            <li><a href="Adminfaculty.jsp">Dashboard</a></li>
            <li><a href="#">ALL FACULTIES</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="container">
        <table id="facultyTable">
            <thead>
                <tr>
                    <th>Faculty ID</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="facultyData">
                <!-- Data will be populated here using JavaScript -->
            </tbody>
        </table>

        <!-- Update Form (Initially Hidden) -->
        <div id="updateForm">
            <h3>Update Faculty</h3>
            <form id="facultyUpdateForm">
                <label for="updateName">Name:</label><br>
                <input type="text" id="updateName" name="updateName"><br>

                <label for="updateDepartment">Department:</label><br>
                <input type="text" id="updateDepartment" name="updateDepartment"><br>

                <label for="updateEmail">Email:</label><br>
                <input type="email" id="updateEmail" name="updateEmail"><br>
                
                <label for="updatePassword">Password:</label><br>
                <input type="password" id="updatePassword" name="updatePassword" required><br>

                <!-- Hidden input to store Faculty ID -->
                <input type="hidden" id="updateId" name="updateId">

                <br>
                <button type="button" onclick="submitUpdate()">Submit Update</button>
            </form>
        </div>
    </div>

    <!-- Script to handle API calls and update functionality -->
    <script type="text/javascript" src="js/main.js"></script>
    <script type="text/javascript">
        // Function to fetch all faculty data from the backend
        function loadFacultyData() {
            var url = "http://localhost:8080/faculty/readAll";
            console.log("Loading faculty data from: ", url); // API endpoint to get all faculties
            callApi("GET", url, null, displayFacultyData);  // Call API using callApi() method defined in main.js
        }

        // Callback function to display faculty data in the table
        function displayFacultyData(response) {
            console.log("Received faculty data: ", response);
            var facultyData = JSON.parse(response);  // Parse JSON response
            var facultyTable = document.getElementById("facultyData");

            // Clear existing table rows
            facultyTable.innerHTML = "";

            // Populate table with faculty data
            facultyData.forEach(function(faculty) {
                var row = "<tr>" +
                            "<td>" + faculty.facultyid + "</td>" +
                            "<td>" + faculty.name + "</td>" +
                            "<td>" + faculty.department + "</td>" +
                            "<td>" + faculty.email + "</td>" +
                            "<td>" + faculty.password + "</td>" +
                            "<td>" +
                                "<button class='update-btn' onclick='populateUpdateForm(" + JSON.stringify(faculty) + ")'>Update</button>" +
                                "<button class='delete-btn' onclick='deleteFaculty(" + faculty.facultyid + ")'>Delete</button>" +
                            "</td>" +
                          "</tr>";
                facultyTable.innerHTML += row;
            });
        }

        // Function to populate update form with selected faculty's data
        function populateUpdateForm(faculty) {
            document.getElementById("updateName").value = faculty.name;
            document.getElementById("updateDepartment").value = faculty.department;  // Populate department
            document.getElementById("updateEmail").value = faculty.email;
            document.getElementById("updateId").value = faculty.facultyid;
            document.getElementById("updatePassword").value = faculty.password;

            // Show the update form
            document.getElementById("updateForm").style.display = "block";
        }

        // Function to submit update form
        function submitUpdate() {
            var updateId = document.getElementById("updateId").value;
            var updatedName = document.getElementById("updateName").value;
            var updatedDepartment = document.getElementById("updateDepartment").value;  // Get department
            var updatedEmail = document.getElementById("updateEmail").value;
            var updatedPassword = document.getElementById("updatePassword").value;

            // Create the update data object
            var updateData = {
                facultyid: updateId,
                name: updatedName,
                department: updatedDepartment,
                email: updatedEmail,
                password: updatedPassword
            };

            var updateUrl = "http://localhost:8080/faculty/update"; // API endpoint for update

            // Call API with proper headers for JSON format
            callApi("PUT", updateUrl, JSON.stringify(updateData), function(response) {
                alert("Faculty updated successfully.");
                loadFacultyData(); // Reload data after update
                document.getElementById("updateForm").style.display = "none"; // Hide update form after update
            });
        }

        // Load faculty data when the page is loaded
        window.onload = loadFacultyData;
        // Function to delete a faculty by ID
        function deleteFaculty(facultyid) {
            var deleteUrl = "http://localhost:8080/faculty/delete?facultyid=" + facultyid; // API endpoint for delete
            if (confirm("Are you sure you want to delete this faculty?")) {
                callApi("DELETE", deleteUrl, null, function(response) {
                    alert("Faculty deleted successfully.");
                    loadFacultyData(); // Reload data after deletion
                });
            }
        }

        // Load faculty data when the page loads
        window.onload = function() {
            loadFacultyData();
        };
    </script>



</body>
</html>