<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Home</title>
    <style>
        /* Your existing styles */
    </style>
</head>
<body>
    <h2>Manage Quizzes for Course: <span id="courseName"></span></h2>

    <div id="error" style="color: red;"></div>
    <div id="quizContainer" class="course-container"></div>

    <button onclick="createnewquiz()">Create New Quiz</button>

<script>
    // Declare the createnewquiz function outside of the DOMContentLoaded event listener
    function createnewquiz() {
        const courseId = new URLSearchParams(window.location.search).get('courseid');
        window.location.href = "/createquiz.jsp?courseid=" + encodeURIComponent(courseId);
    }

    document.addEventListener("DOMContentLoaded", function () {
        const courseName = new URLSearchParams(window.location.search).get('course');
        const courseId = new URLSearchParams(window.location.search).get('courseid');  // Get the course ID as well
        document.getElementById("courseName").textContent = courseName;

        // Fetch the quizzes for this course
        fetch(`http://localhost:8080/quiz/byCourse?courseid=${courseId}`)
            .then(response => response.json())
            .then(data => {
                if (data && data.length > 0) {
                    const quizContainer = document.getElementById("quizContainer");
                    data.forEach(quiz => {
                        const quizElement = document.createElement("div");
                        quizElement.classList.add("quiz-box");
                        
                        const quizTitle = document.createElement("h3");
                        quizTitle.textContent = quiz.quizName;

                        const quizDescription = document.createElement("p");
                        quizDescription.textContent = quiz.quizDescription;

                        const deleteButton = document.createElement("button");
                        deleteButton.textContent = "Delete Quiz";
                        deleteButton.onclick = () => deleteQuiz(quiz.quizId);

                        const updateButton = document.createElement("button");
                        updateButton.textContent = "Update Quiz";
                        updateButton.onclick = () => navigateToUpdateQuizPage(quiz.quizId);

                        quizElement.appendChild(quizTitle);
                        quizElement.appendChild(quizDescription);
                        quizElement.appendChild(updateButton);
                        quizElement.appendChild(deleteButton);

                        quizContainer.appendChild(quizElement);
                    });
                } else {
                    document.getElementById("error").textContent = "No quizzes found for this course.";
                }
            })
            .catch(error => {
                document.getElementById("error").textContent = "Failed to load quizzes. Please try again later.";
            });

        function deleteQuiz(quizId) {
            if (confirm("Are you sure you want to delete this quiz?")) {
                fetch(`http://localhost:8080/quiz/delete?quizid=${quizId}`, {
                    method: 'DELETE',
                })
                .then(response => response.text())
                .then(message => {
                    alert(message);
                    window.location.reload();
                })
                .catch(error => {
                    alert("Failed to delete quiz.");
                });
            }
        }

        function navigateToUpdateQuizPage(quizId) {
            window.location.href = "/updateQuiz.jsp?quizid=" + quizId;
        }
    });
</script>

</body>
</html>
