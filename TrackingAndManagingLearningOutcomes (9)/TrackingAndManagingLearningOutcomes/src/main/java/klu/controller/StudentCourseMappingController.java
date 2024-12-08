package klu.controller;

import klu.model.StudentCourseMapping;
import klu.model.StudentCourseMappingManager;
import klu.model.Student;
import klu.model.Courses;
import klu.repository.StudentRepository;
import klu.repository.CourseRepository;
import klu.repository.StudentCourseMappingRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.HashMap;
import java.util.ArrayList;


@RestController
@RequestMapping("/studentcourse")
@CrossOrigin(origins = "http://localhost:3000") // Allow all origins for development
public class StudentCourseMappingController {

    @Autowired
    private StudentCourseMappingManager SCMM;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private CourseRepository courseRepository;

    // Get all students
    @GetMapping("/api/mapping/students")
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }
    @Autowired
    private StudentCourseMappingRepository studentCourseMappingRepository;

    @GetMapping("/api/mapping/student/{uname}/courses")
    public ResponseEntity<Map<String, List<String>>> getCoursesForStudent(@PathVariable String uname) {
        System.out.println("Processing request for student with username: " + uname);

        try {
            // Fetch student details using the username
            Student student = studentRepository.findByUsername(uname).orElseThrow(() -> new RuntimeException("Student not found"));

            // Fetch courses mapped to the student
            List<StudentCourseMapping> mappings = studentCourseMappingRepository.findByStudentId(student.getId());

            if (mappings.isEmpty()) {
                System.out.println("No courses found for student with username: " + uname);
                return ResponseEntity.noContent().build();  // Return 204 No Content
            }

            // Process the courses
            List<String> courses = mappings.stream()
                                           .map(mapping -> mapping.getCourse().getCoursename())
                                           .collect(Collectors.toList());

            System.out.println("Courses found for student with username " + uname + ": " + courses);

            // Create response object
            Map<String, List<String>> response = new HashMap<>();
            response.put("courses", courses);

            return ResponseEntity.ok(response);  // Return ResponseEntity with the correct type
        } catch (Exception e) {
            // Return a response with the error message in the correct format
            Map<String, List<String>> errorResponse = new HashMap<>();
            errorResponse.put("error", List.of(e.getMessage()));  // Converting error message to a list of strings
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }



 @GetMapping("/api/mapping/courses")
 public List<Map<String, Object>> getAllCourses() {
     List<Courses> coursesList = courseRepository.findAll();
     List<Map<String, Object>> courseData = new ArrayList<>();
     
     // Create a list of course data with only courseid and coursename
     for (Courses course : coursesList) {
         Map<String, Object> courseMap = new HashMap<>();
         courseMap.put("courseid", course.getCourseid());
         courseMap.put("coursename", course.getCoursename());
         courseData.add(courseMap);
     }
     return courseData;
 }


 @PostMapping("/add")
 public ResponseEntity<StudentCourseMapping> addMapping(@RequestBody Map<String, Long> request) {
     Long studentId = request.get("studentId");
     Long courseId = request.get("courseId");

     System.out.println("Received studentId: " + studentId + ", courseId: " + courseId);

     // Retrieve student and course by IDs
     Student student = studentRepository.findById(studentId).orElse(null);
     Courses course = courseRepository.findById(courseId).orElse(null);

     // Check if both student and course exist in the database
     if (student == null) {
         System.out.println("Student with ID " + studentId + " not found.");
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
     }

     if (course == null) {
         System.out.println("Course with ID " + courseId + " not found.");
         return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
     }

     // Create and save mapping
     StudentCourseMapping mapping = new StudentCourseMapping();
     mapping.setStudent(student);
     mapping.setCourse(course);

     try {
         StudentCourseMapping savedMapping = SCMM.addMapping(mapping);
         return ResponseEntity.ok(savedMapping);
     } catch (Exception e) {
         System.out.println("Error in adding mapping: " + e.getMessage());
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
     }
 }
 

}
