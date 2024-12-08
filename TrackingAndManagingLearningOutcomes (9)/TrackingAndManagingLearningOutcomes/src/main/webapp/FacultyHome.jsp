<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Courses</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            margin-left: 250px; /* Space for the vertical nav */
        }

        /* Vertical Navigation Bar Styles */
        nav {
            display: flex;
            flex-direction: column;
            background-color: #2c3e50;
            padding: 20px;
            color: white;
            height: 100vh; /* Full height of the viewport */
            width: 250px; /* Fixed width for the vertical nav */
            position: fixed;
            top: 0;
            left: 0;
            box-shadow: 4px 0 6px rgba(0, 0, 0, 0.1);
        }

        nav .brand {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 40px;
            color: #ecf0f1;
        }

        nav ul {
            list-style-type: none;
            padding: 0;
            width: 100%;
        }

        nav ul li {
            margin: 20px 0;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            padding: 10px 15px;
            display: block;
            transition: background-color 0.3s, padding-left 0.3s;
        }

        nav ul li a:hover {
            background-color: #34495e;
            padding-left: 25px; /* Shift slightly to the right on hover */
        }

        #error {
            color: red;
            font-weight: bold;
            margin: 20px;
        }

        .course-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
            padding: 50px 30px;
            background-color: #ffffff;
        }

        .course {
            background: linear-gradient(to right, #3498db, #8e44ad);
            padding: 20px 30px;
            border-radius: 5px;
            color: white;
            font-size: 20px;
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease-in-out;
        }

        .course:hover {
            transform: translateY(-5px);
            background: linear-gradient(to right, #8e44ad, #3498db); /* Swap colors on hover */
        }

        .course h3 {
            margin: 0;
            font-size: 24px;
        }

        .manage-button {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .manage-button:hover {
            background-color: #c0392b;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            nav {
                width: 200px;
            }

            body {
                margin-left: 200px;
            }

            .course {
                font-size: 18px;
            }
        }

        @media (max-width: 480px) {
            nav {
                width: 180px;
            }

            body {
                margin-left: 180px;
            }

            .course {
                font-size: 16px;
                flex-direction: column;
                align-items: flex-start;
            }

            .manage-button {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
        <div class="brand">Academic Portal</div>
        <ul>
            <li><a href="#dashboard">Control Panel</a></li>
            <li><a href="#courses">Curriculum</a></li>
            <li><a href="#profile">Portfolio</a></li>
            <li><a href="index.jsp" onclick="handleLogout()">Logout</a></li>
        </ul>
    </nav>

    <div id="error"></div>
    <div id="courseContainer" class="course-container"></div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        const facultyId = sessionStorage.getItem("facultyId");

        if (!facultyId || facultyId.trim() === "") {
            const errorElement = document.getElementById("error");
            errorElement.textContent = "Invalid faculty ID. Please log in again.";
            return;
        }

        const sanitizedFacultyId = facultyId.trim().replace(/\D/g, '');

        if (!sanitizedFacultyId) {
            const errorElement = document.getElementById("error");
            errorElement.textContent = "Invalid faculty ID. Please log in again.";
            return;
        }

        const baseUrl = 'http://localhost:8080/facultycourse/api/mapping/faculty';
        let fullUrl = baseUrl + '/' + sanitizedFacultyId + '/courses';

        fetch(fullUrl)
            .then(response => response.json())
            .then(data => {
                if (data.courses && data.courses.length > 0) {
                    const courseContainer = document.getElementById("courseContainer");
                    data.courses.forEach(course => {
                        const courseElement = document.createElement("div");
                        courseElement.classList.add("course");

                        const courseTitle = document.createElement("h3");
                        courseTitle.textContent = course;

                        const manageButton = document.createElement("button");
                        manageButton.textContent = "Manage";
                        manageButton.classList.add("manage-button");
                        manageButton.onclick = () => navigateToCourseManagement(course);

                        courseElement.appendChild(courseTitle);
                        courseElement.appendChild(manageButton);

                        courseContainer.appendChild(courseElement);
                    });
                } else {
                    throw new Error("No courses assigned to this faculty.");
                }
            })
            .catch(error => {
                const errorElement = document.getElementById("error");
                errorElement.textContent = "Failed to load courses. Please try again later.";
            });

        function navigateToCourseManagement(course) {
            // Redirect to the course management page for the selected course
            window.location.href = "/courseManagement.jsp?course=" + encodeURIComponent(course);
        }

        function handleLogout() {
            sessionStorage.clear();
            alert("You have been logged out.");
            window.location.href = "index.jsp"; // Redirect to login page
        }
    });
    </script>
</body>
</html>
