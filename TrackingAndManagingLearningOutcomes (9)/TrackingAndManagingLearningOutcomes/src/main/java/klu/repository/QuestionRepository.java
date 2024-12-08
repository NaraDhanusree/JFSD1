package klu.repository;

import klu.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Long> {
    // Custom queries (if any) can be added here
}
