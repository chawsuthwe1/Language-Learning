package com.lingua.DAOS;

import com.lingua.models.ReadingPassage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReadingPassageJdbcDAO implements ReadingPassageDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insert(ReadingPassage p) {
        String sql = "INSERT INTO reading_passages (title, content) VALUES (?, ?)";
        jdbcTemplate.update(sql, p.getTitle(), p.getContent());
    }

    @Override
    public void update(ReadingPassage p) {
        String sql = "UPDATE reading_passages SET title=?, content=? WHERE id=?";
        jdbcTemplate.update(sql, p.getTitle(), p.getContent(), p.getId());
    }

    @Override
    public void deleteById(int id) {
        jdbcTemplate.update("DELETE FROM reading_passages WHERE id=?", id);
    }

    @Override
    public ReadingPassage findById(int id) {
        List<ReadingPassage> list = jdbcTemplate.query("SELECT * FROM reading_passages WHERE id=?", new BeanPropertyRowMapper<>(ReadingPassage.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<ReadingPassage> findAll() {
        return jdbcTemplate.query("SELECT * FROM reading_passages ORDER BY id DESC", new BeanPropertyRowMapper<>(ReadingPassage.class));
    }
}


