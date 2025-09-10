// src/main/java/com/lingua/DAOS/VocabularyLevelDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicVocabulary;
import java.util.List;

public interface VocabularyLevelDAO {
    List<BasicVocabulary> findAllWords();
    List<BasicVocabulary> findByLevel(String level);  // ✅ NEW: Load words for a specific level
    void insertWord(BasicVocabulary v);
    void updateWord(BasicVocabulary v);
    void deleteWord(long id);
}