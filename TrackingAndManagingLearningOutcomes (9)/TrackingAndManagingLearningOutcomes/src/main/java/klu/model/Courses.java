package klu.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="courses")
public class Courses {

	
	public Long getCourseid() {
		return courseid;
	}

	public void setCourseid(Long courseid) {
		this.courseid = courseid;
	}

	public String getCoursename() {
		return coursename;
	}

	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}

	public String getCoursedescription() {
		return coursedescription;
	}

	public void setCoursedescription(String coursedescription) {
		this.coursedescription = coursedescription;
	}
	 public List<StudentCourseMapping> getStudentMappings() {
	        return studentMappings;
	    }

	    public void setStudentMappings(List<StudentCourseMapping> studentMappings) {
	        this.studentMappings = studentMappings;
	    }
	    public List<Handout> getHandouts() {
	        return handouts;  // Getter for handouts
	    }

	    public void setHandouts(List<Handout> handouts) {
	        this.handouts = handouts;  // Setter for handouts
	    }


	    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
	    private List<Handout> handouts;  // Adding Handout entity relation
	@Id
	@Column(name = "courseid")
	Long courseid;
	 
	@Override
	public String toString() {
		return "Courses [courseid=" + courseid + ", coursename=" + coursename + ", coursedescription="
				+ coursedescription + "]";
	}

	@Column(name = "coursename")
	String coursename;
	
	@Column(name = "coursedescription")
	String coursedescription;
	@OneToMany(mappedBy = "course")
	@JsonBackReference("course-reference")
    private List<StudentCourseMapping> studentMappings;
	 @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
	    private List<Quiz> quizzes;// One-to-many relationship with Quiz
	 public List<Quiz> getQuizzes() { return quizzes; }
	    public void setQuizzes(List<Quiz> quizzes) { this.quizzes = quizzes; }

}
