package com.lingua.controllers;

import com.lingua.models.PlacementQuestion;
import com.lingua.services.PlacementService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/placement-questions")
public class PlacementAdminController {

    @Autowired
    private PlacementService placementService;

    @GetMapping
    public String list(
            @RequestParam(value = "section", required = false) String section,
            @RequestParam(value = "q", required = false) String query,
            Model model
    ) {
        List<PlacementQuestion> questions = (section != null && !section.isEmpty())
                ? placementService.getQuestionsBySection(section)
                : placementService.getAllQuestions();
        if (query != null && !query.trim().isEmpty()) {
            String q = query.toLowerCase();
            java.util.ArrayList<PlacementQuestion> filtered = new java.util.ArrayList<>();
            for (PlacementQuestion item : questions) {
                String text = item.getQuestionText() != null ? item.getQuestionText().toLowerCase() : "";
                if (text.contains(q)) filtered.add(item);
            }
            questions = filtered;
        }
        model.addAttribute("questions", questions);
        model.addAttribute("currentSection", section);
        model.addAttribute("q", query);
        model.addAttribute("sections", new String[]{"Vocabulary","Grammar"});
        return "admin/placement-questions";
    }

    @GetMapping("/new")
    public String createForm(Model model) {
        model.addAttribute("question", new PlacementQuestion());
        return "admin/placement-question-form";
    }

    @GetMapping("/{id}")
    public String editForm(@PathVariable int id, Model model) {
        PlacementQuestion q = placementService.getById(id);
        model.addAttribute("question", q);
        return "admin/placement-question-form";
    }

    @PostMapping
    public String save(@ModelAttribute PlacementQuestion q) {
        placementService.save(q);
        return "redirect:/admin/placement-questions";
    }


    @PostMapping("/{id}/delete")
    public String delete(@PathVariable int id) {
        placementService.delete(id);
        return "redirect:/admin/placement-questions";
    }
}


