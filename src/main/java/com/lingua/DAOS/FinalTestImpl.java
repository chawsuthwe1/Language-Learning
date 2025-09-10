package com.lingua.DAOS;

import com.lingua.models.FinalTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FinalTestImpl implements FinalTestDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void save(FinalTest finalTest) {
        String sql = "INSERT INTO final_tests (title, description, total_questions, passing_score, is_active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
        jdbcTemplate.update(sql, finalTest.getTitle(), finalTest.getDescription(), 
                          finalTest.getTotalQuestions(), finalTest.getPassingScore(), finalTest.isActive());
    }

    @Override
    public FinalTest findById(Long id) {
        String sql = "SELECT * FROM final_tests WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(FinalTest.class), id);
    }

    @Override
    public List<FinalTest> findAll() {
        String sql = "SELECT * FROM final_tests ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTest.class));
    }

    @Override
    public void update(FinalTest finalTest) {
        String sql = "UPDATE final_tests SET title = ?, description = ?, total_questions = ?, passing_score = ?, is_active = ?, updated_at = NOW() WHERE id = ?";
        jdbcTemplate.update(sql, finalTest.getTitle(), finalTest.getDescription(), 
                          finalTest.getTotalQuestions(), finalTest.getPassingScore(), 
                          finalTest.isActive(), finalTest.getId());
    }

    @Override
    public void deleteById(Long id) {
        String sql = "DELETE FROM final_tests WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM final_tests";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public List<FinalTest> findActiveTests() {
        String sql = "SELECT * FROM final_tests WHERE is_active = true ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTest.class));
    }
}
