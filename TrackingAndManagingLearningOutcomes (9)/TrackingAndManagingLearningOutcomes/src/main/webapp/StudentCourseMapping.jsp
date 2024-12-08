<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student-Course Mapping</title>
    <style>
        /* Reset some default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Set body styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            color: #333;
            display: flex;
            flex-direction: column;
        }

        /* Navbar Styling */
        .navbar {
            width: 100%;
            background-color: #34495E;  /* Dark Grayish Blue */
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .navbar h1 {
            font-size: 1.8rem;
            color: #ECF0F1;
        }

        .navbar ul {
            list-style-type: none;
            display: flex;
            gap: 20px;
        }

        .navbar ul li {
            margin: 0;
        }

        .navbar ul li a {
            color: #ECF0F1;
            text-decoration: none;
            font-size: 1.1rem;
            padding: 8px 12px;
            border-radius: 5px;
            display: block;
            transition: background-color 0.3s;
        }

        .navbar ul li a:hover {
            background-color: #1ABC9C;  /* Soft Green */
        }

        /* Content Section */
        .content {
            margin: 40px auto;
            padding: 20px;
            width: 80%;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 20px;
            color: #2980B9;  /* Bright Blue */
        }

        label {
            font-size: 1.1rem;
            margin-bottom: 10px;
            display: inline-block;
            color: #2C3E50;  /* Dark Blue */
        }

        select {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            margin-bottom: 20px;
            border: 1px solid #BDC3C7;
            border-radius: 5px;
            background-color: #ECF0F1; /* Light Gray */
        }

        button {
            background-color: #2980B9;  /* Bright Blue */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #3498DB;  /* Lighter Blue */
        }

        /* Responsive Layout for Smaller Screens */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar ul {
                flex-direction: column;
                gap: 10px;
            }

            .form-container {
                width: 90%;
            }

            .content {
                width: 95%;
            }
        }
    </style>
    <script>
        // Function to populate students and courses when the page loads
        window.onload = function() {
            fetch('/studentcourse/api/mapping/students')
                .then(response => response.json())
                .then(students => {
                    const studentSelect = document.getElementById('studentId');
                    students.forEach(student => {
                        const option = document.createElement('option');
                        option.value = student.id;
                        option.text = student.id;  // Display student ID only
                        studentSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching students:', error));

            fetch('/studentcourse/api/mapping/courses')
                .then(response => response.json())
                .then(courses => {
                    const coursesSelect = document.getElementById('courseId');
                    courses.forEach(course => {
                        const option = document.createElement('option');
                        option.value = course.courseid;  // Corrected to use course.courseid
                        option.text = course.courseid;   // Corrected to use course.courseid
                        coursesSelect.appendChild(option);
                    });
                })
                .catch(error => console.error('Error fetching courses:', error));
        };

        // Function to handle form submission for mapping
        function submitMapping() {
            const studentId = document.getElementById('studentId').value;
            const courseId = document.getElementById('courseId').value;

            // Log the values to make sure you're sending the correct data
            console.log('Sending studentId:', studentId, 'courseId:', courseId);

            // Create the payload as JSON
            const payload = {
                studentId: studentId,
                courseId: courseId
            };

            // Send the request with proper headers and body
            fetch('/studentcourse/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',  // Ensure the Content-Type is set to application/json
                },
                body: JSON.stringify(payload)  // Convert the payload to JSON string
            })
            .then(response => response.json())
            .then(data => {
                if (data) {
                    alert('Mapping added successfully!');
                } else {
                    alert('Error in adding mapping!');
                }
            })
            .catch(error => {
                console.error('Error occurred while adding mapping:', error);
                alert('Error occurred while adding mapping!');
            });
        }
    </script>
</head>
<body>

    <!-- Horizontal Navbar -->
    <div class="navbar">
        <h1>Admin Dashboard</h1>
        <ul>
            <li><a href="AdminStudent.jsp">Student</a></li>
       
            <li><a href="AdminCourse.jsp">Courses</a></li>
            <li><a href="AdminMapping.jsp">Mappings</a></li>
            <li><a href="#" onclick="BACK_HOME_PAGE()">Back to Admin Home Page</a></li>
        </ul>
    </div>

    <!-- Main Content Section -->
    <div class="content">
        <h2>Map Student to Course</h2>
        <form id="mappingForm">
            <label for="studentId">Select Student ID:</label>
            <select id="studentId" name="studentId">
                <!-- The list of student IDs will be dynamically populated by JavaScript -->
            </select>

            <label for="courseId">Select Course ID:</label>
            <select id="courseId" name="courseId">
                <!-- The list of course IDs will be dynamically populated by JavaScript -->
            </select>

            <button type="button" onclick="submitMapping()">Submit</button>
        </form>
    </div>

</body>
<script type="text/javascript">
function BACK_HOME_PAGE() {
    location.replace("/AdminHome.jsp");
}
</script>
</html>