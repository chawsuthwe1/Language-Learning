package com.lingua.DAOS;

import com.lingua.models.BasicReadingPassage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

//src/main/java/com/lingua/DAOS/ReadingLevelJdbcDAO.java

@Repository
public class ReadingLevelJdbcDAO implements ReadingLevelDAO {

 @Autowired
 private JdbcTemplate jdbcTemplate;

 private static class TableSpec {
     final String table;
     final String level;
     TableSpec(String table, String level){ this.table = table; this.level = level; }
 }

 private static final TableSpec[] TABLES = new TableSpec[]{
     new TableSpec("basic_reading_passages", "Beginner"),
     new TableSpec("pre_intermediate_reading_passages", "Pre-Intermediate"),
     new TableSpec("intermediate_reading_passages", "Intermediate"),
     new TableSpec("advanced_reading_passages", "Advanced")
 };

 @Override
 public List<BasicReadingPassage> findAllPassages() {
     List<BasicReadingPassage> all = new ArrayList<>();
     for (TableSpec spec : TABLES) {
         try {
             String sql = "SELECT id, ? AS level, title, paragraph FROM " + spec.table + " ORDER BY id DESC";
             all.addAll(jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicReadingPassage.class), spec.level));
         } catch (DataAccessException ignore) {}
     }
     return all;
 }

 @Override
 public List<BasicReadingPassage> findByLevel(String level) {
     for (TableSpec spec : TABLES) {
         if (spec.level.equals(level)) {
             try {
                 String sql = "SELECT id, title, paragraph, ? AS level FROM " + spec.table + " ORDER BY title";
                 return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicReadingPassage.class), spec.level);
             } catch (Exception ex) {
                 return java.util.Collections.emptyList();
             }
         }
     }
     return java.util.Collections.emptyList();
 }

 @Override
 public void insertPassage(BasicReadingPassage p) {
     String table = tableForLevel(p.getLevel());
     String sql = "INSERT INTO " + table + " (title, paragraph, level) VALUES (?, ?, ?)";
     jdbcTemplate.update(sql, p.getTitle(), p.getParagraph(), p.getLevel());
 }

 @Override
 public void updatePassage(BasicReadingPassage p) {
     String table = tableForLevel(p.getLevel());
     String sql = "UPDATE " + table + " SET title=?, paragraph=? WHERE id=?";
     jdbcTemplate.update(sql, p.getTitle(), p.getParagraph(), p.getId());
 }

 @Override
 public void deletePassage(long id) {
     for (TableSpec spec : TABLES) {
         try { jdbcTemplate.update("DELETE FROM " + spec.table + " WHERE id=?", id); } catch (DataAccessException ignore) {}
     }
 }

 private String tableForLevel(String level) {
     if (level == null) throw new IllegalArgumentException("level is required");
     switch (level) {
         case "Beginner": return "basic_reading_passages";
         case "Pre-Intermediate": return "pre_intermediate_reading_passages";
         case "Intermediate": return "intermediate_reading_passages";
         case "Advanced": return "advanced_reading_passages";
         default: throw new IllegalArgumentException("Unknown level: " + level);
     }
 }
}