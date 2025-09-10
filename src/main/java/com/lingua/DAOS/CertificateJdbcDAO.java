package com.lingua.DAOS;

import com.lingua.models.Certificate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Repository
public class CertificateJdbcDAO implements CertificateDAO {

    @Autowired
    private JdbcTemplate jdbc;

    private static final RowMapper<Certificate> ROW = (rs, rowNum) -> {
        Certificate c = new Certificate();
        c.setId(rs.getInt("id"));
        c.setStudentId(rs.getInt("student_id"));
        c.setCourseName(rs.getString("course_name"));
        c.setStatus(rs.getString("status"));
        c.setCertificateCode(rs.getString("certificate_code"));
        Date d = rs.getDate("issue_date");
        c.setIssueDate(d != null ? d.toLocalDate() : null);
        c.setFinalTestId(rs.getLong("final_test_id"));
        return c;
    };

    @Override
    public Certificate createRequestFromFinalTest(int studentId, int finalTestId) {
        return createRequestFromFinalTest(studentId, finalTestId, null);
    }

    @Override
    public Certificate createRequestFromFinalTest(int studentId, int finalTestId, String level) {
        String courseName = (level != null) ? level : "English Proficiency";
        jdbc.update(
            "INSERT INTO certificates (student_id, final_test_id, course_name, status) VALUES (?,?,?, 'PENDING_ADMIN')",
            studentId, finalTestId, courseName
        );

        Integer id = jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
        if (id == null) return null;

        Certificate c = new Certificate();
        c.setId(id);
        c.setStudentId(studentId);
        c.setFinalTestId((long) finalTestId);
        c.setCourseName(courseName);
        c.setStatus("PENDING_ADMIN");
        return c;
    }

    @Override
    public Certificate findById(int id) {
        List<Certificate> list = jdbc.query("SELECT * FROM certificates WHERE id = ?", ROW, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Certificate> findByStudentId(int studentId) {
        return jdbc.query("SELECT * FROM certificates WHERE student_id = ? ORDER BY id DESC", ROW, studentId);
    }

    @Override
    public List<Certificate> listByStatusForStudent(String status, int studentId) {
        return jdbc.query(
            "SELECT * FROM certificates WHERE status=? AND student_id=? ORDER BY id DESC",
            ROW, status, studentId
        );
    }

    @Override
    public void updateStatus(int id, String status) {
        jdbc.update("UPDATE certificates SET status=? WHERE id=?", status, id);
    }

    @Override
    public void issue(int id, String certificateCode, LocalDate issueDate) {
        jdbc.update(
            "UPDATE certificates SET certificate_code=?, issue_date=?, status='ISSUED' WHERE id=?",
            certificateCode, Date.valueOf(issueDate), id
        );
    }

    @Override
    public Certificate findLatestForStudentCourse(int studentId, String courseName) {
        List<Certificate> list = jdbc.query(
            "SELECT * FROM certificates WHERE student_id=? AND course_name=? ORDER BY id DESC LIMIT 1",
            ROW, studentId, courseName
        );
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public void linkToFinalTest(int certificateId, Long finalTestId, Long resultId) {
        jdbc.update(
            "UPDATE certificates SET final_test_id=?, final_test_result_id=? WHERE id=?",
            finalTestId, resultId, certificateId
        );
    }

    @Override
    public int createRequest(int studentId, String courseName) {
        jdbc.update(
            "INSERT INTO certificates (student_id, course_name, status) VALUES (?, ?, 'PENDING_ADMIN')",
            studentId, courseName
        );
        return jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }

    @Override
    public List<Certificate> findAll() {
        return jdbc.query("SELECT * FROM certificates ORDER BY id DESC", ROW);
    }

    @Override
    public List<Certificate> listByStatus(String status) {
        return jdbc.query("SELECT * FROM certificates WHERE status=? ORDER BY id DESC", ROW, status);
    }
    @Override
    public void updateCourseName(int id, String courseName) {
        jdbc.update("UPDATE certificates SET course_name=? WHERE id=?", courseName, id);
    }

}
