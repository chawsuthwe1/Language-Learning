package com.lingua.controllers;

import com.lingua.models.ReadingPassage;
import com.lingua.services.ReadingPassageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/reading-passages")
public class ReadingPassageAdminController {

    @Autowired
    private ReadingPassageService service;

    @GetMapping
    public String list(Model model) {
        List<ReadingPassage> passages = service.findAll();
        model.addAttribute("passages", passages);
        return "admin/reading-passages";
    }

    @GetMapping("/new")
    public String formNew(Model model) {
        model.addAttribute("passage", new ReadingPassage());
        return "admin/reading-passage-form";
    }

    @GetMapping("/{id}")
    public String formEdit(@PathVariable int id, Model model) {
        model.addAttribute("passage", service.findById(id));
        return "admin/reading-passage-form";
    }

    @PostMapping
    public String save(@ModelAttribute ReadingPassage passage) {
        service.save(passage);
        return "redirect:/admin/reading-passages";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable int id) {
        service.delete(id);
        return "redirect:/admin/reading-passages";
    }
}


