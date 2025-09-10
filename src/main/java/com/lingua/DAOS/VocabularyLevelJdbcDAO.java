// src/main/java/com/lingua/DAOS/VocabularyLevelJdbcDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicVocabulary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class VocabularyLevelJdbcDAO implements VocabularyLevelDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static class TableSpec {
        final String table;
        final String level;
        TableSpec(String t, String l) { table = t; level = l; }
    }

    private static final TableSpec[] TABLES = new TableSpec[]{
        new TableSpec("basic_vocabulary", "Beginner"),
        new TableSpec("pre_intermediate_vocabulary", "Pre-Intermediate"),
        new TableSpec("intermediate_vocabulary", "Intermediate"),
        new TableSpec("advanced_vocabulary", "Advanced")
    };

    @Override
    public List<BasicVocabulary> findAllWords() {
        List<BasicVocabulary> all = new ArrayList<>();
        for (TableSpec spec : TABLES) {
            try {
                String sql = "SELECT id, category, word, definition, example, image, ? AS level FROM " + spec.table + " ORDER BY id DESC";
                all.addAll(jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicVocabulary.class), spec.level));
            } catch (DataAccessException ignore) {}
        }
        return all;
    }

    @Override
    public void insertWord(BasicVocabulary v) {
        String table = tableForLevel(v.getLevel());
        String sql = "INSERT INTO " + table + " (category, word, definition, example, image) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, v.getCategory(), v.getWord(), v.getDefinition(), v.getExample(), v.getImage());
    }

    @Override
    public void updateWord(BasicVocabulary v) {
        String table = tableForLevel(v.getLevel());
        String sql = "UPDATE " + table + " SET category=?, word=?, definition=?, example=?, image=? WHERE id=?";
        jdbcTemplate.update(sql, v.getCategory(), v.getWord(), v.getDefinition(), v.getExample(), v.getImage(), v.getId());
    }

    @Override
    public void deleteWord(long id) {
        for (TableSpec spec : TABLES) {
            try { jdbcTemplate.update("DELETE FROM " + spec.table + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }

    // ✅ NEW METHOD: Find words by level
    @Override
    public List<BasicVocabulary> findByLevel(String level) {
        for (TableSpec spec : TABLES) {
            if (spec.level.equals(level)) {
                try {
                    String sql = "SELECT id, category, word, definition, example, image, ? AS level FROM " + spec.table + " ORDER BY word ASC";
                    return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicVocabulary.class), spec.level);
                } catch (DataAccessException ex) {
                    ex.printStackTrace();
                    return java.util.Collections.emptyList();
                }
            }
        }
        return java.util.Collections.emptyList();
    }

    private String tableForLevel(String level) {
        if (level == null) return "basic_vocabulary";
        switch (level) {
            case "Beginner": return "basic_vocabulary";
            case "Pre-Intermediate": return "pre_intermediate_vocabulary";
            case "Intermediate": return "intermediate_vocabulary";
            case "Advanced": return "advanced_vocabulary";
            default: return "basic_vocabulary";
        }
    }
}