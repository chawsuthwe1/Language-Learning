package com.lingua.controllers;

import com.lingua.DAOS.LessonDAO;
import com.lingua.models.Lesson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

@Controller
@RequestMapping("/admin/lessons")
public class LessonController {

    @Autowired
    private LessonDAO lessonDAO;

    // View all lessons
    @GetMapping
    public String viewLessons(Model model) {
        model.addAttribute("lessons", lessonDAO.findAll());
        return "lessons"; // matches lessons.jsp
    }

    // Add new lesson
    @PostMapping("/add")
    public String addLesson(@ModelAttribute Lesson lesson) {
        lessonDAO.save(lesson);
        return "redirect:/admin/lessons";
    }

    // Delete lesson by ID
    @GetMapping("/delete/{id}")
    public String deleteLesson(@PathVariable int id) {
        lessonDAO.deleteById(id);
        return "redirect:/admin/lessons";
    }

    // Update lesson by ID
    @PostMapping("/update/{id}")
    public String updateLesson(@PathVariable int id, @ModelAttribute Lesson updatedLesson) {
        Lesson existingLesson = lessonDAO.findById(id);
        if (existingLesson != null) {
            existingLesson.setTitle(updatedLesson.getTitle());
            existingLesson.setDescription(updatedLesson.getDescription());
            existingLesson.setVideoUrl(updatedLesson.getVideoUrl());
            existingLesson.setMaterialPath(updatedLesson.getMaterialPath());
            lessonDAO.save(existingLesson);
        }
        return "redirect:/admin/lessons";
    }
}
