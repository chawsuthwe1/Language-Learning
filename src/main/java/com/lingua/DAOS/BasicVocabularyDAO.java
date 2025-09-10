package com.lingua.DAOS;

import com.lingua.models.BasicVocabulary;
import com.lingua.models.BasicVocabularyQuiz;
import java.util.List;

public interface BasicVocabularyDAO {
    // vocabulary
    void insertWord(BasicVocabulary v);
    void updateWord(BasicVocabulary v);
    void deleteWord(long id);
    List<BasicVocabulary> findAllWords();

    // quizzes
    void insertQuiz(BasicVocabularyQuiz q);
    void updateQuiz(BasicVocabularyQuiz q);
    void deleteQuiz(long id);
    List<BasicVocabularyQuiz> findQuizzesByCategory(String category);
}


