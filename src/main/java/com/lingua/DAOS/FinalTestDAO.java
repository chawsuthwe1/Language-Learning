package com.lingua.DAOS;

import com.lingua.models.FinalTest;
import java.util.List;

public interface FinalTestDAO {
    void save(FinalTest finalTest);
    FinalTest findById(Long id);
    List<FinalTest> findAll();
    void update(FinalTest finalTest);
    void deleteById(Long id);
    int countAll();
    List<FinalTest> findActiveTests();
}
