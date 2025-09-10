package com.lingua.controllers;

import com.lingua.DAOS.FinalTestDAO;
import com.lingua.DAOS.FinalTestQuestionDAO;
import com.lingua.DAOS.FinalTestResultDAO;
import com.lingua.models.FinalTest;
import com.lingua.models.FinalTestQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/final-tests")
public class FinalTestController {

    @Autowired
    private FinalTestDAO finalTestDAO;

    @Autowired
    private FinalTestQuestionDAO finalTestQuestionDAO;

    @Autowired
    private FinalTestResultDAO finalTestResultDAO;

    @GetMapping
    public String viewFinalTests(Model model) {
        List<FinalTest> finalTests = finalTestDAO.findAll();
        model.addAttribute("finalTests", finalTests);
        model.addAttribute("newFinalTest", new FinalTest());
        return "admin/final-tests";
    }

    @PostMapping("/add")
    public String addFinalTest(@ModelAttribute FinalTest finalTest) {
        if (finalTest.getPassingScore() == 0) {
            finalTest.setPassingScore(40); // Default 40% passing score
        }
        finalTestDAO.save(finalTest);
        return "redirect:/admin/final-tests";
    }

    @PostMapping("/update/{id}")
    public String updateFinalTest(@PathVariable Long id, @ModelAttribute FinalTest updatedTest) {
        updatedTest.setId(id);
        finalTestDAO.update(updatedTest);
        return "redirect:/admin/final-tests";
    }

    @GetMapping("/delete/{id}")
    public String deleteFinalTest(@PathVariable Long id) {
        // Delete all questions first
        finalTestQuestionDAO.deleteByFinalTestId(id);
        // Then delete the test
        finalTestDAO.deleteById(id);
        return "redirect:/admin/final-tests";
    }

    @GetMapping("/{id}/questions")
    public String viewQuestions(@PathVariable Long id, Model model) {
        FinalTest finalTest = finalTestDAO.findById(id);
        List<FinalTestQuestion> questions = finalTestQuestionDAO.findByFinalTestId(id);
        
        model.addAttribute("finalTest", finalTest);
        model.addAttribute("questions", questions);
        model.addAttribute("newQuestion", new FinalTestQuestion());
        
        // Group questions by session
        model.addAttribute("session1Questions", questions.stream().filter(q -> q.getSessionNumber() == 1).toList());
        model.addAttribute("session2Questions", questions.stream().filter(q -> q.getSessionNumber() == 2).toList());
        model.addAttribute("session3Questions", questions.stream().filter(q -> q.getSessionNumber() == 3).toList());
        model.addAttribute("session4Questions", questions.stream().filter(q -> q.getSessionNumber() == 4).toList());
        
        return "admin/final-test-questions";
    }

    @PostMapping("/{id}/questions/add")
    public String addQuestion(@PathVariable Long id, @ModelAttribute FinalTestQuestion question) {
        question.setFinalTestId(id);
        finalTestQuestionDAO.save(question);
        return "redirect:/admin/final-tests/" + id + "/questions";
    }

    @PostMapping("/questions/update/{questionId}")
    public String updateQuestion(@PathVariable Long questionId, @ModelAttribute FinalTestQuestion updatedQuestion) {
        FinalTestQuestion existingQuestion = finalTestQuestionDAO.findById(questionId);
        updatedQuestion.setId(questionId);
        updatedQuestion.setFinalTestId(existingQuestion.getFinalTestId());
        finalTestQuestionDAO.update(updatedQuestion);
        return "redirect:/admin/final-tests/" + existingQuestion.getFinalTestId() + "/questions";
    }

    @GetMapping("/questions/delete/{questionId}")
    public String deleteQuestion(@PathVariable Long questionId) {
        FinalTestQuestion question = finalTestQuestionDAO.findById(questionId);
        Long finalTestId = question.getFinalTestId();
        finalTestQuestionDAO.deleteById(questionId);
        return "redirect:/admin/final-tests/" + finalTestId + "/questions";
    }

    @GetMapping("/{id}/results")
    public String viewResults(@PathVariable Long id, Model model) {
        FinalTest finalTest = finalTestDAO.findById(id);
        model.addAttribute("finalTest", finalTest);
        model.addAttribute("results", finalTestResultDAO.findByFinalTestId(id));
        model.addAttribute("passedCount", finalTestResultDAO.countPassedResults(id));
        model.addAttribute("failedCount", finalTestResultDAO.countFailedResults(id));
        return "admin/final-test-results";
    }
}
