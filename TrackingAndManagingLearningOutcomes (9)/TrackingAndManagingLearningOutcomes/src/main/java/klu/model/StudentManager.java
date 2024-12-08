package klu.model;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import klu.repository.StudentCourseMappingRepository;
import klu.repository.StudentRepository;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;


@Service
public class StudentManager {

	@Autowired
	StudentRepository SR;
	@Autowired
    private StudentCourseMappingRepository studentCourseMappingRepository;
	public Object loginStudent(String uname, String pwd) {
	    try {
	        // Validate credentials using the repository
	        if (SR.validateCredentials(uname, pwd) == 0) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
	        }

	        // Fetch student details using the username (Optional<Student>)
	        Student student = SR.findByUsername(uname).orElseThrow(() -> new RuntimeException("Student not found"));

	        // Fetch assigned courses for the student using the student's ID
	        List<StudentCourseMapping> mappings = studentCourseMappingRepository.findByStudentId(student.getId());
	        List<String> courses = mappings.stream()
	                                      .map(mapping -> mapping.getCourse().getCoursename())
	                                      .collect(Collectors.toList());

	        // Create response object
	        Map<String, Object> response = new HashMap<>();
	        response.put("username", student.getUsername()); // Ensure the username is sent
	        response.put("name", student.getFristname() + " " + student.getLastname());
	        response.put("courses", courses);

	        return ResponseEntity.ok(response); // Respond with student data including courses
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
	    }
	}



	
	public String studentSave(Student S)
	{
		
		try
		{
			if(SR.validateUsername(S.username)>0)
				throw new Exception("401");
				
			SR.save(S);
			return "200";
		}catch(Exception e)
		{
			return e.getMessage();
		}
	}

	 public List<Student> getAllStudents() {
	        return SR.findAll();
	    }
	 public String updateStudentData(Student S) {
	        try {
	            // Check if faculty exists before updating
	            Optional<Student> existingFaculty = SR.findById(S.getId());
	            if (!existingFaculty.isPresent()) {
	                return "Student not found"; // Handle not found case
	            }

	            // Update faculty data
	            SR.save(S);
	            return "Student updated successfully"; // Success message
	        } catch (Exception e) {
	            return "Error Student: " + e.getMessage(); // Return error message
	        }

	 }
	 public String StudentdeleteData(long id) {
	        if (SR.existsById(id)) {
	            SR.deleteById(id);
	            return "Student deleted successfully";
	        } else {
	            return "Student not found";
	        }
	    }
	 

}

