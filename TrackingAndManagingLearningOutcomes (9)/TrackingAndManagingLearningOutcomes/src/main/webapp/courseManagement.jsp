<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fb;
            margin: 0;
            padding: 0;
        }

        /* Horizontal Navbar Styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1;
        }

        .navbar a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            font-weight: 600;
            padding: 10px 20px;
            display: inline-block;
            transition: background-color 0.3s, padding-left 0.3s;
        }

        .navbar a:hover {
            background-color: #34495e;
            padding-left: 25px;
        }

        /* Logout Button in Navbar */
        .logout-button {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            text-align: center;
            display: inline-block;
        }

        .logout-button:hover {
            background-color: #c0392b;
        }

        /* Content Styles */
        .content {
            margin-top: 80px; /* Increased margin to make space for the navbar */
            padding: 20px;
        }

        #error {
            color: red;
            font-weight: bold;
            margin: 20px;
        }

        /* Large Course Title Box */
        .course-title-box {
            background-color: #ffffff;
            border: 1px solid #d1d8e0;
            border-radius: 8px;
            width: 60%;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            text-align: center;
            font-size: 24px;
            color: #34495e;
            font-weight: bold;
        }

        .course-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 20px;
        }

        .course-box {
            background-color: #ffffff;
            border: 1px solid #d1d8e0;
            border-radius: 8px;
            width: 40%;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .course-box:hover {
            transform: translateY(-5px);
        }

        .course-box h3 {
            margin: 0;
            color: #34495e;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .course-box, .course-title-box {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- Horizontal Navbar -->
    <div class="navbar">
        <a href="#" onclick="navigateToQuizzes()">Knowledge Checks</a>
        <a href="#" onclick="navigateToHandouts()">Course Material</a>
        <a href="#" onclick="navigateToAssignments()">Take Home Tasks</a>
        <a href="#" onclick="navigateToVideos()">Tutorials</a>
        <a href="#" onclick="navigateToLectures()">Seminars</a>
        <button class="FacultyHome.jsp" onclick="logout()">Logout</button>
    </div>

    <!-- Main Content Area -->
    <div class="content">
        <div class="course-title-box" id="courseTitle">Welcome to course: Loading...</div>
        <div id="error"></div>
        <div id="courseContainer" class="course-container"></div>
    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        // Extract the 'course' parameter from the URL query string
        const urlParams = new URLSearchParams(window.location.search);
        const courseName = urlParams.get('course'); // e.g., 'CSE'

        if (courseName) {
            // Display the course name at the top
            const courseTitleElement = document.getElementById("courseTitle");
            courseTitleElement.textContent = "Welcome to course: " + courseName;
        } else {
            const errorElement = document.getElementById("error");
            errorElement.textContent = "Course information is missing.";
        }
    });

    function navigateToQuizzes() {
        location.replace("quizzes.html");
    }

    function navigateToHandouts() {
        const urlParams = new URLSearchParams(window.location.search);
        const courseName = urlParams.get('course');

        if (courseName) {
            window.location.href = "/handouts.jsp?course=" + encodeURIComponent(courseName);
        } else {
            alert("Course information is missing.");
        }
    }

    function navigateToAssignments() {const urlParams = new URLSearchParams(window.location.search);
    const courseName = urlParams.get('course');

    if (courseName) {
        window.location.href = "/assignments.jsp?course=" + encodeURIComponent(courseName);
    } else {
        alert("Course information is missing.");
    }
    }

    function navigateToVideos() {
        location.replace("videos.html");
    }

    function navigateToLectures() {
        location.replace("lectures.html");
    }

    function logout() {
        // Redirect to the logout URL or perform any logout action
        alert("You have logged out.");
        window.location.href = "/FacultyHome.jsp"; // Adjust the URL based on your logout path
    }
    </script>
</body>
</html>
