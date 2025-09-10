package com.lingua.DAOS;

import com.lingua.models.Assignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AssignmentImpl implements AssignmentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void addAssignment(Assignment assignment) {
        String sql = "INSERT INTO assignments (title, instructions, lesson_id) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, assignment.getTitle(), assignment.getInstructions(), assignment.getLessonId());
    }

    @Override
    public List<Assignment> getAllAssignments() {
        String sql = "SELECT * FROM assignments";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Assignment.class));
    }

    @Override
    public void deleteAssignment(Long id) {
        String sql = "DELETE FROM assignments WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }

	@Override
	public List<Assignment> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Assignment findById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void save(Assignment assignment) {
		// TODO Auto-generated method stub
		
	}
}
