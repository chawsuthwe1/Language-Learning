package com.lingua.DAOS;

import com.lingua.models.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LessonImpl implements LessonDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void addLesson(Lesson lesson) {
        String sql = "INSERT INTO lessons (title, description, video_url, material_path) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                lesson.getTitle(),
                lesson.getDescription(),
                lesson.getVideoUrl(),
                lesson.getMaterialPath());
    }

    @Override
    public void save(Lesson lesson) {
        String sql = "UPDATE lessons SET title = ?, description = ?, video_url = ?, material_path = ? WHERE id = ?";
        jdbcTemplate.update(sql,
                lesson.getTitle(),
                lesson.getDescription(),
                lesson.getVideoUrl(),
                lesson.getMaterialPath(),
                lesson.getId());
    }

    @Override
    public List<Lesson> findAll() {
        String sql = "SELECT * FROM lessons";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Lesson.class));
    }

    @Override
    public Lesson findById(int id) {
        String sql = "SELECT * FROM lessons WHERE id = ?";
        List<Lesson> lessons = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Lesson.class), id);
        return lessons.isEmpty() ? null : lessons.get(0);
    }

    @Override
    public void deleteById(int id) {
        String sql = "DELETE FROM lessons WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM lessons";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
