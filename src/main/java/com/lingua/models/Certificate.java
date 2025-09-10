package com.lingua.models;

import java.time.LocalDate;

public class Certificate {

    private int id;
    private int studentId;
    private String courseName;
    private String title;
    private String status;
    private String certificateCode;
    private LocalDate issueDate;

    // Fields for final test linkage
    private Long finalTestId;
    private Long finalTestResultId;
    private String level; // Level of the test: Beginner / Intermediate / Advanced

    // -------------------- Getters & Setters --------------------
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCertificateCode() { return certificateCode; }
    public void setCertificateCode(String certificateCode) { this.certificateCode = certificateCode; }

    public LocalDate getIssueDate() { return issueDate; }
    public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }

    public Long getFinalTestId() { return finalTestId; }
    public void setFinalTestId(Long finalTestId) { this.finalTestId = finalTestId; }

    public Long getFinalTestResultId() { return finalTestResultId; }
    public void setFinalTestResultId(Long finalTestResultId) { this.finalTestResultId = finalTestResultId; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}
