package com.lingua.controllers;

import com.lingua.DAOS.QuizDAO;
import com.lingua.models.Quiz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/quizzes")
public class QuizController {

    @Autowired
    private QuizDAO quizDAO;

    @GetMapping
    public String viewQuizzes(Model model) {
        model.addAttribute("quizzes", quizDAO.findAll());
        return "quizzes";
    }

    @PostMapping("/add")
    public String addQuiz(@ModelAttribute Quiz quiz) {
        quizDAO.save(quiz);
        return "redirect:/admin/quizzes";
    }

    @PostMapping("/update/{id}")
    public String updateQuiz(@PathVariable int id, @ModelAttribute Quiz updatedQuiz) {
        updatedQuiz.setId((long) id); // Ensure the ID is set
        quizDAO.updateQuiz(updatedQuiz);
        return "redirect:/admin/quizzes";
    }

    @GetMapping("/delete/{id}")
    public String deleteQuiz(@PathVariable int id) {
        quizDAO.deleteById(id);
        return "redirect:/admin/quizzes";
    }
}
