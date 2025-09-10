// src/main/java/com/lingua/DAOS/LessonLevelQuizJdbcDAO.java

package com.lingua.DAOS;

import com.lingua.models.LevelGrammarQuiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LessonLevelQuizJdbcDAO implements LessonLevelQuizDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private String tableFor(String level) {
        return switch (level.toLowerCase()) {
            case "basic" -> "basic_grammar_quiz";
            case "pre-intermediate", "preintermediate" -> "pre_intermediate_grammar_quiz"; // ✅ Accept both
            case "intermediate" -> "intermediate_grammar_quiz";
            case "advanced" -> "advanced_grammar_quiz";
            default -> throw new IllegalArgumentException("Unsupported level: " + level);
        };
    }

    @Override
    public List<LevelGrammarQuiz> findAll(String level) {
        String table = tableFor(level);
        String sql = "SELECT id, question, options, answer, lesson_slug AS lessonSlug FROM " + table + " ORDER BY id";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(LevelGrammarQuiz.class));
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public void save(String level, LevelGrammarQuiz q) {
        String table = tableFor(level);
        if (q.getId() == null) {
            String sql = "INSERT INTO " + table + " (question, options, answer, lesson_slug) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getQuestion(), q.getOptions(), q.getAnswer(), q.getLessonSlug());
        } else {
            String sql = "UPDATE " + table + " SET question=?, options=?, answer=?, lesson_slug=? WHERE id=?";
            jdbcTemplate.update(sql, q.getQuestion(), q.getOptions(), q.getAnswer(), q.getLessonSlug(), q.getId());
        }
    }

    @Override
    public void delete(String level, long id) {
        String table = tableFor(level);
        jdbcTemplate.update("DELETE FROM " + table + " WHERE id=?", id);
    }

    @Override
    public boolean lessonSlugExists(String level, String slug) {
        String table = tableFor(level).replace("quiz", "lessons");
        String sql = "SELECT COUNT(*) FROM " + table + " WHERE slug = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, slug);
        return count != null && count > 0;
    }

    @Override
    public List<String> findAllLessonSlugs(String level) {
        String table = tableFor(level).replace("quiz", "lessons");
        String sql = "SELECT slug FROM " + table + " ORDER BY title";
        try {
            return jdbcTemplate.queryForList(sql, String.class);
        } catch (Exception ex) {
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public LevelGrammarQuiz findById(String level, long id) {
        String table = tableFor(level);
        String sql = "SELECT id, question, options, answer, lesson_slug AS lessonSlug FROM " + table + " WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(LevelGrammarQuiz.class), id);
        } catch (DataAccessException ex) {
            return null;
        }
    }
}