// src/main/java/com/lingua/DAOS/LevelExtraQuizDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicReadingQuestion;
import com.lingua.models.BasicListeningTrueFalse;
import com.lingua.models.BasicVocabularyQuiz;
import com.lingua.models.BasicListeningMCQ;
import java.util.List;

public interface LevelExtraQuizDAO {

    // Reading
    List<BasicReadingQuestion> findReadingByLevel(String level);
    BasicReadingQuestion findReadingById(String level, long id);
    void saveReading(String level, BasicReadingQuestion q);
    void deleteReading(long id);

    // Listening True/False
    List<BasicListeningTrueFalse> findListeningTFByLevel(String level);
    BasicListeningTrueFalse findListeningTFById(String level, long id);
    void saveListeningTF(String level, BasicListeningTrueFalse q);
    void deleteListeningTF(long id);

    // Listening MCQ
    List<BasicListeningMCQ> findListeningMCQByLevel(String level);
    BasicListeningMCQ findListeningMCQById(String level, long id);
    void saveListeningMCQ(String level, BasicListeningMCQ q);
    void deleteListeningMCQ(long id);

    // Vocabulary
    List<BasicVocabularyQuiz> findVocabularyByLevel(String level);
    BasicVocabularyQuiz findVocabularyById(String level, long id);
    void saveVocabulary(String level, BasicVocabularyQuiz q);
    void deleteVocabulary(long id);
}