package com.lingua.services;

import java.util.List;

import com.lingua.models.Activity;
import com.lingua.models.Student;

public interface StudentService {
    int countAll();
    List<Student> getAllStudents();
    void saveStudent(Student student);
    void updateStudent(Student student);

    Student getStudentById(int student_id);
    void deleteStudent(int student_id);
    Student findByEmailAndPassword(String email, String password);

   	Iterable<Activity> listAll();
}
