package com.lingua.DAOS;

import com.lingua.models.FinalTestQuestion;
import java.util.List;

public interface FinalTestQuestionDAO {
    void save(FinalTestQuestion question);
    FinalTestQuestion findById(Long id);
    List<FinalTestQuestion> findAll();
    List<FinalTestQuestion> findByFinalTestId(Long finalTestId);
    List<FinalTestQuestion> findBySessionNumber(Long finalTestId, int sessionNumber);
    void update(FinalTestQuestion question);
    void deleteById(Long id);
    void deleteByFinalTestId(Long finalTestId);
    int countByFinalTestId(Long finalTestId);
}
