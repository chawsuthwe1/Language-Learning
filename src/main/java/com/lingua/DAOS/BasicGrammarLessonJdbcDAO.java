package com.lingua.DAOS;

import com.lingua.models.BasicGrammarLesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BasicGrammarLessonJdbcDAO implements BasicGrammarLessonDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void insert(BasicGrammarLesson lesson) {
        String sql = "INSERT INTO basic_grammar_lessons (slug, title, description, content_html, level) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, lesson.getSlug(), lesson.getTitle(), lesson.getDescription(), lesson.getContentHtml(), lesson.getLevel());
    }

    @Override
    public void update(BasicGrammarLesson lesson) {
        String sql = "UPDATE basic_grammar_lessons SET title=?, description=?, content_html=?, level=? WHERE slug=?";
        jdbcTemplate.update(sql, lesson.getTitle(), lesson.getDescription(), lesson.getContentHtml(), lesson.getLevel(), lesson.getSlug());
    }

    @Override
    public void deleteBySlug(String slug) {
        jdbcTemplate.update("DELETE FROM basic_grammar_lessons WHERE slug=?", slug);
    }

    @Override
    public BasicGrammarLesson findBySlug(String slug) {
        List<BasicGrammarLesson> list = jdbcTemplate.query("SELECT slug, title, description, content_html AS contentHtml, level FROM basic_grammar_lessons WHERE slug=?", new BeanPropertyRowMapper<>(BasicGrammarLesson.class), slug);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<BasicGrammarLesson> findAll() {
        return jdbcTemplate.query("SELECT slug, title, description, content_html AS contentHtml, level FROM basic_grammar_lessons ORDER BY title ASC", new BeanPropertyRowMapper<>(BasicGrammarLesson.class));
    }
}


