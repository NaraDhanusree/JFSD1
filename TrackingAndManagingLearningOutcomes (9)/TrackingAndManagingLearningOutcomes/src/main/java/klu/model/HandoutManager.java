package klu.model;

import klu.model.Courses;
import klu.model.Handout;
import klu.repository.CourseRepository;

import klu.repository.HandoutRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class HandoutManager {
    @Autowired
    private HandoutRepository handoutRepository;

    @Autowired
    private CourseRepository coursesRepository;

    // Save a handout (including file upload)
    public Handout saveHandout(MultipartFile file, String description, String courseName) {
        // Retrieve the course object based on the course name
        Courses course = coursesRepository.findByCoursename(courseName);

        if (course == null) {
            throw new IllegalArgumentException("Course not found for the given name: " + courseName);
        }

        // Save the file or generate a URL for it
        String fileUrl = "/uploads/" + file.getOriginalFilename(); // Example file URL, adjust as needed

        // Create the Handout object
        Handout handout = new Handout();
        handout.setName(file.getOriginalFilename());
        handout.setDescription(description);
        handout.setFileUrl(fileUrl);
        handout.setCourse(course);

        // Save the handout to the repository
        return handoutRepository.save(handout);
    }
 // Get all handouts for a specific course
    public List<Handout> getHandoutsForCourse(String courseName) {
        // Retrieve the course object based on the course name
        Courses course = coursesRepository.findByCoursename(courseName);

        if (course == null) {
            throw new IllegalArgumentException("Course not found for the given name: " + courseName);
        }

        // Retrieve all handouts related to the course
        return handoutRepository.findByCourse(course);
    }

}
