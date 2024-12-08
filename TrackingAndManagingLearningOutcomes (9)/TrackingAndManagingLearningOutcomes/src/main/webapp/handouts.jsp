<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Materials</title>
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

        /* Title Color in Header */
        header h1 {
            color: white; /* Title in white */
            margin: 0;
        }

        /* Logout button styling */
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

        /* Footer Styles */
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

        /* Content Area */
        .content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #34495e; /* Professional grey for headers */
        }

        label {
            font-weight: bold;
            color: #2c3e50;
        }

        input, textarea {
            margin: 10px 0;
            padding: 10px;
            width: 100%;
            max-width: 500px;
            border: 1px solid #bdc3c7;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            background-color: #2980b9; /* Professional blue for buttons */
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #1f618d;
        }

        /* Form styling */
        form {
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #d1d8e0;
            border-radius: 8px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <h1>Post Handouts for Courses</h1> <!-- Title in white -->
        <a href="FacultyHome.jsp" class="logout-button">Logout</a>
    </header>

    <!-- Content Area -->
    <div class="content">
        <h1>Submit Reading Materials: <span id="courseTitle"></span></h1>

        <!-- Form to upload handout -->
        <form id="uploadForm" action="" method="post" enctype="multipart/form-data">
            <label for="file">Select Study Material File:</label>
            <input type="file" id="file" name="file" required><br><br>

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" cols="50"></textarea><br><br>

            <button type="submit">Submit Post Material</button>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p id="footerMessage">&copy; 2024 Handout Management System. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Extract the 'course' parameter from the URL query string
            const urlParams = new URLSearchParams(window.location.search);
            const courseName = urlParams.get('course'); // e.g., 'PFSD'

            if (courseName) {
                // Display the course name at the top
                const courseTitleElement = document.getElementById("courseTitle");
                courseTitleElement.textContent = courseName;

                // Update the form action dynamically with the course name
                const form = document.getElementById("uploadForm");
                form.action = "/handouts/upload/" + courseName;  // Set the action to include the course name
            } else {
                // Display an error message if the course name is missing
                const errorElement = document.getElementById("status");
                errorElement.textContent = "Course information is missing.";
                errorElement.style.color = "red";
            }
        });

        // Form submission event
        document.getElementById("uploadForm").addEventListener("submit", function(event) {
            event.preventDefault();  // Prevent actual form submission for demo

            // After form submission, show success message ONLY in the footer
            const courseName = document.getElementById("courseTitle").textContent;
            if (courseName) {
                // Display the success message ONLY in the footer
                document.getElementById("footerMessage").innerHTML = "Handout uploaded successfully for course: " + courseName;
            }
        });
    </script>
</body>
</html>
