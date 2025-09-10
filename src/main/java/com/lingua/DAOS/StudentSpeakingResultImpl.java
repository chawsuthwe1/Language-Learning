package com.lingua.DAOS;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StudentSpeakingResultImpl implements StudentSpeakingResultDAO {

    @Autowired
    private JdbcTemplate jdbc;

    @Override
    public void save(int studentId, int exerciseId, int accuracy) {
        // Upsert accuracy, DO NOT flip completed here
        jdbc.update(
            "INSERT INTO student_speaking_results (student_id, exercise_id, accuracy, completed) " +
            "VALUES (?, ?, ?, 0) " +
            "ON DUPLICATE KEY UPDATE accuracy = VALUES(accuracy), updated_at = NOW()",
            studentId, exerciseId, accuracy
        );
    }

    @Override
    public void markComplete(int studentId, int exerciseId) {
        // Try update first
        int updated = jdbc.update(
            "UPDATE student_speaking_results " +
            "SET completed = 1, completed_at = NOW() " +
            "WHERE student_id = ? AND exercise_id = ?",
            studentId, exerciseId
        );

        // If no row existed yet, insert as completed
        if (updated == 0) {
            jdbc.update(
                "INSERT INTO student_speaking_results (student_id, exercise_id, accuracy, completed, completed_at) " +
                "VALUES (?, ?, 0, 1, NOW())",
                studentId, exerciseId
            );
        }
    }
}
