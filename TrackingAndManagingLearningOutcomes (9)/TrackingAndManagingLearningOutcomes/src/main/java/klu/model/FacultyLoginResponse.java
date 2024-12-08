package klu.model;

import java.util.List;

public class FacultyLoginResponse {

    private Faculty faculty;
    private List<String> courses;

    public FacultyLoginResponse(Faculty faculty, List<String> courses) {
        this.faculty = faculty;
        this.courses = courses;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public List<String> getCourses() {
        return courses;
    }

    public void setCourses(List<String> courses) {
        this.courses = courses;
    }
}
