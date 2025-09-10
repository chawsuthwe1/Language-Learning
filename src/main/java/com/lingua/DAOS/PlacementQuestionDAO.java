package com.lingua.DAOS;

import com.lingua.models.PlacementQuestion;
import java.util.List;

public interface PlacementQuestionDAO {
    void insert(PlacementQuestion question);
    void update(PlacementQuestion question);
    void deleteById(int id);
    PlacementQuestion findById(int id);
    List<PlacementQuestion> findAll();
    List<PlacementQuestion> findBySection(String section);
}


