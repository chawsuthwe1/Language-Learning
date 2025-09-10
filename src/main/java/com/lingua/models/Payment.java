package com.lingua.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;

public class Payment {

    private int id;
    private int studentId;
    private BigDecimal amount;
    private String paymentMethod;
    private String transactionId;
    private LocalDateTime paymentDate;
    private String status;

    public Payment() {}

    // --- getters / setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public LocalDateTime getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDateTime paymentDate) { this.paymentDate = paymentDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // --- optional: equals/hashCode/toString ---

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Payment)) return false;
        Payment p = (Payment) o;
        return id == p.id &&
               studentId == p.studentId &&
               Objects.equals(amount, p.amount) &&
               Objects.equals(paymentMethod, p.paymentMethod) &&
               Objects.equals(transactionId, p.transactionId) &&
               Objects.equals(paymentDate, p.paymentDate) &&
               Objects.equals(status, p.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, studentId, amount, paymentMethod, transactionId, paymentDate, status);
    }

    @Override
    public String toString() {
        return "Payment{" +
                "id=" + id +
                ", studentId=" + studentId +
                ", amount=" + amount +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", paymentDate=" + paymentDate +
                ", status='" + status + '\'' +
                '}';
    }
}
