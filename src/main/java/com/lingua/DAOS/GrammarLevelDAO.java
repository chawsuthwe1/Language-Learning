package com.lingua.DAOS;

import com.lingua.models.BasicGrammarLesson;
import java.util.List;

public interface GrammarLevelDAO {
    List<BasicGrammarLesson> findAllLessons();
    List<BasicGrammarLesson> findByLevel(String level);  // ✅ Add this
    void insertLesson(BasicGrammarLesson lesson);
    void updateLesson(BasicGrammarLesson lesson);
    void deleteLesson(String slug);
    BasicGrammarLesson findBySlug(String slug);
}