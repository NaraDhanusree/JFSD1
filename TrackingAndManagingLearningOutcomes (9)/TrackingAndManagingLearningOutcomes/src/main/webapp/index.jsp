<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - Learning Management System</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            height: 100vh;
            background: linear-gradient(to right, #e1e8f0, #f4f7fc); /* Soft gradient with muted tones */
            display: flex;
            flex-direction: column;
        }

        /* Header styling */
        header {
            background-color: #34495e; /* Deep Grayish Blue */
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 2em;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Main content wrapper */
        .mainContent {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
            padding: 20px;
        }

        /* Login box styling */
        .loginBox {
            background: linear-gradient(135deg, #ffffff, #e2e8f0); /* Gradient for a soft touch */
            padding: 40px;
            width: 100%;
            max-width: 420px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1); /* Enhanced shadow for depth */
            display: flex;
            flex-direction: column;
            align-items: center;
            animation: fadeIn 1s ease-in-out;
        }

        /* Animation for smooth entry */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Form styling */
        h2 {
            font-size: 1.8em;
            color: #2c3e50; /* Darker grayish-blue */
            margin-bottom: 30px;
            text-align: center;
        }

        .form-group {
            width: 100%;
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #7f8c8d; /* Muted gray */
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 14px;
            border: 1px solid #bdc3c7; /* Light Gray border */
            border-radius: 8px;
            font-size: 1em;
            background-color: #ecf0f1; /* Light Gray background for inputs */
            transition: border-color 0.3s ease, background-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #3498db; /* Blue focus effect */
            outline: none;
            background-color: #f4f8fc; /* Lighter background when focused */
        }

        button {
            width: 100%;
            padding: 15px;
            border: none;
            background-color: #3498db; /* Blue for buttons */
            color: white;
            border-radius: 8px;
            font-size: 1.2em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #2980b9; /* Darker blue on hover */
            transform: scale(1.05); /* Slight scaling effect */
        }

        #ack {
            margin-top: 15px;
            color: #e74c3c; /* Red for error messages */
            text-align: center;
            font-size: 0.9em;
        }

        /* Footer styling */
        footer {
            background-color: #34495e; /* Deep Grayish Blue */
            color: white;
            padding: 10px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header>
        Student Learning Management System
    </header>

    <!-- Main Content Section -->
    <div class="mainContent">
        <div class="loginBox">
            <h2>Sign In</h2>

            <!-- Role Selection -->
            <div class="form-group">
                <label>Select Role*</label>
                <select id="roleSelect">
                    <option value="admin">Admin</option>
                    <option value="student">Student</option>
                    <option value="faculty">Faculty</option>
                </select>
            </div>

            <!-- Username Input -->
            <div class="form-group">
                <label>Username*</label>
                <input type="text" id="username" placeholder="Enter your username (for admin, it must be numeric)">
            </div>

            <!-- Password Input -->
            <div class="form-group">
                <label>Password*</label>
                <input type="password" id="password" placeholder="Enter your password">
            </div>

            <!-- Sign In Button -->
            <button onclick="login()">Sign In</button>

            <!-- Error Message -->
            <div id="ack"></div>
        </div>
    </div>

    <!-- Footer Section -->
    <footer>
        &copy; 2024 Student Learning Management System
    </footer>

    <script>
        function login() {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            const role = document.getElementById('roleSelect').value;
            const ack = document.getElementById('ack');

            // Validate form
            if (!username || !password) {
                ack.innerText = "Please fill in all fields!";
                return;
            }

            // Prepare the login request
            const data = JSON.stringify({ username, password });
            let url;

            if (role === "admin") {
                url = "http://localhost:8080/admin/adminlogin";
            } else if (role === "faculty") {
                url = "http://localhost:8080/faculty/facultylogin";
            } else if (role === "student") {
                url = "http://localhost:8080/student/studentlogin";
            }

            // Fetch login request
            fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: data
            })
            .then(response => {
                if (!response.ok) throw new Error("Login failed! Please check your credentials.");
                return response.json();
            })
            .then(res => {
                // Redirect based on role
                if (role === "faculty" && res.facultyId) {
                    sessionStorage.setItem("facultyId", res.facultyId);
                    window.location.href = "FacultyHome.jsp";
                } else if (role === "student" && res.username) {
                    sessionStorage.setItem("username", res.username);
                    window.location.href = "StudentHome.jsp";
                } else if (role === "admin") {
                    window.location.href = "AdminHome.jsp";
                } else {
                    throw new Error("Unexpected error!");
                }
            })
            .catch(err => ack.innerText = err.message);
        }
    </script>
</body>
</html>