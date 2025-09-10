package com.lingua.controllers;

import com.lingua.DAOS.FinalTestDAO;
import com.lingua.DAOS.FinalTestQuestionDAO;
import com.lingua.DAOS.FinalTestResultDAO;
import com.lingua.models.FinalTest;
import com.lingua.models.FinalTestQuestion;
import com.lingua.models.FinalTestResult;
import com.lingua.models.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentFinalTestController {

    @Autowired
    private FinalTestDAO finalTestDAO;

    @Autowired
    private FinalTestQuestionDAO finalTestQuestionDAO;

    @Autowired
    private FinalTestResultDAO finalTestResultDAO;

    @GetMapping("/final-test")
    public String listFinalTests(Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";
        List<FinalTest> finalTests = finalTestDAO.findActiveTests();
        model.addAttribute("finalTests", finalTests);
        return "student/final-tests";
    }

    @GetMapping("/final-test/{testId}/start")
    public String startTest(@PathVariable Long testId, Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        Long sid = Long.valueOf(student.getStudent_id()); // CHANGED
        FinalTestResult existingResult = finalTestResultDAO.findByStudentAndTest(sid, testId); // CHANGED
        if (existingResult != null) {
            return "redirect:/student/final-test/" + testId + "/result";
        }
        return "redirect:/student/final-test/" + testId + "/session/1";
    }

    @GetMapping("/final-test/{testId}/session/{sessionNumber}")
    public String viewSession(@PathVariable Long testId, @PathVariable int sessionNumber,
                              Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        FinalTest finalTest = finalTestDAO.findById(testId);
        List<FinalTestQuestion> sessionQuestions = finalTestQuestionDAO.findBySessionNumber(testId, sessionNumber);
        model.addAttribute("finalTest", finalTest);
        model.addAttribute("questions", sessionQuestions);
        model.addAttribute("currentSession", sessionNumber);
        model.addAttribute("totalSessions", 4);
        return "student/take-final-test-session";
    }

    @PostMapping("/final-test/{testId}/submit")
    public String submitTest(@PathVariable Long testId, @RequestParam Map<String, String> answers,
                             HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        List<FinalTestQuestion> allQuestions = finalTestQuestionDAO.findByFinalTestId(testId);
        int correctAnswers = 0;
        for (FinalTestQuestion question : allQuestions) {
            String studentAnswer = answers.get("question_" + question.getId());
            if (studentAnswer != null && studentAnswer.equals(question.getCorrectAnswer())) {
                correctAnswers++;
            }
        }

        FinalTestResult result = new FinalTestResult( // CHANGED
                Long.valueOf(student.getStudent_id()), testId, correctAnswers, allQuestions.size());
        result.setAnswers(answers.toString());
        finalTestResultDAO.save(result);

        return "redirect:/student/final-test/" + testId + "/result";
    }

    @GetMapping("/final-test/{testId}/result")
    public String viewResult(@PathVariable Long testId, Model model, HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        FinalTest finalTest = finalTestDAO.findById(testId);
        Long sid2 = Long.valueOf(student.getStudent_id()); // CHANGED
        FinalTestResult result = finalTestResultDAO.findByStudentAndTest(sid2, testId); // CHANGED
        if (result == null) {
            return "redirect:/student/final-test/" + testId + "/start";
        }

        model.addAttribute("finalTest", finalTest);
        model.addAttribute("result", result);
        return "student/final-test-result";
    }
}
