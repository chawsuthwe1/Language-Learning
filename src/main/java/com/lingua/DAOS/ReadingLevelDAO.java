// src/main/java/com/lingua/DAOS/ReadingLevelDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicReadingPassage;
import java.util.List;

public interface ReadingLevelDAO {
    List<BasicReadingPassage> findAllPassages();
    List<BasicReadingPassage> findByLevel(String level);  // ✅ Add this
    void insertPassage(BasicReadingPassage passage);
    void updatePassage(BasicReadingPassage passage);
    void deletePassage(long id);
}