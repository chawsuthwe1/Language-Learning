package com.lingua.controllers;

import com.lingua.DAOS.SpeakingExerciseDAO;
import com.lingua.models.SpeakingExercise;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/speaking")
public class SpeakingAdminController {

    @Autowired private SpeakingExerciseDAO dao;

    @GetMapping
    public String list(Model model) {
        model.addAttribute("exercises", dao.findAll());
        return "admin-speaking"; // JSP below
    }

    @PostMapping("/add")
    public String add(@RequestParam String title, @RequestParam String content) {
        SpeakingExercise e = new SpeakingExercise();
        e.setTitle(title);
        e.setContent(content);
        dao.save(e);
        return "redirect:/admin/speaking";
    }

    @PostMapping("/update/{id}")
    public String update(@PathVariable int id, @RequestParam String title, @RequestParam String content) {
        SpeakingExercise e = new SpeakingExercise();
        e.setId(id);
        e.setTitle(title);
        e.setContent(content);
        dao.update(e);
        return "redirect:/admin/speaking";
    }

    @PostMapping("/delete/{id}")
    public String delete(@PathVariable int id) {
        dao.delete(id);
        return "redirect:/admin/speaking";
    }
}
