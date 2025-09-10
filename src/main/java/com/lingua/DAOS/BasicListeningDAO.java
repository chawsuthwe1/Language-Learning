package com.lingua.DAOS;

import com.lingua.models.BasicListeningExercise;
import com.lingua.models.BasicListeningMCQ;
import com.lingua.models.BasicListeningTrueFalse;
import java.util.List;

public interface BasicListeningDAO {
    // exercises
    void insertExercise(BasicListeningExercise e);
    void updateExercise(BasicListeningExercise e);
    void deleteExercise(long id);
    BasicListeningExercise findExercise(long id);
    List<BasicListeningExercise> findAllExercises();

    // MCQ
    void insertMCQ(BasicListeningMCQ q);
    void updateMCQ(BasicListeningMCQ q);
    void deleteMCQ(long id);
    List<BasicListeningMCQ> findMCQByExercise(long exerciseId);

    // True/False
    void insertTF(BasicListeningTrueFalse q);
    void updateTF(BasicListeningTrueFalse q);
    void deleteTF(long id);
    List<BasicListeningTrueFalse> findTFByExercise(long exerciseId);
}


