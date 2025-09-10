package com.lingua.DAOS;

import com.lingua.models.Certificate;
import java.time.LocalDate;
import java.util.List;

public interface CertificateDAO {

    // Remove 'title' from this method
    int createRequest(int studentId, String courseName);

    Certificate createRequestFromFinalTest(int studentId, int finalTestId);
    Certificate createRequestFromFinalTest(int studentId, int finalTestId, String level);

    Certificate findById(int id);
    List<Certificate> findAll();
    List<Certificate> listByStatus(String status);
    List<Certificate> findByStudentId(int studentId);

    void updateStatus(int id, String status);                     
    void issue(int id, String certificateCode, LocalDate date);   

    Certificate findLatestForStudentCourse(int studentId, String courseName);

    void linkToFinalTest(int certificateId, Long finalTestId, Long resultId);

    // NEW: list certificates by status for a specific student
    List<Certificate> listByStatusForStudent(String status, int studentId);

    void updateCourseName(int id, String courseName);
    
}
