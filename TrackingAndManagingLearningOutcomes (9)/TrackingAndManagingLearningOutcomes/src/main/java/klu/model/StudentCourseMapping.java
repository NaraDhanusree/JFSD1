package klu.model;

import com.fasterxml.jackson.annotation.JsonBackReference;


import jakarta.persistence.*;

@Entity
@Table(name = "student_course_mapping")
public class StudentCourseMapping {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_id") // Foreign key column for Student
    @JsonBackReference("student-reference")  
    private Student student;

    @ManyToOne
    @JoinColumn(name = "course_id") // Foreign key column for Course
    @JsonBackReference("course-reference")
    private Courses course;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Courses getCourse() {
        return course;
    }

    public void setCourse(Courses course) {
        this.course = course;
    }
}
