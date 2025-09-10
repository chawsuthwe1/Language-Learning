// src/main/java/com/lingua/DAOS/LessonLevelQuizDAO.java

package com.lingua.DAOS;

import com.lingua.models.LevelGrammarQuiz;
import java.util.List;

public interface LessonLevelQuizDAO {
    List<LevelGrammarQuiz> findAll(String level);
    void save(String level, LevelGrammarQuiz q);
    void delete(String level, long id);
    LevelGrammarQuiz findById(String level, long id);
    boolean lessonSlugExists(String level, String slug);
    List<String> findAllLessonSlugs(String level);
}