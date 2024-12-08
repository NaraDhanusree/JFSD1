<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="css/styles.css" />
    <style>
        /* General reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            background-color: #f0f4f8;
            color: #333;
            display: flex;
            flex-direction: column;
        }

        /* Top navigation bar styling */
        .navbar {
            background-color: #2c3e50; /* Dark blue */
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar h2 {
            font-size: 1.5em;
            font-weight: bold;
        }

        .menu {
            display: flex;
            justify-content: space-around;
            width: 50%;
        }

        .menu-item {
            padding: 12px 20px;
            margin: 0 10px;
            background-color: #34495e; /* Slightly lighter blue */
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-align: center;
            font-size: 1em;
            color: white;
        }

        .menu-item:hover {
            background-color: #1abc9c; /* Teal hover color */
        }

        .menu-item:active {
            background-color: #16a085;
        }

        /* Logout button styling */
        .logout-btn {
            background-color: #e74c3c;
            border-radius: 8px;
            padding: 12px 20px;
            text-align: center;
            cursor: pointer;
            font-size: 1em;
            color: white;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        /* Main content styling */
        .main-content {
            padding: 40px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            width: 80%;
            flex-grow: 1;
            overflow-y: auto;
            text-align: center;
        }

        .main-content h1 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #2980b9; /* Deep blue */
        }

        .main-content p {
            font-size: 1.1em;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        /* Info Box */
        .info-box {
            background-color: #f9f9f9;
            border: 1px solid #e1e1e1;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <!-- Top Navigation Bar Section -->
    <div class="navbar">
        <h2>Admin Control Panel</h2>
        <div class="menu">
            <div class="menu-item" onclick="navigateTo('Student')">Manage Students</div>
            <div class="menu-item" onclick="navigateTo('faculty')">Manage Faculty</div>
            <div class="menu-item" onclick="navigateTo('Courses')">Manage Courses</div>
            <div class="menu-item" onclick="navigateTo('Mapping')">Course Mapping</div>
        </div>
        <div class="logout-btn" onclick="navigateTo('Logout')">Logout</div>
    </div>

   <!-- Main Content Section -->
<div class="main-content">
    <h1>Welcome, Admin!</h1>
    <p>As the administrator of the system, you have full control over the management of various critical aspects of the institution’s academic operations. The dashboard is designed to offer you a centralized location where you can oversee and manage students, faculty, courses, and their assignments. With just a few clicks, you can ensure that everything runs smoothly and that the academic programs continue without any disruptions.</p>
    
    
</div>
   

    <script>
        function navigateTo(section) {
            if (section === 'Student') {
                location.replace("/AdminStudent.jsp");
            } else if (section === 'faculty') {
                location.replace("/Adminfaculty.jsp");
            } else if (section === 'Courses') {
                location.replace("/AdminCourse.jsp");
            } else if (section === 'Mapping') {
                location.replace("/AdminMapping.jsp");
            } else if (section === 'Logout') {
                location.replace("/index.jsp");
            }
        }
    </script>
</body>
</html>