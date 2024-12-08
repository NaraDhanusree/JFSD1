package klu.repository;

import klu.model.Assignment;
import klu.model.Courses;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
	 List<Assignment> findByCourse(Courses course);
}