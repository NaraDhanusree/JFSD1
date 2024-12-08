package klu.model;



import klu.repository.CourseRepository;
import klu.repository.AssignmentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Service
public class AssignmentService {

    @Autowired
    private AssignmentRepository assignmentRepository;

    @Autowired
    private CourseRepository coursesRepository;

    // Save an assignment (including file upload)
    public Assignment saveAssignment(MultipartFile file, String description, String courseName, 
                                     String title, LocalDate startDate, LocalDate endDate) {
        // Retrieve the course object based on the course name
        Courses course = coursesRepository.findByCoursename(courseName);

        if (course == null) {
            throw new IllegalArgumentException("Course not found for the given name: " + courseName);
        }

        // Save the file or generate a URL for it
        String fileUrl = "/uploads/" + file.getOriginalFilename(); // Example file URL, adjust as needed

        // Create the Assignment object
        Assignment assignment = new Assignment();
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setFileUrl(fileUrl);
        assignment.setStartDate(startDate);
        assignment.setEndDate(endDate);
        assignment.setCourse(course);

        // Save the assignment to the repository
        return assignmentRepository.save(assignment);
    }

    // Get all assignments for a specific course
    public List<Assignment> getAssignmentsForCourse(String courseName) {
        // Retrieve the course object based on the course name
        Courses course = coursesRepository.findByCoursename(courseName);

        if (course == null) {
            throw new IllegalArgumentException("Course not found for the given name: " + courseName);
        }

        // Retrieve all assignments related to the course
        return assignmentRepository.findByCourse(course);
    }
}