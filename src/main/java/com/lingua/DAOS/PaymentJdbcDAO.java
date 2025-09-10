package com.lingua.DAOS;

import com.lingua.models.Payment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@Repository
public class PaymentJdbcDAO implements PaymentDAO {

    @Autowired
    private JdbcTemplate jdbc;

    private static final RowMapper<Payment> ROW = new RowMapper<Payment>() {
        @Override
        public Payment mapRow(ResultSet rs, int rowNum) throws SQLException {
            Payment p = new Payment();
            p.setId(rs.getInt("id"));
            p.setStudentId(rs.getInt("student_id"));
            p.setAmount(rs.getBigDecimal("amount"));
            p.setPaymentMethod(rs.getString("payment_method"));
            p.setTransactionId(rs.getString("transaction_id"));
            Timestamp ts = rs.getTimestamp("payment_date");
            p.setPaymentDate(ts != null ? ts.toLocalDateTime() : null);
            p.setStatus(rs.getString("status"));
            return p;
        }
    };

    @Override
    public int createPending(int studentId, int certificateId, java.math.BigDecimal amount, String method) {
        jdbc.update("""
            INSERT INTO payments(student_id, amount, payment_method, status, certificate_id)
            VALUES (?,?,?, 'PENDING', ?)
        """, studentId, amount, method, certificateId);
        return jdbc.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
    }

    @Override
    public void markSucceeded(int paymentId, String transactionId) {
        jdbc.update("""
            UPDATE payments
               SET status='SUCCEEDED', transaction_id=?, payment_date=NOW()
             WHERE id=?
        """, transactionId, paymentId);
    }

    @Override
    public Payment findById(int id) {
        List<Payment> list = jdbc.query("SELECT * FROM payments WHERE id=?", ROW, id);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public List<Payment> listAll() {
        return jdbc.query("SELECT * FROM payments ORDER BY id DESC", ROW);
    }
}
