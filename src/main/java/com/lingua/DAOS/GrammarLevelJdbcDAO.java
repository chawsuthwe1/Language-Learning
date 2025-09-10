package com.lingua.DAOS;

import com.lingua.models.BasicGrammarLesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class GrammarLevelJdbcDAO implements GrammarLevelDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static class TableSpec {
        final String table;
        final String level;
        TableSpec(String table, String level){ this.table = table; this.level = level; }
    }

    private static final TableSpec[] TABLES = new TableSpec[]{
        new TableSpec("basic_grammar_lessons", "Beginner"),
        new TableSpec("pre_intermediate_grammar_lessons", "Pre-Intermediate"),
        new TableSpec("intermediate_grammar_lessons", "Intermediate"),
        new TableSpec("advanced_grammar_lessons", "Advanced")
    };

    @Override
    public List<BasicGrammarLesson> findAllLessons() {
        List<BasicGrammarLesson> all = new ArrayList<>();
        for (TableSpec spec : TABLES) {
            try {
                String sql = "SELECT slug, title, description, content_html AS contentHtml, ? AS level FROM " + spec.table + " ORDER BY title ASC";
                all.addAll(jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicGrammarLesson.class), spec.level));
            } catch (DataAccessException ignore) {}
        }
        return all;
    }

    @Override
    public List<BasicGrammarLesson> findByLevel(String level) {
        for (TableSpec spec : TABLES) {
            if (spec.level.equals(level)) {
                try {
                    String sql = "SELECT slug, title, description, content_html AS contentHtml, ? AS level FROM " + spec.table + " ORDER BY title";
                    return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicGrammarLesson.class), spec.level);
                } catch (Exception ex) {
                    return java.util.Collections.emptyList();
                }
            }
        }
        return java.util.Collections.emptyList();
    }

    @Override
    public void insertLesson(BasicGrammarLesson lesson) {
        String table = tableForLevel(lesson.getLevel());
        String sql = "INSERT INTO " + table + " (slug, title, description, content_html, level) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, lesson.getSlug(), lesson.getTitle(), lesson.getDescription(), lesson.getContentHtml(), lesson.getLevel());
    }

    @Override
    public void updateLesson(BasicGrammarLesson lesson) {
        String table = tableForLevel(lesson.getLevel());
        String sql = "UPDATE " + table + " SET title=?, description=?, content_html=?, level=? WHERE slug=?";
        jdbcTemplate.update(sql, lesson.getTitle(), lesson.getDescription(), lesson.getContentHtml(), lesson.getLevel(), lesson.getSlug());
    }

    @Override
    public void deleteLesson(String slug) {
        for (TableSpec spec : TABLES) {
            try { jdbcTemplate.update("DELETE FROM " + spec.table + " WHERE slug=?", slug); } catch (DataAccessException ignore) {}
        }
    }

    @Override
    public BasicGrammarLesson findBySlug(String slug) {
        for (TableSpec spec : TABLES) {
            try {
                String sql = "SELECT slug, title, description, content_html AS contentHtml, ? AS level FROM " + spec.table + " WHERE slug=?";
                List<BasicGrammarLesson> list = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicGrammarLesson.class), spec.level, slug);
                if (!list.isEmpty()) return list.get(0);
            } catch (DataAccessException ignore) {}
        }
        return null;
    }

    private String tableForLevel(String level) {
        if (level == null) throw new IllegalArgumentException("level is required");
        switch (level) {
            case "Beginner": return "basic_grammar_lessons";
            case "Pre-Intermediate": return "pre_intermediate_grammar_lessons";
            case "Intermediate": return "intermediate_grammar_lessons";
            case "Advanced": return "advanced_grammar_lessons";
            default: throw new IllegalArgumentException("Unknown level: " + level);
        }
    }
}