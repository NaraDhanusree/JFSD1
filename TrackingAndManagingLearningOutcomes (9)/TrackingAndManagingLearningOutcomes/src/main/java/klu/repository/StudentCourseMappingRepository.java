package klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import klu.model.Courses;
import klu.model.StudentCourseMapping;

public interface StudentCourseMappingRepository extends JpaRepository<StudentCourseMapping, Long>{

	List<StudentCourseMapping> findByStudentId(Long studentId);
}
