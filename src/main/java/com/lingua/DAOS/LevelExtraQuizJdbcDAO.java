// src/main/java/com/lingua/DAOS/LevelExtraQuizJdbcDAO.java

package com.lingua.DAOS;

import com.lingua.models.BasicReadingQuestion;
import com.lingua.models.BasicListeningTrueFalse;
import com.lingua.models.BasicVocabularyQuiz;
import com.lingua.models.BasicListeningMCQ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LevelExtraQuizJdbcDAO implements LevelExtraQuizDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private String readingTable(String level) {
        return switch (level) {
            case "Beginner" -> "basic_reading_questions";
            case "Pre-Intermediate" -> "pre_intermediate_reading_questions";
            case "Intermediate" -> "intermediate_reading_questions";
            case "Advanced" -> "advanced_reading_questions";
            default -> throw new IllegalArgumentException("Unknown level: " + level);
        };
    }

    private String listeningTFTable(String level) {
        return switch (level) {
            case "Beginner" -> "basic_listening_true_false_questions";
            case "Pre-Intermediate" -> "pre_intermediate_listening_true_false_questions";
            case "Intermediate" -> "intermediate_listening_true_false_questions";
            case "Advanced" -> "advanced_listening_true_false_questions";
            default -> throw new IllegalArgumentException("Unknown level: " + level);
        };
    }

    private String listeningMCQTable(String level) {
        return switch (level) {
            case "Beginner" -> "basic_listening_multiple_choice_questions";
            case "Pre-Intermediate" -> "pre_intermediate_listening_multiple_choice_questions"; // ✅ Fixed: muliple → multiple
            case "Intermediate" -> "intermediate_listening_multiple_choice_questions";
            case "Advanced" -> "advanced_listening_multiple_choice_questions";
            default -> throw new IllegalArgumentException("Unknown level: " + level);
        };
    }

    private String vocabularyTable(String level) {
        return switch (level) {
            case "Beginner" -> "basic_vocabulary_quiz";
            case "Pre-Intermediate" -> "pre_intermediate_vocabulary_quiz";
            case "Intermediate" -> "intermediate_vocabulary_quiz";
            case "Advanced" -> "advanced_vocabulary_quiz";
            default -> throw new IllegalArgumentException("Unknown level: " + level);
        };
    }

    // === Reading ===
    @Override
    public List<BasicReadingQuestion> findReadingByLevel(String level) {
        String t = readingTable(level);
        String sql = "SELECT id, reading_id AS readingId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM " + t + " ORDER BY id";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicReadingQuestion.class));
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public BasicReadingQuestion findReadingById(String level, long id) {
        String t = readingTable(level);
        String sql = "SELECT id, reading_id AS readingId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM " + t + " WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(BasicReadingQuestion.class), id);
        } catch (DataAccessException ex) {
            return null;
        }
    }

    @Override
    public void saveReading(String level, BasicReadingQuestion q) {
        String t = readingTable(level);
        if (q.getId() == null) {
            String sql = "INSERT INTO " + t + " (reading_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
        } else {
            String sql = "UPDATE " + t + " SET reading_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getReadingId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
        }
    }

    @Override
    public void deleteReading(long id) {
        String[] tables = {
            "basic_reading_questions", "pre_intermediate_reading_questions",
            "intermediate_reading_questions", "advanced_reading_questions"
        };
        for (String t : tables) {
            try { jdbcTemplate.update("DELETE FROM " + t + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }

    // === Listening True/False ===
    @Override
    public List<BasicListeningTrueFalse> findListeningTFByLevel(String level) {
        String t = listeningTFTable(level);
        String sql = "SELECT id, exercise_id AS exerciseId, statement, answer FROM " + t + " ORDER BY id";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicListeningTrueFalse.class));
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public BasicListeningTrueFalse findListeningTFById(String level, long id) {
        String t = listeningTFTable(level);
        String sql = "SELECT id, exercise_id AS exerciseId, statement, answer FROM " + t + " WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(BasicListeningTrueFalse.class), id);
        } catch (DataAccessException ex) {
            return null;
        }
    }

    @Override
    public void saveListeningTF(String level, BasicListeningTrueFalse q) {
        String t = listeningTFTable(level);
        if (q.getId() == null) {
            String sql = "INSERT INTO " + t + " (exercise_id, statement, answer) VALUES (?, ?, ?)";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer());
        } else {
            String sql = "UPDATE " + t + " SET exercise_id=?, statement=?, answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getStatement(), q.getAnswer(), q.getId());
        }
    }

    @Override
    public void deleteListeningTF(long id) {
        String[] tables = {
            "basic_listening_true_false_questions", "pre_intermediate_listening_true_false_questions",
            "intermediate_listening_true_false_questions", "advanced_listening_true_false_questions"
        };
        for (String t : tables) {
            try { jdbcTemplate.update("DELETE FROM " + t + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }

    // === Listening MCQ ===
    @Override
    public List<BasicListeningMCQ> findListeningMCQByLevel(String level) {
        String t = listeningMCQTable(level);
        String sql = "SELECT id, exercise_id AS exerciseId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM " + t + " ORDER BY id";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicListeningMCQ.class));
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public BasicListeningMCQ findListeningMCQById(String level, long id) {
        String t = listeningMCQTable(level);
        String sql = "SELECT id, exercise_id AS exerciseId, question_text AS questionText, choices, correct_answer AS correctAnswer FROM " + t + " WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(BasicListeningMCQ.class), id);
        } catch (DataAccessException ex) {
            return null;
        }
    }

    @Override
    public void saveListeningMCQ(String level, BasicListeningMCQ q) {
        String t = listeningMCQTable(level);
        if (q.getId() == null) {
            String sql = "INSERT INTO " + t + " (exercise_id, question_text, choices, correct_answer) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer());
        } else {
            String sql = "UPDATE " + t + " SET exercise_id=?, question_text=?, choices=?, correct_answer=? WHERE id=?";
            jdbcTemplate.update(sql, q.getExerciseId(), q.getQuestionText(), q.getChoices(), q.getCorrectAnswer(), q.getId());
        }
    }

    @Override
    public void deleteListeningMCQ(long id) {
        String[] tables = {
            "basic_listening_multiple_choice_questions", "pre_intermediate_listening_multiple_choice_questions",
            "intermediate_listening_multiple_choice_questions", "advanced_listening_multiple_choice_questions"
        };
        for (String t : tables) {
            try { jdbcTemplate.update("DELETE FROM " + t + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }

    // === Vocabulary ===
    @Override
    public List<BasicVocabularyQuiz> findVocabularyByLevel(String level) {
        String t = vocabularyTable(level);
        String sql = "SELECT id, category, question_type AS questionType, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_answer AS correctAnswer, related_word AS relatedWord FROM " + t + " ORDER BY id";
        try {
            return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(BasicVocabularyQuiz.class));
        } catch (DataAccessException ex) {
            ex.printStackTrace();
            return java.util.Collections.emptyList();
        }
    }

    @Override
    public BasicVocabularyQuiz findVocabularyById(String level, long id) {
        String t = vocabularyTable(level);
        String sql = "SELECT id, category, question_type AS questionType, question_text AS questionText, option_a AS optionA, option_b AS optionB, option_c AS optionC, option_d AS optionD, correct_answer AS correctAnswer, related_word AS relatedWord FROM " + t + " WHERE id=?";
        try {
            return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(BasicVocabularyQuiz.class), id);
        } catch (DataAccessException ex) {
            return null;
        }
    }

    @Override
    public void saveVocabulary(String level, BasicVocabularyQuiz q) {
        String t = vocabularyTable(level);
        if (q.getId() == null) {
            String sql = "INSERT INTO " + t + " (category, question_type, question_text, option_a, option_b, option_c, option_d, correct_answer, related_word) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord());
        } else {
            String sql = "UPDATE " + t + " SET category=?, question_type=?, question_text=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_answer=?, related_word=? WHERE id=?";
            jdbcTemplate.update(sql, q.getCategory(), q.getQuestionType(), q.getQuestionText(), q.getOptionA(), q.getOptionB(), q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getRelatedWord(), q.getId());
        }
    }

    @Override
    public void deleteVocabulary(long id) {
        String[] tables = {
            "basic_vocabulary_quiz", "pre_intermediate_vocabulary_quiz",
            "intermediate_vocabulary_quiz", "advanced_vocabulary_quiz"
        };
        for (String t : tables) {
            try { jdbcTemplate.update("DELETE FROM " + t + " WHERE id=?", id); } catch (DataAccessException ignore) {}
        }
    }
}