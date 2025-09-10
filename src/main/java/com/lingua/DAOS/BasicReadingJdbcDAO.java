package com.lingua.DAOS;

import com.lingua.models.BasicReadingPassage;
import com.lingua.models.BasicReadingQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BasicReadingJdbcDAO implements BasicReadingDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insertPassage(BasicReadingPassage p) {
        String sql = "INSERT INTO basic_reading_passages (level, title, paragraph) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, p.getLevel(), p.getTitle(), p.getParagraph());
    }

    @Override
    public void updatePassage(BasicReadingPassage p) {
        String sql = "UPDATE basic_reading_passages SET level=?, title=?, paragraph=? WHERE id=?";
        jdbcTemplate.update(sql, p.getLevel(), p.getTitle(), p.getParagraph(), p.getId());
    }

    @Override
    public void deletePassage(long id) {
        jdbcTemplate.update("DELETE FROM basic_reading_passages WHERE id=?", id);
    }

    @Override
    public BasicReadingPassage findPassage(long id) {
        List<BasicReadingPassage> list = jdbcTemplate.query("SELECT id, level, title, paragraph FROM basic_reading_passages WHERE id=?", new BeanPropertyRowMapper<>(BasicReadingPassage.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<BasicReadingPassage> findAllPassages() {
        return jdbcTemplate.query("SELECT id, level, title, paragraph FROM basic_reading_passages ORDER BY id DESC", new BeanPropertyRowMapper<>(BasicReadingPassage.class));
    }

    @Override
    public void insertQuestion(BasicReadingQuestion q) {
        String sql = "INSERT INTO basic_reading_questions (reading_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
    }

    @Override
    public void updateQuestion(BasicReadingQuestion q) {
        String sql = "UPDATE basic_reading_questions SET reading_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
        jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
    }

    @Override
    public void deleteQuestion(long id) {
        jdbcTemplate.update("DELETE FROM basic_reading_questions WHERE id=?", id);
    }

    @Override
    public List<BasicReadingQuestion> findQuestionsByReading(long readingId) {
        return jdbcTemplate.query("SELECT id, reading_id AS readingId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM basic_reading_questions WHERE reading_id=?", new BeanPropertyRowMapper<>(BasicReadingQuestion.class), readingId);
    }
}


