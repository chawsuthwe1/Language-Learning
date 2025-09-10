package com.lingua.DAOS;

import com.lingua.models.Quiz;
import java.util.List;

public interface QuizDAO {
    int countAll();
    void addQuiz(Quiz quiz);
    List<Quiz> getAllQuizzes();
    void deleteQuiz(Long id);
    Object findAll();
    void save(Quiz quiz);
    void deleteById(int id);

    // ✅ New method for updating a quiz
    void updateQuiz(Quiz quiz);
}
