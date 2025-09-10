package com.lingua.services;

import com.lingua.models.Student;
import com.lingua.models.Activity;
import com.lingua.DAOS.StudentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDAO studentDAO;

    @Override
    public int countAll() {
        return studentDAO.countAll();
    }

    @Override
    public List<Student> getAllStudents() {
    	var student = studentDAO.getAllStudents();
    	List<Student> students = studentDAO.getAllStudents(); // or studentRepository.findAll()

    	for (Student student1 : students) {
    	    System.out.println("ID: " + student1.getStudent_id());
    	    System.out.println("Name: " + student1.getName());
    	    System.out.println("Email: " + student1.getEmail());
    	    System.out.println("Password: " + student1.getPassword());
    	    System.out.println("Image: " + student1.getImage());
    	    System.out.println("-----------------------------");
    	}
        return studentDAO.getAllStudents(); // ✅ make sure this returns real data
    }


    @Override
    public void saveStudent(Student student) {
        studentDAO.saveStudent(student);
    }

    @Override
    public Student getStudentById(int student_id) {
    	Student student = studentDAO.getStudentById(student_id);
    	if (student != null) {
    	    System.out.println("Student exists: " + student.getName());
    	} else {
    	    System.out.println("No student found with ID: " + student_id);
    	}
        return studentDAO.getStudentById(student_id);
    }

    @Override
    public void deleteStudent(int student_id) {
        studentDAO.deleteStudent(student_id);
    }

    @Override
    public void updateStudent(Student student) {
        studentDAO.updateStudent(student);
    }
    @Override
    public Student findByEmailAndPassword(String email, String password) {
        return studentDAO.findByEmailAndPassword(email, password);
    }

	@Override
	public Iterable<Activity> listAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
