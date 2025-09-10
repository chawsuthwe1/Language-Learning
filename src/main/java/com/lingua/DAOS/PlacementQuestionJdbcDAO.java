package com.lingua.DAOS;

import com.lingua.models.PlacementQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PlacementQuestionJdbcDAO implements PlacementQuestionDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insert(PlacementQuestion q) {
    	String sql = "INSERT INTO placement_questions (section, question_text, option_a, option_b, option_c, option_d, correct_option, passage_id, question_type, audio_url) VALUES (?,?,?,?,?,?,?,?,?,?)";
    	jdbcTemplate.update(sql, q.getSection(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectOption(), q.getPassageId(), q.getQuestionType(), q.getAudioUrl());

    }

    @Override
    public void update(PlacementQuestion q) {
    	String sql = "UPDATE placement_questions SET section=?, question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=?, passage_id=?, question_type=?, audio_url=? WHERE id=?";
    	jdbcTemplate.update(sql, q.getSection(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectOption(), q.getPassageId(), q.getQuestionType(), q.getAudioUrl(), q.getId());

    }

    @Override
    public void deleteById(int id) {
        jdbcTemplate.update("DELETE FROM placement_questions WHERE id=?", id);
    }

    @Override
    public PlacementQuestion findById(int id) {
        String sql = "SELECT id, section, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_option AS correctOption, passage_id AS passageId, question_type AS questionType FROM placement_questions WHERE id=?";
        List<PlacementQuestion> list = jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PlacementQuestion.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<PlacementQuestion> findAll() {
        String sql = "SELECT id, section, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_option AS correctOption, passage_id AS passageId, question_type AS questionType FROM placement_questions ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PlacementQuestion.class));
    }

    @Override
    public List<PlacementQuestion> findBySection(String section) {
        String sql = "SELECT id, section, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_option AS correctOption, passage_id AS passageId, question_type AS questionType FROM placement_questions WHERE section=? ORDER BY id DESC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(PlacementQuestion.class), section);
    }
}


