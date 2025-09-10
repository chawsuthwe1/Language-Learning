package com.lingua.DAOS;

import com.lingua.models.BasicGrammarQuiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BasicGrammarQuizJdbcDAO implements BasicGrammarQuizDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insert(BasicGrammarQuiz quiz) {
        String sql = "INSERT INTO basic_grammar_quiz (question, options, answer, lesson_slug) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, quiz.getQuestion(), quiz.getOptions(), quiz.getAnswer(), quiz.getLessonSlug());
    }

    @Override
    public void update(BasicGrammarQuiz quiz) {
        String sql = "UPDATE basic_grammar_quiz SET question=?, options=?, answer=?, lesson_slug=? WHERE id=?";
        jdbcTemplate.update(sql, quiz.getQuestion(), quiz.getOptions(), quiz.getAnswer(), quiz.getLessonSlug(), quiz.getId());
    }

    @Override
    public void deleteById(long id) {
        jdbcTemplate.update("DELETE FROM basic_grammar_quiz WHERE id=?", id);
    }

    @Override
    public BasicGrammarQuiz findById(long id) {
        List<BasicGrammarQuiz> list = jdbcTemplate.query("SELECT id, question, options, answer, lesson_slug AS lessonSlug FROM basic_grammar_quiz WHERE id=?", new BeanPropertyRowMapper<>(BasicGrammarQuiz.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<BasicGrammarQuiz> findByLessonSlug(String slug) {
        return jdbcTemplate.query("SELECT id, question, options, answer, lesson_slug AS lessonSlug FROM basic_grammar_quiz WHERE lesson_slug=?", new BeanPropertyRowMapper<>(BasicGrammarQuiz.class), slug);
    }
}


