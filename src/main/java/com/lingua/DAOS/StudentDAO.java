package com.lingua.DAOS;

import com.lingua.models.Student;
import java.util.List;
public interface StudentDAO {
	List<Student> getAllStudents();
	void saveStudent(Student student);
	 void deleteStudent(int student_id);

	    Student getStudentById(int student_id);

	    int countAll();

	    Student findByEmailAndPassword(String email, String password);
	Student findbyEmailandPassword(String email,String password);
	void updateStudent(Student student);
}
