package com.lingua.DAOS;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.lingua.models.Student;

@Repository
public class StudentImple implements StudentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void saveStudent(Student student) {
        // Insert with level; DB default would also work, but being explicit is clearer
        String sql = """
            INSERT INTO students (name, email, password, level)
            VALUES (?, ?, ?, ?)
            """;
        jdbcTemplate.update(sql,
                student.getName(),
                student.getEmail(),
                student.getPassword(),
                student.getLevel() // "Beginner" by default from model
        );

        // If you also want to insert image or last_placement_score at registration time, use:
        // String sql2 = "INSERT INTO students (name, email, password, image, level, last_placement_score) VALUES (?, ?, ?, ?, ?, ?)";
        // jdbcTemplate.update(sql2, student.getName(), student.getEmail(), student.getPassword(), student.getImage(), student.getLevel(), student.getLastPlacementScore());
    }

    @Override
    public List<Student> getAllStudents() {
        // Use explicit select + alias so BeanPropertyRowMapper maps student_id -> user_id
        String sql = """
            SELECT
                student_id AS user_id,
                name, email, password, image, level
            FROM students
            """;
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Student.class));
    }

    @Override
    public Student findbyEmailandPassword(String email, String password) {
        // Read level and image too so session carries the full student
        String sql = """
            SELECT
                student_id AS user_id,
                name, email, password, image, level
            FROM students
            WHERE email = ? AND password = ?
            """;
        List<Student> list = jdbcTemplate.query(
                sql,
                new BeanPropertyRowMapper<>(Student.class),
                email, password
        );
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void updateStudent(Student student) {
        // Include level so placement result is persisted
        String sql = """
            UPDATE students
               SET name = ?,
                   email = ?,
                   password = ?,
                   image = ?,
                   level = ?
             WHERE student_id = ?
            """;
        jdbcTemplate.update(sql,
                student.getName(),
                student.getEmail(),
                student.getPassword(),
                student.getImage(),
                student.getLevel(),
                student.getStudent_id()
        );

        // If you later add last_placement_score, switch to:
        // String sql2 = "UPDATE students SET name=?, email=?, password=?, image=?, level=?, last_placement_score=? WHERE student_id=?";
        // jdbcTemplate.update(sql2, student.getName(), student.getEmail(), student.getPassword(), student.getImage(), student.getLevel(), student.getLastPlacementScore(), student.getStudent_id());
    }

    @Override
    public void deleteStudent(int student_id) {
        String sql = "DELETE FROM students WHERE student_id = ?";
        jdbcTemplate.update(sql, student_id);
    }

    @Override
    public Student findByEmailAndPassword(String email, String password) {
        return findbyEmailandPassword(email, password);
    }

    @Override
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM students";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    @Override
    public Student getStudentById(int student_id) {
        String sql = """
            SELECT
                student_id AS user_id,
                name, email, password, image, level
            FROM students
            WHERE student_id = ?
            """;
        List<Student> list = jdbcTemplate.query(sql,
                new BeanPropertyRowMapper<>(Student.class),
                student_id);
        return list.isEmpty() ? null : list.get(0);
    }
}
