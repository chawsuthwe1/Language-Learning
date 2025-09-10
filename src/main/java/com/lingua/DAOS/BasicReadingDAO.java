package com.lingua.DAOS;

import com.lingua.models.BasicReadingPassage;
import com.lingua.models.BasicReadingQuestion;
import java.util.List;

public interface BasicReadingDAO {
    // passages
    void insertPassage(BasicReadingPassage p);
    void updatePassage(BasicReadingPassage p);
    void deletePassage(long id);
    BasicReadingPassage findPassage(long id);
    List<BasicReadingPassage> findAllPassages();

    // questions
    void insertQuestion(BasicReadingQuestion q);
    void updateQuestion(BasicReadingQuestion q);
    void deleteQuestion(long id);
    List<BasicReadingQuestion> findQuestionsByReading(long readingId);
}


