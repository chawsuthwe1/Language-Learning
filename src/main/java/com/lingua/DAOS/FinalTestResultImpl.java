package com.lingua.DAOS;

import com.lingua.models.FinalTestResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FinalTestResultImpl implements FinalTestResultDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void save(FinalTestResult result) {
        String sql = "INSERT INTO final_test_results (student_id, final_test_id, score, total_questions, percentage, passed, completed_at, answers) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, result.getStudentId(), result.getFinalTestId(), 
                          result.getScore(), result.getTotalQuestions(), result.getPercentage(), 
                          result.isPassed(), result.getCompletedAt(), result.getAnswers());
    }

    @Override
    public FinalTestResult findById(Long id) {
        String sql = "SELECT * FROM final_test_results WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(FinalTestResult.class), id);
    }

    @Override
    public List<FinalTestResult> findAll() {
        String sql = "SELECT * FROM final_test_results ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestResult.class));
    }

    @Override
    public List<FinalTestResult> findByStudentId(Long studentId) {
        String sql = "SELECT * FROM final_test_results WHERE student_id = ? ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestResult.class), studentId);
    }

    @Override
    public List<FinalTestResult> findByFinalTestId(Long finalTestId) {
        String sql = "SELECT * FROM final_test_results WHERE final_test_id = ? ORDER BY completed_at DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestResult.class), finalTestId);
    }

    @Override
    public FinalTestResult findByStudentAndTest(Long studentId, Long finalTestId) {
        String sql = "SELECT * FROM final_test_results WHERE student_id = ? AND final_test_id = ? ORDER BY completed_at DESC LIMIT 1";
        List<FinalTestResult> results = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(FinalTestResult.class), studentId, finalTestId);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public void update(FinalTestResult result) {
        String sql = "UPDATE final_test_results SET score = ?, total_questions = ?, percentage = ?, passed = ?, answers = ? WHERE id = ?";
        jdbcTemplate.update(sql, result.getScore(), result.getTotalQuestions(), 
                          result.getPercentage(), result.isPassed(), result.getAnswers(), result.getId());
    }

    @Override
    public void deleteById(Long id) {
        String sql = "DELETE FROM final_test_results WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countPassedResults(Long finalTestId) {
        String sql = "SELECT COUNT(*) FROM final_test_results WHERE final_test_id = ? AND passed = true";
        return jdbcTemplate.queryForObject(sql, Integer.class, finalTestId);
    }

    @Override
    public int countFailedResults(Long finalTestId) {
        String sql = "SELECT COUNT(*) FROM final_test_results WHERE final_test_id = ? AND passed = false";
        return jdbcTemplate.queryForObject(sql, Integer.class, finalTestId);
    }
}
