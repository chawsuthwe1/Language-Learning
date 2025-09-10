package com.lingua.models;

import java.time.LocalDateTime;

public class FinalTestResult {
    private Long id;
    private Long studentId;
    private Long finalTestId;
    private int score;
    private int totalQuestions;
    private double percentage;
    private boolean passed;
    private LocalDateTime completedAt;
    private String answers; // JSON string storing student answers

    public FinalTestResult() {}

    public FinalTestResult(Long studentId, Long finalTestId, int score, int totalQuestions) {
        this.studentId = studentId;
        this.finalTestId = finalTestId;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.percentage = (double) score / totalQuestions * 100;
        this.passed = this.percentage >= 40.0; // 40% passing requirement
        this.completedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getStudentId() { return studentId; }
    public void setStudentId(Long studentId) { this.studentId = studentId; }

    public Long getFinalTestId() { return finalTestId; }
    public void setFinalTestId(Long finalTestId) { this.finalTestId = finalTestId; }

    public int getScore() { return score; }
    public void setScore(int score) { 
        this.score = score;
        if (this.totalQuestions > 0) {
            this.percentage = (double) score / totalQuestions * 100;
            this.passed = this.percentage >= 40.0;
        }
    }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { 
        this.totalQuestions = totalQuestions;
        if (totalQuestions > 0) {
            this.percentage = (double) score / totalQuestions * 100;
            this.passed = this.percentage >= 40.0;
        }
    }

    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }

    public boolean isPassed() { return passed; }
    public void setPassed(boolean passed) { this.passed = passed; }

    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }

    public String getAnswers() { return answers; }
    public void setAnswers(String answers) { this.answers = answers; }
}
