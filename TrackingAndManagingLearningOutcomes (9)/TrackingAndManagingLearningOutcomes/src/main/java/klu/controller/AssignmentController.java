package klu.controller;

import klu.model.Assignment;

import klu.model.AssignmentService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/assignments")
public class AssignmentController {

    @Autowired
    private AssignmentService assignmentService;

    // Endpoint to upload an assignment for a course
    @PostMapping("/upload/{courseName}")
    public ResponseEntity<String> uploadAssignment(
            @PathVariable String courseName,
            @RequestParam("file") MultipartFile file,
            @RequestParam("description") String description,
            @RequestParam("title") String title,   // Add title as a parameter
            @RequestParam("startDate") String startDateStr,
            @RequestParam("endDate") String endDateStr) {

        try {
            // Convert startDate and endDate to LocalDate
            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);

            // Call the service to save the assignment
            Assignment assignment = assignmentService.saveAssignment(file, description, courseName, title, startDate, endDate);

            return ResponseEntity.ok("Assignment uploaded successfully for course: " + courseName);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error uploading assignment: " + e.getMessage());
        }
    }


    @GetMapping("/course/{courseName}")
    public ResponseEntity<?> getAssignmentsForCourse(@PathVariable String courseName) {
        try {
            // Fetch all assignments related to the given course name
            List<Assignment> assignments = assignmentService.getAssignmentsForCourse(courseName);
            return ResponseEntity.ok(assignments);  // Return the assignments as a response
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error fetching assignments: " + e.getMessage());
        }
    }
}
