// src/main/java/com/lingua/DAOS/ListeningLevelDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicListeningExercise;
import java.util.List;

public interface ListeningLevelDAO {
    List<BasicListeningExercise> findAllExercises();
    List<BasicListeningExercise> findByLevel(String level);  // ✅ Add this
    void insertExercise(BasicListeningExercise e);
    void updateExercise(BasicListeningExercise e);
    void deleteExercise(long id);
}