package com.lingua.services;

import com.lingua.models.PlacementQuestion;
import java.util.List;
import java.util.Map;

public interface PlacementService {
    List<PlacementQuestion> getAllQuestions();
    List<PlacementQuestion> getQuestionsBySection(String section);
    PlacementQuestion getById(int id);
    void save(PlacementQuestion question); // insert or update based on id
    void delete(int id);

    int evaluateScore(Map<String, String> submittedAnswers);
}


