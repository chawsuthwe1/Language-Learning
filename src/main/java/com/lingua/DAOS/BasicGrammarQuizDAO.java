package com.lingua.DAOS;

import com.lingua.models.BasicGrammarQuiz;
import java.util.List;

public interface BasicGrammarQuizDAO {
    void insert(BasicGrammarQuiz quiz);
    void update(BasicGrammarQuiz quiz);
    void deleteById(long id);
    BasicGrammarQuiz findById(long id);
    List<BasicGrammarQuiz> findByLessonSlug(String slug);
}


