<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Quiz</title>
    <style>
        /* Add your existing styles here */
    </style>
</head>
<body>
    <h2>Create New Quiz for Course: <span id="courseName"></span></h2>

    <form id="createQuizForm">
        <input type="text" id="quizName" placeholder="Quiz Name" required><br><br>
        <textarea id="quizDescription" placeholder="Quiz Description" required></textarea><br><br>

        <h3>Questions</h3>
        <div id="questionsContainer"></div>

        <button type="button" onclick="addQuestion()">Add Question</button><br><br>
        
        <button type="submit">Create Quiz</button>
    </form>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Retrieve courseid and course from the URL
            const urlParams = new URLSearchParams(window.location.search);
            const courseId = urlParams.get('courseid');
            const courseName = urlParams.get('course');

            console.log("Course ID from URL:", courseId);
            console.log("Course Name from URL:", courseName);

            // Check if courseId is available and valid
            if (!courseId) {
                console.log("Error: courseid is missing or invalid!");
                alert("Course ID is missing or invalid!");
                return;  // Stop execution if courseId is not valid
            } else {
                document.getElementById("courseName").textContent = courseName || "Unknown Course";  // Show course name if available
            }

            // Handle form submission
            document.getElementById("createQuizForm").addEventListener("submit", function(event) {
                event.preventDefault();

                const quizName = document.getElementById("quizName").value;
                const quizDescription = document.getElementById("quizDescription").value;

                const questions = [];

                // Collect all questions and their options
                document.querySelectorAll(".question").forEach((questionElement) => {
                    const questionText = questionElement.querySelector(".questionText").value;
                    const options = [];
                    questionElement.querySelectorAll(".option").forEach(optionElement => {
                        options.push(optionElement.value);
                    });

                    questions.push({
                        questionText: questionText,
                        options: options
                    });
                });

                // Prepare quiz data to send to the server
                const quizData = {
                    quizName: quizName,
                    quizDescription: quizDescription,
                    course: { courseid: courseId }, // Passing numeric courseId
                    questions: questions
                };

                // Send quiz data to the backend
                fetch("http://localhost:8080/quiz/add", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(quizData)
                })
                .then(response => response.text())
                .then(message => {
                    alert(message);
                    window.location.href = "/quizHome.jsp?courseid=" + encodeURIComponent(courseId) + "&course=" + encodeURIComponent(courseName);
                })
                .catch(error => {
                    alert("Failed to create quiz.");
                    console.log("Error in fetch:", error);
                });
            });
        });

        function addQuestion() {
            const questionsContainer = document.getElementById("questionsContainer");

            const questionDiv = document.createElement("div");
            questionDiv.classList.add("question");

            const questionTextInput = document.createElement("input");
            questionTextInput.type = "text";
            questionTextInput.placeholder = "Enter question text";
            questionTextInput.classList.add("questionText");

            const optionInput1 = document.createElement("input");
            optionInput1.type = "text";
            optionInput1.placeholder = "Option 1";

            const optionInput2 = document.createElement("input");
            optionInput2.type = "text";
            optionInput2.placeholder = "Option 2";

            const optionInput3 = document.createElement("input");
            optionInput3.type = "text";
            optionInput3.placeholder = "Option 3";

            const optionInput4 = document.createElement("input");
            optionInput4.type = "text";
            optionInput4.placeholder = "Option 4";

            questionDiv.appendChild(questionTextInput);
            questionDiv.appendChild(optionInput1);
            questionDiv.appendChild(optionInput2);
            questionDiv.appendChild(optionInput3);
            questionDiv.appendChild(optionInput4);

            questionsContainer.appendChild(questionDiv);
        }
    </script>
</body>
</html>
