package com.lingua.DAOS;

import com.lingua.models.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdvancedQuizJdbcDAO implements AdvancedQuizDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Grammar
    @Override
    public List<AdvancedGrammarQuiz> findAllGrammar() {
        String sql = "SELECT id, question, options, answer, lesson_slug AS lessonSlug FROM advanced_grammar_quiz ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AdvancedGrammarQuiz.class));
    }

    @Override
    public void saveGrammar(AdvancedGrammarQuiz q) {
        if (q.getId() == null) {
            String sql = "INSERT INTO advanced_grammar_quiz (question, options, answer, lesson_slug) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getQuestion(), q.getOptions(), q.getAnswer(), q.getLessonSlug());
        } else {
            String sql = "UPDATE advanced_grammar_quiz SET question=?, options=?, answer=?, lesson_slug=? WHERE id=?";
            jdbcTemplate.update(sql, q.getQuestion(), q.getOptions(), q.getAnswer(), q.getLessonSlug(), q.getId());
        }
    }

    @Override
    public void deleteGrammar(long id) {
        jdbcTemplate.update("DELETE FROM advanced_grammar_quiz WHERE id=?", id);
    }

    // Listening MCQ
    @Override
    public List<AdvancedListeningMCQ> findAllListeningMCQ() {
        String sql = "SELECT id, exercise_id AS exerciseId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM advanced_listening_multiple_choice_questions ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AdvancedListeningMCQ.class));
    }

    @Override
    public void saveListeningMCQ(AdvancedListeningMCQ q) {
        if (q.getId() == null) {
            String sql = "INSERT INTO advanced_listening_multiple_choice_questions (exercise_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
        } else {
            String sql = "UPDATE advanced_listening_multiple_choice_questions SET exercise_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
        }
    }

    @Override
    public void deleteListeningMCQ(long id) {
        jdbcTemplate.update("DELETE FROM advanced_listening_multiple_choice_questions WHERE id=?", id);
    }

    // Listening True/False
    @Override
    public List<AdvancedListeningTF> findAllListeningTF() {
        String sql = "SELECT id, exercise_id AS exerciseId, statement, answer FROM advanced_listening_true_false_questions ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AdvancedListeningTF.class));
    }

    @Override
    public void saveListeningTF(AdvancedListeningTF q) {
        if (q.getId() == null) {
            String sql = "INSERT INTO advanced_listening_true_false_questions (exercise_id, statement, answer) VALUES (?, ?, ?)";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer());
        } else {
            String sql = "UPDATE advanced_listening_true_false_questions SET exercise_id=?, statement=?, answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer(), q.getId());
        }
    }

    @Override
    public void deleteListeningTF(long id) {
        jdbcTemplate.update("DELETE FROM advanced_listening_true_false_questions WHERE id=?", id);
    }

    // Reading
    @Override
    public List<AdvancedReadingQuestion> findAllReading() {
        String sql = "SELECT id, reading_id AS readingId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM advanced_reading_questions ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AdvancedReadingQuestion.class));
    }

    @Override
    public void saveReading(AdvancedReadingQuestion q) {
        if (q.getId() == null) {
            String sql = "INSERT INTO advanced_reading_questions (reading_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
        } else {
            String sql = "UPDATE advanced_reading_questions SET reading_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
        }
    }

    @Override
    public void deleteReading(long id) {
        jdbcTemplate.update("DELETE FROM advanced_reading_questions WHERE id=?", id);
    }

    // Vocabulary
    @Override
    public List<AdvancedVocabularyQuiz> findAllVocabulary() {
        String sql = "SELECT id, category, question_type AS questionType, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_answer AS correctAnswer, related_word AS relatedWord FROM advanced_vocabulary_quiz ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AdvancedVocabularyQuiz.class));
    }

    @Override
    public void saveVocabulary(AdvancedVocabularyQuiz q) {
        if (q.getId() == null) {
            String sql = "INSERT INTO advanced_vocabulary_quiz (category, question_type, question_text, option_a, option_b, option_c, option_d, correct_answer, related_word) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord());
        } else {
            String sql = "UPDATE advanced_vocabulary_quiz SET category=?, question_type=?, question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_answer=?, related_word=? WHERE id=?";
            jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord(), q.getId());
        }
    }

    @Override
    public void deleteVocabulary(long id) {
        jdbcTemplate.update("DELETE FROM advanced_vocabulary_quiz WHERE id=?", id);
    }
}


