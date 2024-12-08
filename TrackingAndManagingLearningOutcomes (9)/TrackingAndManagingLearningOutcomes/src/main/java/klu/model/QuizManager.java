package klu.model;

import klu.repository.QuizRepository;
import klu.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuizManager {

    @Autowired
    private QuizRepository quizRepository;

    @Autowired
    private CourseRepository coursesRepository;

    // Add a quiz to a specific course
    public String addQuizToCourse(Quiz quiz) {
        Courses course = coursesRepository.findById(quiz.getCourse().getCourseid()).orElse(null);
        if (course == null) {
            return "Course not found!";
        }
        quiz.setCourse(course); // Link quiz to course
        quizRepository.save(quiz);
        return "Quiz added successfully!";
    }

    // Get all quizzes for a specific course
    public List<Quiz> getQuizzesByCourse(Long courseId) {
        return quizRepository.findByCourse_Courseid(courseId);
    }

    // Update an existing quiz
    public String updateQuiz(Quiz quiz) {
        if (!quizRepository.existsById(quiz.getQuizId())) {
            return "Quiz not found!";
        }
        quizRepository.save(quiz);
        return "Quiz updated successfully!";
    }

    // Delete a quiz
    public String deleteQuiz(Long quizId) {
        if (!quizRepository.existsById(quizId)) {
            return "Quiz not found!";
        }
        quizRepository.deleteById(quizId);
        return "Quiz deleted successfully!";
    }
}
