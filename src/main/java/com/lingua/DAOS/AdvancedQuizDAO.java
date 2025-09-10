package com.lingua.DAOS;

import com.lingua.models.*;
import java.util.List;

public interface AdvancedQuizDAO {
    // Grammar
    List<AdvancedGrammarQuiz> findAllGrammar();
    void saveGrammar(AdvancedGrammarQuiz q); // insert or update based on id
    void deleteGrammar(long id);

    // Listening MCQ
    List<AdvancedListeningMCQ> findAllListeningMCQ();
    void saveListeningMCQ(AdvancedListeningMCQ q);
    void deleteListeningMCQ(long id);

    // Listening True/False
    List<AdvancedListeningTF> findAllListeningTF();
    void saveListeningTF(AdvancedListeningTF q);
    void deleteListeningTF(long id);

    // Reading
    List<AdvancedReadingQuestion> findAllReading();
    void saveReading(AdvancedReadingQuestion q);
    void deleteReading(long id);

    // Vocabulary
    List<AdvancedVocabularyQuiz> findAllVocabulary();
    void saveVocabulary(AdvancedVocabularyQuiz q);
    void deleteVocabulary(long id);
}


