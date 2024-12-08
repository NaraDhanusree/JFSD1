<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Assignment</title>
    <style>
        /* General Body Styles */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fafafa;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        /* Navbar Styling */
        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #00796b;
            padding: 16px 32px;
            color: white;
            font-weight: 600;
        }

        nav .brand {
            font-size: 24px;
            text-transform: uppercase;
        }

        .logout {
            font-size: 14px;
            color: white;
            text-decoration: none;
            background-color: #004d40;
            padding: 6px 12px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .logout:hover {
            background-color: #00695c;
        }

        /* Page Header */
        h1 {
            text-align: center;
            margin-top: 50px;
            font-size: 30px;
            color: #333;
        }

        /* Form Styling */
        form {
            max-width: 700px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-top: 3px solid #00796b;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 16px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"], input[type="file"], input[type="date"], textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="file"]:focus, input[type="date"]:focus, textarea:focus {
            border-color: #00796b;
            outline: none;
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        button {
            background-color: #00796b;
            color: white;
            border: none;
            padding: 12px 24px;
            cursor: pointer;
            font-size: 18px;
            border-radius: 6px;
            width: 100%;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #004d40;
        }

        /* Error Message Styling */
        #status {
            text-align: center;
            color: red;
            margin-top: 20px;
            font-size: 16px;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            form {
                padding: 20px;
                width: 90%;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav>
        <div class="brand">Academic Portal</div>
        <a class="logout" href="/FacultyHome.jsp">Logout</a>
    </nav>

    <h1>Home Tasks for Course: <span id="courseTitle"></span></h1>

    <!-- Form to upload assignment -->
    <form id="uploadForm" action="" method="post" enctype="multipart/form-data">
        <label for="title">Assignment Title:</label>
        <input type="text" id="title" name="title" required>
    
        <label for="file">Select Assignment File:</label>
        <input type="file" id="file" name="file" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" placeholder="Enter assignment description"></textarea>

        <label for="startDate">Start Date:</label>
        <input type="date" id="startDate" name="startDate" required>

        <label for="endDate">End Date:</label>
        <input type="date" id="endDate" name="endDate" required>

        <button type="submit">Upload Assignment</button>
    </form>

    <div id="status"></div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const courseName = urlParams.get('course');

            if (courseName) {
                const courseTitleElement = document.getElementById("courseTitle");
                courseTitleElement.textContent = courseName;

                const form = document.getElementById("uploadForm");
                form.action = "/assignments/upload/" + courseName;
            } else {
                const errorElement = document.getElementById("status");
                errorElement.textContent = "Course information is missing.";
                errorElement.style.color = "red";
            }

            const form = document.getElementById("uploadForm");
            form.addEventListener("submit", function(event) {
                const startDate = document.getElementById("startDate").value;
                const endDate = document.getElementById("endDate").value;

                if (new Date(startDate) > new Date(endDate)) {
                    event.preventDefault();
                    const statusElement = document.getElementById("status");
                    statusElement.textContent = "End date must be later than start date.";
                    statusElement.style.color = "red";
                }
            });
        });
    </script>
</body>
</html>
