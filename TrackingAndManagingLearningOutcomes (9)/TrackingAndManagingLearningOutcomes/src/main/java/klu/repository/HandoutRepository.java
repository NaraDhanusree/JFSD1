package klu.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import klu.model.Courses;
import klu.model.Handout;
import java.util.List;

public interface HandoutRepository extends JpaRepository<Handout, Long> {
    List<Handout> findByCourse(Courses course);  // Find handouts by course
}
