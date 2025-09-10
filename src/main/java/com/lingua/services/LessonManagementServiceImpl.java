package com.lingua.services;

import com.lingua.DAOS.*;
import com.lingua.models.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.ArrayList;

@Service
public class LessonManagementServiceImpl implements LessonManagementService {

    @Autowired private GrammarLevelDAO grammarLessonDAO;
    @Autowired private BasicGrammarQuizDAO grammarQuizDAO;
    @Autowired private ReadingLevelDAO readingDAO;
    @Autowired private ListeningLevelDAO listeningDAO;
    @Autowired private VocabularyLevelDAO vocabularyDAO;

    // Grammar
    @Override public List<BasicGrammarLesson> listGrammarLessons() { return grammarLessonDAO.findAllLessons(); }
    @Override public void saveGrammarLesson(BasicGrammarLesson lesson) {
        if (grammarLessonDAO.findBySlug(lesson.getSlug()) == null) grammarLessonDAO.insertLesson(lesson); else grammarLessonDAO.updateLesson(lesson);
    }
    @Override public void deleteGrammarLesson(String slug) { grammarLessonDAO.deleteLesson(slug); }
    @Override public List<BasicGrammarQuiz> listGrammarQuizzes(String lessonSlug) { return grammarQuizDAO.findByLessonSlug(lessonSlug); }
    @Override public void saveGrammarQuiz(BasicGrammarQuiz quiz) { if (quiz.getId() == null) grammarQuizDAO.insert(quiz); else grammarQuizDAO.update(quiz); }
    @Override public void deleteGrammarQuiz(long id) { grammarQuizDAO.deleteById(id); }

    // Reading
    @Override public List<BasicReadingPassage> listReadingPassages() { return readingDAO.findAllPassages(); }
    @Override public void saveReadingPassage(BasicReadingPassage passage) { if (passage.getId() == null) readingDAO.insertPassage(passage); else readingDAO.updatePassage(passage); }
    @Override public void deleteReadingPassage(long id) { readingDAO.deletePassage(id); }
    @Override public List<BasicReadingQuestion> listReadingQuestions(long readingId) { return new ArrayList<>(); }
    @Override public void saveReadingQuestion(BasicReadingQuestion question) { }
    @Override public void deleteReadingQuestion(long id) { }

    // Listening
    @Override public List<BasicListeningExercise> listListeningExercises() { return listeningDAO.findAllExercises(); }
    @Override public void saveListeningExercise(BasicListeningExercise exercise) { if (exercise.getId() == null) listeningDAO.insertExercise(exercise); else listeningDAO.updateExercise(exercise); }
    @Override public void deleteListeningExercise(long id) { listeningDAO.deleteExercise(id); }
    @Override public List<BasicListeningMCQ> listListeningMCQ(long exerciseId) { return new ArrayList<>(); }
    @Override public void saveListeningMCQ(BasicListeningMCQ q) { }
    @Override public void deleteListeningMCQ(long id) { }
    @Override public List<BasicListeningTrueFalse> listListeningTF(long exerciseId) { return new ArrayList<>(); }
    @Override public void saveListeningTF(BasicListeningTrueFalse q) { }
    @Override public void deleteListeningTF(long id) { }

    // Vocabulary
    @Override public List<BasicVocabulary> listVocabulary() { return vocabularyDAO.findAllWords(); }
    @Override public void saveVocabulary(BasicVocabulary v) { if (v.getId() == null) vocabularyDAO.insertWord(v); else vocabularyDAO.updateWord(v); }
    @Override public void deleteVocabulary(long id) { vocabularyDAO.deleteWord(id); }
    @Override public List<BasicVocabularyQuiz> listVocabularyQuizzes(String category) { return new ArrayList<>(); }
    @Override public void saveVocabularyQuiz(BasicVocabularyQuiz q) { }
    @Override public void deleteVocabularyQuiz(long id) { }
	@Override
	public BasicVocabulary findVocabularyById(long id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public BasicListeningExercise findListeningExerciseById(long id) {
		// TODO Auto-generated method stub
		return null;
	}
}


