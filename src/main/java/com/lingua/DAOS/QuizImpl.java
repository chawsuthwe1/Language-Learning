package com.lingua.DAOS;

import com.lingua.models.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class QuizImpl implements QuizDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void addQuiz(Quiz quiz) {
        String sql = "INSERT INTO quizzes (question, answer, lesson_id) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, quiz.getQuestion(), quiz.getAnswer(), quiz.getLessonId());
    }

    @Override
    public List<Quiz> getAllQuizzes() {
        String sql = "SELECT * FROM quizzes";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Quiz.class));
    }

    @Override
    public void deleteQuiz(Long id) {
        String sql = "DELETE FROM quizzes WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public List<Quiz> findAll() {
        String sql = "SELECT * FROM quizzes";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Quiz.class));
    }

    @Override
    public void save(Quiz quiz) {
        String sql = "UPDATE quizzes SET question = ?, answer = ?, lesson_id = ? WHERE id = ?";
        jdbcTemplate.update(sql, quiz.getQuestion(), quiz.getAnswer(), quiz.getLessonId(), quiz.getId());
    }

    @Override
    public void updateQuiz(Quiz quiz) {
        String sql = "UPDATE quizzes SET question = ?, answer = ?, lesson_id = ? WHERE id = ?";
        jdbcTemplate.update(sql, quiz.getQuestion(), quiz.getAnswer(), quiz.getLessonId(), quiz.getId());
    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE FROM quizzes WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM quizzes";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
