package klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import klu.model.FacultyCourseMapping;

public interface FacultyCourseMappingRepository  extends JpaRepository<FacultyCourseMapping, Long>{

	List<FacultyCourseMapping> findByFacultyFacultyid(Long facultyId);
}
