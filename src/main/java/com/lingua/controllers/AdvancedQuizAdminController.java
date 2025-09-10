package com.lingua.controllers;

import com.lingua.DAOS.AdvancedQuizDAO;
import com.lingua.models.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/advanced-quizzes")
public class AdvancedQuizAdminController {

    @Autowired
    private AdvancedQuizDAO dao;

    @GetMapping
    public String index(Model model) {
        model.addAttribute("grammar", dao.findAllGrammar());
        model.addAttribute("listeningMCQ", dao.findAllListeningMCQ());
        model.addAttribute("listeningTF", dao.findAllListeningTF());
        model.addAttribute("reading", dao.findAllReading());
        model.addAttribute("vocab", dao.findAllVocabulary());
        return "admin/advanced-quizzes";
    }

    // Grammar
    @PostMapping("/grammar/save")
    public String saveGrammar(@ModelAttribute AdvancedGrammarQuiz q) { dao.saveGrammar(q); return "redirect:/admin/advanced-quizzes"; }
    @PostMapping("/grammar/delete")
    public String deleteGrammar(@RequestParam long id) { dao.deleteGrammar(id); return "redirect:/admin/advanced-quizzes"; }

    // Listening MCQ
    @PostMapping("/listening/mcq/save")
    public String saveListeningMCQ(@ModelAttribute AdvancedListeningMCQ q) { dao.saveListeningMCQ(q); return "redirect:/admin/advanced-quizzes"; }
    @PostMapping("/listening/mcq/delete")
    public String deleteListeningMCQ(@RequestParam long id) { dao.deleteListeningMCQ(id); return "redirect:/admin/advanced-quizzes"; }

    // Listening TF
    @PostMapping("/listening/tf/save")
    public String saveListeningTF(@ModelAttribute AdvancedListeningTF q) { dao.saveListeningTF(q); return "redirect:/admin/advanced-quizzes"; }
    @PostMapping("/listening/tf/delete")
    public String deleteListeningTF(@RequestParam long id) { dao.deleteListeningTF(id); return "redirect:/admin/advanced-quizzes"; }

    // Reading
    @PostMapping("/reading/save")
    public String saveReading(@ModelAttribute AdvancedReadingQuestion q) { dao.saveReading(q); return "redirect:/admin/advanced-quizzes"; }
    @PostMapping("/reading/delete")
    public String deleteReading(@RequestParam long id) { dao.deleteReading(id); return "redirect:/admin/advanced-quizzes"; }

    // Vocabulary
    @PostMapping("/vocab/save")
    public String saveVocab(@ModelAttribute AdvancedVocabularyQuiz q) { dao.saveVocabulary(q); return "redirect:/admin/advanced-quizzes"; }
    @PostMapping("/vocab/delete")
    public String deleteVocab(@RequestParam long id) { dao.deleteVocabulary(id); return "redirect:/admin/advanced-quizzes"; }
}


