package com.lingua.services;

import com.lingua.models.*;
import java.util.List;

public interface LessonManagementService {
    // Grammar
    List<BasicGrammarLesson> listGrammarLessons();
    void saveGrammarLesson(BasicGrammarLesson lesson);
    void deleteGrammarLesson(String slug);

    List<BasicGrammarQuiz> listGrammarQuizzes(String lessonSlug);
    void saveGrammarQuiz(BasicGrammarQuiz quiz);
    void deleteGrammarQuiz(long id);

    // Reading
    List<BasicReadingPassage> listReadingPassages();
    void saveReadingPassage(BasicReadingPassage passage);
    void deleteReadingPassage(long id);
    List<BasicReadingQuestion> listReadingQuestions(long readingId);
    void saveReadingQuestion(BasicReadingQuestion question);
    void deleteReadingQuestion(long id);

    // Listening
    List<BasicListeningExercise> listListeningExercises();
    void saveListeningExercise(BasicListeningExercise exercise);
    void deleteListeningExercise(long id);
    List<BasicListeningMCQ> listListeningMCQ(long exerciseId);
    void saveListeningMCQ(BasicListeningMCQ q);
    void deleteListeningMCQ(long id);
    List<BasicListeningTrueFalse> listListeningTF(long exerciseId);
    void saveListeningTF(BasicListeningTrueFalse q);
    void deleteListeningTF(long id);

    // Vocabulary
    List<BasicVocabulary> listVocabulary();
    void saveVocabulary(BasicVocabulary v);
    void deleteVocabulary(long id);
    List<BasicVocabularyQuiz> listVocabularyQuizzes(String category);
    void saveVocabularyQuiz(BasicVocabularyQuiz q);
    void deleteVocabularyQuiz(long id);
	BasicVocabulary findVocabularyById(long id);
	BasicListeningExercise findListeningExerciseById(long id);
}


