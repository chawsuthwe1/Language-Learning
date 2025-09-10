package com.lingua.DAOS;

import com.lingua.models.BasicListeningExercise;
import com.lingua.models.BasicListeningMCQ;
import com.lingua.models.BasicListeningTrueFalse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BasicListeningJdbcDAO implements BasicListeningDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insertExercise(BasicListeningExercise e) {
        String sql = "INSERT INTO basic_listening_exercises (level, title, audio_file, transcript) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, e.getLevel(), e.getTitle(), e.getAudioFile(), e.getTranscript());
    }

    @Override
    public void updateExercise(BasicListeningExercise e) {
        String sql = "UPDATE basic_listening_exercises SET level=?, title=?, audio_file=?, transcript=? WHERE id=?";
        jdbcTemplate.update(sql, e.getLevel(), e.getTitle(), e.getAudioFile(), e.getTranscript(), e.getId());
    }

    @Override
    public void deleteExercise(long id) {
        jdbcTemplate.update("DELETE FROM basic_listening_exercises WHERE id=?", id);
    }

    @Override
    public BasicListeningExercise findExercise(long id) {
        List<BasicListeningExercise> list = jdbcTemplate.query("SELECT id, level, title, audio_file AS audioFile, transcript FROM basic_listening_exercises WHERE id=?", new BeanPropertyRowMapper<>(BasicListeningExercise.class), id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<BasicListeningExercise> findAllExercises() {
        return jdbcTemplate.query("SELECT id, level, title, audio_file AS audioFile, transcript FROM basic_listening_exercises ORDER BY id DESC", new BeanPropertyRowMapper<>(BasicListeningExercise.class));
    }

    @Override
    public void insertMCQ(BasicListeningMCQ q) {
        String sql = "INSERT INTO basic_listening_multiple_choice_questions (exercise_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
    }

    @Override
    public void updateMCQ(BasicListeningMCQ q) {
        String sql = "UPDATE basic_listening_multiple_choice_questions SET exercise_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
        jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
    }

    @Override
    public void deleteMCQ(long id) {
        jdbcTemplate.update("DELETE FROM basic_listening_multiple_choice_questions WHERE id=?", id);
    }

    @Override
    public List<BasicListeningMCQ> findMCQByExercise(long exerciseId) {
        return jdbcTemplate.query("SELECT id, exercise_id AS exerciseId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM basic_listening_multiple_choice_questions WHERE exercise_id=?", new BeanPropertyRowMapper<>(BasicListeningMCQ.class), exerciseId);
    }

    @Override
    public void insertTF(BasicListeningTrueFalse q) {
        String sql = "INSERT INTO basic_listening_true_false_questions (exercise_id, statement, answer) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer());
    }

    @Override
    public void updateTF(BasicListeningTrueFalse q) {
        String sql = "UPDATE basic_listening_true_false_questions SET exercise_id=?, statement=?, answer=? WHERE id=?";
        jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer(), q.getId());
    }

    @Override
    public void deleteTF(long id) {
        jdbcTemplate.update("DELETE FROM basic_listening_true_false_questions WHERE id=?", id);
    }

    @Override
    public List<BasicListeningTrueFalse> findTFByExercise(long exerciseId) {
        return jdbcTemplate.query("SELECT id, exercise_id AS exerciseId, statement, answer FROM basic_listening_true_false_questions WHERE exercise_id=?", new BeanPropertyRowMapper<>(BasicListeningTrueFalse.class), exerciseId);
    }
}


