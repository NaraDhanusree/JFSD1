package klu.model;


import java.util.List;

import java.util.stream.Collectors;
import java.util.Optional;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import klu.repository.FacultyCourseMappingRepository;
import klu.repository.FacultyRepository;

@Service
public class FacultyManager {
	

    @Autowired
    FacultyRepository FR;
   
    @Autowired
    private FacultyCourseMappingRepository facultyCourseMappingRepository;
    public String SaveFaculty(Faculty F) {
        try {
            // Check if the faculty ID is already in use
            if (FR.validateUsername(F.getFacultyid()) > 0) {
                throw new Exception("401"); // Faculty ID already exists
            }

            // Save the faculty entity
            FR.save(F);
            return "200"; // Success
        } catch (Exception e) {
            // Return or log the error message
            return e.getMessage(); // Log the error message or use a logger
        }
        
    }

    public List<Faculty> readData() {
        return FR.findAll();
    }
    public String updateFacultyData(Faculty F) {
        try {
            // Check if faculty exists before updating
            Optional<Faculty> existingFaculty = FR.findById(F.getFacultyid());
            if (!existingFaculty.isPresent()) {
                return "Faculty not found"; // Handle not found case
            }

            // Update faculty data
            FR.save(F);
            return "Faculty updated successfully"; // Success message
        } catch (Exception e) {
            return "Error updating faculty: " + e.getMessage(); // Return error message
        }
    }

    public String FacultydeleteData(long id) {
        if (FR.existsById(id)) {
            FR.deleteById(id);
            return "Faculty deleted successfully";
        } else {
            return "Faculty not found";
        }
    }
    public Object FacultyAdmin(long uname, String pwd) {
        // Validate credentials
        if (FR.validateCredentials(uname, pwd) == 0) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }

        // Fetch faculty details
        Faculty faculty = FR.findById(uname).orElse(null);
        if (faculty == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Faculty not found");
        }

        // Fetch assigned courses
        List<FacultyCourseMapping> mappings = facultyCourseMappingRepository.findByFacultyFacultyid(uname);
        List<String> courses = mappings.stream()
                                       .map(mapping -> mapping.getCourse().getCoursename())
                                       .collect(Collectors.toList());

        // Create response object
        Map<String, Object> response = new HashMap<>();
        response.put("facultyId", faculty.getFacultyid());
        response.put("name", faculty.getName());
        response.put("courses", courses);

        return ResponseEntity.ok(response);
    }


    
}
