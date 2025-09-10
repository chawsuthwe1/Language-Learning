package com.lingua.DAOS;

import java.util.List;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import com.lingua.models.SpeakingExercise;

@Repository
public class SpeakingExerciseImpl implements SpeakingExerciseDAO {
    @Autowired private JdbcTemplate jdbc;

    @Override public List<SpeakingExercise> findAll() {
        String sql = "SELECT id, title, content FROM speaking_exercises ORDER BY id DESC";
        return jdbc.query(sql, new BeanPropertyRowMapper<>(SpeakingExercise.class));
    }

    @Override public SpeakingExercise findById(int id) {
        String sql = "SELECT id, title, content FROM speaking_exercises WHERE id=?";
        List<SpeakingExercise> list = jdbc.query(sql, new BeanPropertyRowMapper<>(SpeakingExercise.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override public void save(SpeakingExercise e) {
        String sql = "INSERT INTO speaking_exercises (title, content) VALUES (?, ?)";
        jdbc.update(sql, e.getTitle(), e.getContent());
    }

    @Override public void update(SpeakingExercise e) {
        String sql = "UPDATE speaking_exercises SET title=?, content=? WHERE id=?";
        jdbc.update(sql, e.getTitle(), e.getContent(), e.getId());
    }

    @Override public void delete(int id) {
        jdbc.update("DELETE FROM speaking_exercises WHERE id=?", id);
    }
}
