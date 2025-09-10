package com.lingua.DAOS;

import java.util.List;
import com.lingua.models.SpeakingExercise;

public interface SpeakingExerciseDAO {
    List<SpeakingExercise> findAll();
    SpeakingExercise findById(int id);
    void save(SpeakingExercise e);
    void update(SpeakingExercise e);
    void delete(int id);
}
