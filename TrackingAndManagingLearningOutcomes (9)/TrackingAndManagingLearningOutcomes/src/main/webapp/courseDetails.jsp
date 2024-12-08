<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Details</title>
</head>
<body>
    <h2>${course.coursename}</h2>
    <p>${course.coursedescription}</p>

    <h3>Quizzes</h3>
    <ul>
        <c:forEach var="quiz" items="${quizzes}">
            <li>${quiz.quizname} - ${quiz.quizdescription}</li>
        </c:forEach>
    </ul>

    <h3>Handouts</h3>
    <ul>
        <c:forEach var="handout" items="${handouts}">
            <li>${handout.handoutname} - <a href="${handout.handoutfile}" target="_blank">Download</a></li>
        </c:forEach>
    </ul>
</body>
</html>
