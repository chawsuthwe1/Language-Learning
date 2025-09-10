package com.lingua.DAOS;

import com.lingua.models.FinalTestQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FinalTestQuestionImpl implements FinalTestQuestionDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void save(FinalTestQuestion question) {
        String sql = "INSERT INTO final_test_questions (final_test_id, question, option_a, option_b, option_c, option_d, correct_answer, session_number, difficulty) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, question.getFinalTestId(), question.getQuestion(), 
                          question.getOptionA(), question.getOptionB(), question.getOptionC(), 
                          question.getOptionD(), question.getCorrectAnswer(), 
                          question.getSessionNumber(), question.getDifficulty());
    }

    @Override
    public FinalTestQuestion findById(Long id) {
        String sql = "SELECT * FROM final_test_questions WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(FinalTestQuestion.class), id);
    }

    @Override
    public List<FinalTestQuestion> findAll() {
        String sql = "SELECT * FROM final_test_questions ORDER BY final_test_id, session_number, id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestQuestion.class));
    }

    @Override
    public List<FinalTestQuestion> findByFinalTestId(Long finalTestId) {
        String sql = "SELECT * FROM final_test_questions WHERE final_test_id = ? ORDER BY session_number, id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestQuestion.class), finalTestId);
    }

    @Override
    public List<FinalTestQuestion> findBySessionNumber(Long finalTestId, int sessionNumber) {
        String sql = "SELECT * FROM final_test_questions WHERE final_test_id = ? AND session_number = ? ORDER BY id";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestQuestion.class), finalTestId, sessionNumber);
    }

    @Override
    public void update(FinalTestQuestion question) {
        String sql = "UPDATE final_test_questions SET question = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_answer = ?, session_number = ?, difficulty = ? WHERE id = ?";
        jdbcTemplate.update(sql, question.getQuestion(), question.getOptionA(), 
                          question.getOptionB(), question.getOptionC(), question.getOptionD(), 
                          question.getCorrectAnswer(), question.getSessionNumber(), 
                          question.getDifficulty(), question.getId());
    }

    @Override
    public void deleteById(Long id) {
        String sql = "DELETE FROM final_test_questions WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public void deleteByFinalTestId(Long finalTestId) {
        String sql = "DELETE FROM final_test_questions WHERE final_test_id = ?";
        jdbcTemplate.update(sql, finalTestId);
    }

    @Override
    public int countByFinalTestId(Long finalTestId) {
        String sql = "SELECT COUNT(*) FROM final_test_questions WHERE final_test_id = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, finalTestId);
    }
}
