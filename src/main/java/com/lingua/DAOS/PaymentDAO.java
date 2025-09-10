package com.lingua.DAOS;

import com.lingua.models.Payment;
import java.math.BigDecimal;
import java.util.List;

public interface PaymentDAO {
    int createPending(int studentId, int certificateId, BigDecimal amount, String method);
    void markSucceeded(int paymentId, String transactionId);
    Payment findById(int id);
    List<Payment> listAll();
}
