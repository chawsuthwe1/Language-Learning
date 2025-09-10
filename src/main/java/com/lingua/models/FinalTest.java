package com.lingua.models;

import java.time.LocalDateTime;

public class FinalTest {
    private Long id;
    private String title;
    private String description;
    private int totalQuestions;
    private int passingScore; // 40% = 40
    private boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public FinalTest() {}

    public FinalTest(String title, String description, int totalQuestions, int passingScore) {
        this.title = title;
        this.description = description;
        this.totalQuestions = totalQuestions;
        this.passingScore = passingScore;
        this.isActive = true;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public int getPassingScore() { return passingScore; }
    public void setPassingScore(int passingScore) { this.passingScore = passingScore; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
