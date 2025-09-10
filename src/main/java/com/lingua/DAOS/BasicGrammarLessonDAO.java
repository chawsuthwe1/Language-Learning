package com.lingua.DAOS;

import com.lingua.models.BasicGrammarLesson;
import java.util.List;

public interface BasicGrammarLessonDAO {
    void insert(BasicGrammarLesson lesson);
    void update(BasicGrammarLesson lesson);
    void deleteBySlug(String slug);
    BasicGrammarLesson findBySlug(String slug);
    List<BasicGrammarLesson> findAll();
}


