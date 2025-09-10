package com.lingua.DAOS;

import com.lingua.models.FinalTestResult;
import java.util.List;

public interface FinalTestResultDAO {
    void save(FinalTestResult result);
    FinalTestResult findById(Long id);
    List<FinalTestResult> findAll();
    List<FinalTestResult> findByStudentId(Long studentId);
    List<FinalTestResult> findByFinalTestId(Long finalTestId);
    FinalTestResult findByStudentAndTest(Long studentId, Long finalTestId);
    void update(FinalTestResult result);
    void deleteById(Long id);
    int countPassedResults(Long finalTestId);
    int countFailedResults(Long finalTestId);
}
