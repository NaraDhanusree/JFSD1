package klu.controller;

import klu.model.Handout;
import klu.model.HandoutManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/handouts")
public class HandoutController {

    @Autowired
    private HandoutManager handoutService;

    // Endpoint to upload a handout for a course
    @PostMapping("/upload/{courseName}")
    public ResponseEntity<String> uploadHandout(
            @PathVariable String courseName,
            @RequestParam("file") MultipartFile file,
            @RequestParam("description") String description) {
        
        try {
            // Call the service to save the handout
            Handout handout = handoutService.saveHandout(file, description, courseName);

            return ResponseEntity.ok("Handout uploaded successfully for course: " + courseName);
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error uploading handout: " + e.getMessage());
        }
    }

    // Endpoint to get all handouts for a specific course
    @GetMapping("/course/{courseName}")
    public ResponseEntity<?> getHandoutsForCourse(@PathVariable String courseName) {
        // Fetch all handouts related to the given course name
        return ResponseEntity.ok(handoutService.getHandoutsForCourse(courseName));
    }
}
