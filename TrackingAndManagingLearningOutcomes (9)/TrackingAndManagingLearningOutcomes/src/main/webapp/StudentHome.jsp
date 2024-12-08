<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <style>
        /* General Body Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            margin-left: 250px; /* Push content to make space for the vertical nav */
        }

        /* Vertical Navigation Bar Styles */
        nav {
            display: flex;
            flex-direction: column; /* Change to vertical layout */
            align-items: flex-start; /* Align items to the left */
            background-color: #2c3e50; /* Professional dark navy blue */
            padding: 20px;
            color: white;
            height: 100vh; /* Full height of the viewport */
            width: 250px; /* Set a fixed width for the vertical nav */
            position: fixed; /* Keep the nav fixed on the side */
            top: 0;
            left: 0;
            box-shadow: 4px 0 6px rgba(0, 0, 0, 0.1);
        }

        nav .brand {
            font-size: 24px;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 40px; /* Add spacing below the brand */
        }

        nav ul {
            display: flex;
            flex-direction: column; /* Vertical list */
            width: 100%;
            padding: 0;
        }

        nav ul li {
            margin: 10px 0; /* Add space between each menu item */
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-size: 18px;
            font-weight: bold;
            padding: 10px 15px;
            width: 100%;
            display: block; /* Make the links block-level elements */
            transition: color 0.3s ease, transform 0.2s ease;
        }

        nav ul li a:hover {
            color: #18bc9c; /* Muted teal hover effect */
            transform: translateX(10px); /* Move slightly to the right on hover */
        }

        /* Error Message Styling */
        #error {
            color: #e74c3c; /* Professional red for error */
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
        }

        /* Course List Styles */
        #courseList {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
            margin: 20px;
            list-style-type: none;
        }

        #courseList li {
            margin: 15px;
            padding: 20px 30px;
            border-radius: 10px;
            background-color: #34495e; /* Professional dark greyish blue */
            color: white;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            text-transform: capitalize;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.15);
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s, box-shadow 0.3s;
        }

        #courseList li:hover {
            background-color: #2c3e50; /* Darker on hover */
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
        }

        /* Responsive Styling */
        @media (max-width: 768px) {
            nav {
                width: 200px;
            }

            body {
                margin-left: 200px;
            }

            nav .brand {
                font-size: 20px;
            }

            nav ul li a {
                font-size: 16px;
            }

            #courseList li {
                font-size: 16px;
                padding: 15px 20px;
            }
        }

        @media (max-width: 480px) {
            nav {
                width: 180px;
            }

            body {
                margin-left: 180px;
            }

            nav ul li a {
                font-size: 14px;
            }

            #courseList li {
                font-size: 14px;
                padding: 12px 18px;
                width: 80%;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
        <div class="brand">Student Access Center</div>
        <ul>
            <li><a href="ControlPanel.jsp">Control Panel</a></li>
            <li><a href="Curriculum.html">Curriculum</a></li>
            <li><a href="#profile">Portfolio</a></li>
            <li><a href="index.jsp" onclick="handleLogout()">Logout</a></li>
        </ul>
    </nav>

    <!-- Error Messages -->
    <div id="error"></div>

    <!-- Course List -->
    <ul id="courseList"></ul>

    <script>
        // Handle Logout Function
        function handleLogout() {
            sessionStorage.clear();
            alert("You have been logged out.");
            window.location.href = "index.jsp"; // Redirect to login page
        }

        // JavaScript for fetching and displaying courses
        document.addEventListener("DOMContentLoaded", function () {
            const username = sessionStorage.getItem('username');
            console.log("Raw Username from sessionStorage:", username);

            if (!username || username.trim() === "") {
                const errorElement = document.getElementById("error");
                if (errorElement) {
                    errorElement.textContent = "Invalid username. Please log in again.";
                }
                return;
            }

            const sanitizedUsername = username.trim().replace(/\D/g, '');
            console.log("Sanitized Username:", sanitizedUsername);

            if (!sanitizedUsername) {
                const errorElement = document.getElementById("error");
                if (errorElement) {
                    errorElement.textContent = "Invalid username after sanitization. Please log in again.";
                }
                return;
            }

            const baseUrl = 'http://localhost:8080/studentcourse/api/mapping/student';
            let fullUrl = baseUrl + '/' + sanitizedUsername + '/courses';

            console.log("Manually constructed URL:", fullUrl);

            fetch(fullUrl)
                .then(response => {
                    if (!response.ok) {
                        return response.text().then(text => {
                            console.error(`Error response from server: ${text}`);
                            throw new Error(`Failed to fetch courses (status: ${response.status}). Response: ${text}`);
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Fetched data:", data);

                    if (data.courses && data.courses.length > 0) {
                        const courseList = document.getElementById("courseList");
                        if (courseList) {
                            data.courses.forEach(course => {
                                const li = document.createElement("li");
                                li.textContent = course; // Assuming the course name is a string
                                li.onclick = () => alert(`You clicked on ${course}`); // Add click event
                                courseList.appendChild(li);
                            });
                        }
                    } else {
                        throw new Error("No courses assigned to this student.");
                    }
                })
                .catch(error => {
                    console.error("Error fetching courses:", error);
                    const errorElement = document.getElementById("error");
                    if (errorElement) {
                        errorElement.textContent = "Failed to load courses. Please try again later.";
                    }
                });
        });
    </script>
</body>
</html>
