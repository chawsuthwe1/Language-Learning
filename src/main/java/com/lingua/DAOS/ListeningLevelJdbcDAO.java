package com.lingua.DAOS;

import com.lingua.models.BasicListeningExercise;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ListeningLevelJdbcDAO implements ListeningLevelDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static class TableSpec { final String table; final String level; TableSpec(String t, String l){ table=t; level=l; } }

    private static final TableSpec[] TABLES = new TableSpec[]{
        new TableSpec("basic_listening_exercises", "Beginner"),
        new TableSpec("pre_intermediate_listening_exercises", "Pre-Intermediate"),
        new TableSpec("intermediate_listening_exercises", "Intermediate"),
        new TableSpec("advanced_listening_exercises", "Advanced")
    };

    @Override
    public List<BasicListeningExercise> findAllExercises() {
        List<BasicListeningExercise> all = new ArrayList<>();
        for (TableSpec spec : TABLES) {
            try {
                String sql = "SELECT id, ? AS level, title, audio_file AS audioFile, transcript FROM " + spec.table + " ORDER BY id DESC";
                all.addAll(jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicListeningExercise.class), spec.level));
            } catch (DataAccessException ignore) {}
        }
        return all;
    }

    @Override
    public List<BasicListeningExercise> findByLevel(String level) {
        for (TableSpec spec : TABLES) {
            if (spec.level.equals(level)) {
                try {
                    String sql = "SELECT id, title, audio_file AS audioFile, transcript, ? AS level FROM " + spec.table + " ORDER BY title";
                    return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicListeningExercise.class), spec.level);
                } catch (Exception ex) {
                    return java.util.Collections.emptyList();
                }
            }
        }
        return java.util.Collections.emptyList();
    }

    @Override
    public void insertExercise(BasicListeningExercise e) {
        String table = tableForLevel(e.getLevel());
        String sql = "INSERT INTO " + table + " (title, audio_file, transcript, level) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, e.getTitle(), e.getAudioFile(), e.getTranscript(), e.getLevel());
    }

    @Override
    public void updateExercise(BasicListeningExercise e) {
        String table = tableForLevel(e.getLevel());
        String sql = "UPDATE " + table + " SET title=?, audio_file=?, transcript=? WHERE id=?";
        jdbcTemplate.update(sql, e.getTitle(), e.getAudioFile(), e.getTranscript(), e.getId());
    }

    @Override
    public void deleteExercise(long id) {
        for (TableSpec spec : TABLES) {
            try { jdbcTemplate.update("DELETE FROM " + spec.table + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }

    private String tableForLevel(String level) {
        if (level == null) throw new IllegalArgumentException("level is required");
        switch (level) {
            case "Beginner": return "basic_listening_exercises";
            case "Pre-Intermediate": return "pre_intermediate_listening_exercises";
            case "Intermediate": return "intermediate_listening_exercises";
            case "Advanced": return "advanced_listening_exercises";
            default: throw new IllegalArgumentException("Unknown level: " + level);
        }
    }
}