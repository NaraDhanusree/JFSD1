package klu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import klu.model.Quiz;
import klu.model.QuizManager;
import java.util.List;

@RestController
@RequestMapping("/quiz")
public class QuizController {

    @Autowired
    private QuizManager quizManager;

    // Add a quiz to a specific course
    @PostMapping("/add")
    public String addQuizToCourse(@RequestBody Quiz quiz) {
        return quizManager.addQuizToCourse(quiz);
    }

    // Get all quizzes for a specific course
    @GetMapping("/byCourse")
    public List<Quiz> getQuizzesByCourse(@RequestParam("courseid") Long courseId) {
        return quizManager.getQuizzesByCourse(courseId);
    }

    // Update an existing quiz
    @PutMapping("/update")
    public String updateQuiz(@RequestBody Quiz quiz) {
        return quizManager.updateQuiz(quiz);
    }

    // Delete a quiz
    @DeleteMapping("/delete")
    public String deleteQuiz(@RequestParam("quizid") Long quizId) {
        return quizManager.deleteQuiz(quizId);
    }
}
