package com.lingua.services;

import com.lingua.DAOS.PlacementQuestionDAO;
import com.lingua.models.PlacementQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class PlacementServiceImpl implements PlacementService {

    @Autowired
    private PlacementQuestionDAO dao;

    @Override
    public List<PlacementQuestion> getAllQuestions() {
        return dao.findAll();
    }

    @Override
    public List<PlacementQuestion> getQuestionsBySection(String section) {
        return dao.findBySection(section);
    }

    @Override
    public PlacementQuestion getById(int id) {
        return dao.findById(id);
    }

    @Override
    public void save(PlacementQuestion question) {
        if (question.getId() == 0) dao.insert(question); else dao.update(question);
    }

    @Override
    public void delete(int id) {
        dao.deleteById(id);
    }

    @Override
    public int evaluateScore(Map<String, String> submittedAnswers) {
        int score = 0;
        for (Map.Entry<String, String> entry : submittedAnswers.entrySet()) {
            String key = entry.getKey();
            if (key != null && key.startsWith("q")) {
                try {
                    int qid = Integer.parseInt(key.substring(1));
                    PlacementQuestion q = dao.findById(qid);
                    if (q != null && q.getCorrectOption() != null) {
                        String correct = q.getCorrectOption().trim();
                        String submitted = entry.getValue() == null ? "" : entry.getValue().trim();
                        // If submission is a single letter A-D, treat as MCQ; otherwise treat as text answer
                        if (submitted.length() == 1 && ("ABCDabcd".indexOf(submitted.charAt(0)) >= 0)) {
                            if (correct.equalsIgnoreCase(submitted)) score++;
                        } else {
                            // Text answer: case-insensitive comparison
                            if (correct.equalsIgnoreCase(submitted)) score++;
                        }
                    }
                } catch (NumberFormatException ignored) {}
            }
        }
        return score;
    }
}


