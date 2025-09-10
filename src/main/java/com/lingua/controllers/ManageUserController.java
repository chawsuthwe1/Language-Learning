package com.lingua.controllers;

import com.lingua.models.Student;
import com.lingua.services.StudentService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/students")
public class ManageUserController {

    @Autowired
    private StudentService studentService;

    @GetMapping
    public String showStudentManagement(Model model) {
        List<Student> students = studentService.getAllStudents(); // ✅ fetch from service
        System.out.print(students);
        model.addAttribute("students", students); // ✅ pass to JSP
        return "manage-students"; // ✅ matches your JSP filename
    }



    @PostMapping("/add")
    public String addStudent( @RequestParam(value = "studentId", required = false) Integer studentIdCamel,
            @RequestParam(value = "student_id", required = false) Integer studentIdSnake,
                             @RequestParam("name") String name,
                             @RequestParam("email") String email,
                             @RequestParam("password") String password,
                             @RequestParam(value = "image", required = false) String image) {

    	Integer resolvedId = (studentIdCamel != null) ? studentIdCamel : studentIdSnake;

        Student student = new Student();
        if (resolvedId != null) {
            student.setStudentId(resolvedId);  // camelCase setter
        }
        student.setName(name);
        student.setEmail(email);
        student.setPassword(password);
        student.setImage(image);

        studentService.saveStudent(student);
        return "redirect:/admin/students"; // ✅ This triggers the updated list
    }






    @GetMapping("/edit/{student_id}")
    public String editStudent(@PathVariable("student_id") int studentId, Model model) {
        Student s = studentService.getStudentById(studentId);
        model.addAttribute("student", s);
        return "edit-student"; // if you have this JSP; otherwise route differently
    }

    @PostMapping("/edit/{student_id}")
    public String updateStudent(@PathVariable("student_id") int studentId,
                                @RequestParam("name") String name,
                                @RequestParam("email") String email,
                                @RequestParam("password") String password,
                                @RequestParam(value = "image", required = false) String image
    	    ) {
    	Student student = new Student();
        student.setStudentId(studentId); // camelCase
        student.setName(name);
        student.setEmail(email);
        student.setPassword(password);
        student.setImage(image);

        studentService.updateStudent(student);
        return "redirect:/admin/students";
    }


    @GetMapping("/delete/{student_id}")
    public String deleteStudent(@PathVariable int student_id) {
        studentService.deleteStudent(student_id); // no cast needed
        return "redirect:/admin/students";
    }

}
