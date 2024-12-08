<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Assignment</title>
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

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }

        .content {
            flex: 1;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        form {
            background-color: #ffffff;
            padding: 20px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
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
            background-color: #2980b9;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
        }

        button:hover {
            background-color: #1f618d;
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

        #statusMessage {
            color: green;
            font-weight: bold;
            margin-top: 20px;
            display: none;
        }

        #logoutBtn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 20px;
        }

        #logoutBtn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <header>
        <h1>Submit Your Assignment</h1>
    </header>

    <div class="content">
        <h2>Upload Assignment</h2>

        <!-- Form to submit assignment -->
        <form id="submitForm" enctype="multipart/form-data">
            <label for="file">Select Assignment File (PDF, Word, etc.):</label>
            <input type="file" id="file" name="file" required><br><br>

            <label for="description">Assignment Description:</label>
            <textarea id="description" name="description" rows="4" placeholder="Provide a brief description of your assignment" required></textarea><br><br>

            <button type="submit">Submit Assignment</button>
        </form>

        <!-- Success Message -->
        <div id="statusMessage"></div>

        <!-- Logout Button -->
        <button id="ControlPanel.jsp" onclick="logout()">Logout</button>
    </div>

    <footer>
        <p>&copy; 2024 Student Assignment Submission System. All rights reserved.</p>
    </footer>

    <script>
        document.getElementById("submitForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent the default form submission

            var formData = new FormData(this);

            // Create an AJAX request
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "submitassignment.jsp", true);

            // On success, show a success message
            xhr.onload = function () {
                if (xhr.status === 200) {
                    document.getElementById("statusMessage").textContent = "Your assignment has been submitted successfully!";
                    document.getElementById("statusMessage").style.display = "block";
                } else {
                    document.getElementById("statusMessage").textContent = "There was an error submitting your assignment.";
                    document.getElementById("statusMessage").style.color = "red";
                    document.getElementById("statusMessage").style.display = "block";
                }
            };

            // Send the form data
            xhr.send(formData);
        });

        function logout() {
            // Clear the session (if using session management)
            // This can be done through server-side scripting, for example by invalidating the session in JSP
            // Example: Invalidate session and redirect to login page

            // Redirect to login page (modify this URL as per your setup)
            window.location.href = "ControlPanel.jsp"; // Redirect to the login page or home page
        }
    </script>
</body>
</html>
