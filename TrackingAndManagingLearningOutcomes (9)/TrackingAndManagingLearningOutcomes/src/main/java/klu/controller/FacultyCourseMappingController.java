package klu.controller;

import klu.model.FacultyCourseMapping;
import klu.model.FacultyCourseMappingManager;
import klu.model.Faculty;
import klu.model.Courses;
import klu.repository.FacultyRepository;
import klu.repository.CourseRepository;
import klu.repository.FacultyCourseMappingRepository;
import java.util.Collections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import java.util.stream.Collectors;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;

@RestController
@RequestMapping("/facultycourse")
@CrossOrigin(origins = "http://localhost:3000")
public class FacultyCourseMappingController {

    @Autowired
    private FacultyCourseMappingManager FCMM;

    @Autowired
    private FacultyRepository facultyRepository;

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private FacultyCourseMappingRepository facultyCourseMappingRepository;

    // Get all faculties
    @GetMapping("/api/mapping/faculties")
    public List<Faculty> getAllFaculties() {
        return facultyRepository.findAll();
    }

    // Get all courses with courseid and coursename
    @GetMapping("/api/mapping/courses")
    public List<Map<String, Object>> getAllCourses() {
        List<Courses> coursesList = courseRepository.findAll();
        List<Map<String, Object>> courseData = new ArrayList<>();

        for (Courses course : coursesList) {
            Map<String, Object> courseMap = new HashMap<>();
            courseMap.put("courseid", course.getCourseid());
            courseMap.put("coursename", course.getCoursename());
            courseData.add(courseMap);
        }
        return courseData;
    }

    @PostMapping("/add")
    public ResponseEntity<FacultyCourseMapping> addMapping(@RequestBody Map<String, Long> request) {
        Long facultyId = request.get("facultyId");
        Long courseId = request.get("courseId");

        System.out.println("Received facultyId: " + facultyId + ", courseId: " + courseId);

        Faculty faculty = facultyRepository.findById(facultyId).orElse(null);
        Courses course = courseRepository.findById(courseId).orElse(null);

        if (faculty == null) {
            System.out.println("Faculty with ID " + facultyId + " not found.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        if (course == null) {
            System.out.println("Course with ID " + courseId + " not found.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }

        FacultyCourseMapping mapping = new FacultyCourseMapping();
        mapping.setFaculty(faculty);
        mapping.setCourse(course);

        try {
            FacultyCourseMapping savedMapping = FCMM.addMapping(mapping);
            return ResponseEntity.ok(savedMapping);
        } catch (Exception e) {
            System.out.println("Error in adding mapping: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
    @GetMapping("/api/mapping/faculty/{facultyId}/courses")
    public ResponseEntity<Map<String, List<String>>> getCoursesForFaculty(@PathVariable long facultyId) {
        System.out.println("Processing request for faculty ID: " + facultyId);

        // Fetch courses mapped to the faculty
        List<FacultyCourseMapping> mappings = facultyCourseMappingRepository.findByFacultyFacultyid(facultyId);

        if (mappings.isEmpty()) {
            System.out.println("No courses found for faculty ID: " + facultyId);
            return ResponseEntity.noContent().build();  // Return 204 No Content
        }

        // Process the courses
        List<String> courses = mappings.stream()
                                       .map(mapping -> mapping.getCourse().getCoursename())
                                       .collect(Collectors.toList());

        System.out.println("Courses found for faculty ID " + facultyId + ": " + courses);

        Map<String, List<String>> response = new HashMap<>();
        response.put("courses", courses);

        return ResponseEntity.ok(response);
    }



}
