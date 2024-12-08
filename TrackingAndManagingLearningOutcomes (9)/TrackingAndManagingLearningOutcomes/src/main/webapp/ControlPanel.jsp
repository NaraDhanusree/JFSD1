<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Control Panel</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fb;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header Styles */
        header {
            background-color: #2c3e50; /* Professional dark blue */
            color: white;
            padding: 20px;
            text-align: center;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            color: white;
            margin: 0;
        }

        .logout-button {
            background-color: #e74c3c; /* Red for logout */
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
            text-decoration: none;
        }

        .logout-button:hover {
            background-color: #c0392b;
        }

        /* Content Area */
        .content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h2 {
            color: #34495e;
        }

        .panel-options {
            display: flex;
            justify-content: space-around;
            width: 100%;
            max-width: 900px;
            margin-top: 30px;
        }

        .panel-option {
            background-color: #ffffff;
            padding: 20px;
            width: 30%;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .panel-option:hover {
            background-color: #ecf0f1;
        }

        .panel-option h3 {
            color: #2c3e50;
            margin-bottom: 15px;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 10px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <h1>Student Control Panel</h1>
        <a href="StudentHome.jsp" class="logout-button">Logout</a>
    </header>

    <!-- Content Area -->
    <div class="content">
        <h2>Welcome to Your Control Panel</h2>

        <div class="panel-options">
            <div class="panel-option" onclick="window.location.href='/viewmaterials.jsp'">
                <h3>View Materials</h3>
                <p>Access all course materials posted by instructors.</p>
            </div>

            <div class="panel-option" onclick="window.location.href='/submitmaterial.jsp'">
                <h3>Submit Materials</h3>
                <p>Upload your own materials or assignments for submission.</p>
            </div>

            <div class="panel-option" onclick="window.location.href='/account-settings'">
                <h3>Account Settings</h3>
                <p>Manage your account details and preferences.</p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Student Management System. All rights reserved.</p>
    </footer>

</body>
</html>
