package com.lingua.DAOS;

import com.lingua.models.BasicVocabulary;
import com.lingua.models.BasicVocabularyQuiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BasicVocabularyJdbcDAO implements BasicVocabularyDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insertWord(BasicVocabulary v) {
        String sql = "INSERT INTO basic_vocabulary (category, word, definition, example, image) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, v.getCategory(), v.getWord(), v.getDefinition(), v.getExample(), v.getImage());
    }

    @Override
    public void updateWord(BasicVocabulary v) {
        String sql = "UPDATE basic_vocabulary SET category=?, word=?, definition=?, example=?, image=? WHERE id=?";
        jdbcTemplate.update(sql, v.getCategory(), v.getWord(), v.getDefinition(), v.getExample(), v.getImage(), v.getId());
    }

    @Override
    public void deleteWord(long id) {
        jdbcTemplate.update("DELETE FROM basic_vocabulary WHERE id=?", id);
    }

    @Override
    public List<BasicVocabulary> findAllWords() {
        return jdbcTemplate.query("SELECT id, category, word, definition, example, image FROM basic_vocabulary ORDER BY id DESC", new BeanPropertyRowMapper<>(BasicVocabulary.class));
    }

    @Override
    public void insertQuiz(BasicVocabularyQuiz q) {
        String sql = "INSERT INTO basic_vocabulary_quiz (category, question_type, question_text, option_a, option_b, option_c, option_d, correct_answer, related_word) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord());
    }

    @Override
    public void updateQuiz(BasicVocabularyQuiz q) {
        String sql = "UPDATE basic_vocabulary_quiz SET category=?, question_type=?, question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_answer=?, related_word=? WHERE id=?";
        jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord(), q.getId());
    }

    @Override
    public void deleteQuiz(long id) {
        jdbcTemplate.update("DELETE FROM basic_vocabulary_quiz WHERE id=?", id);
    }

    @Override
    public List<BasicVocabularyQuiz> findQuizzesByCategory(String category) {
        return jdbcTemplate.query("SELECT id, category, question_type AS questionType, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_answer AS correctAnswer, related_word AS relatedWord FROM basic_vocabulary_quiz WHERE category=?", new BeanPropertyRowMapper<>(BasicVocabularyQuiz.class), category);
    }
}


