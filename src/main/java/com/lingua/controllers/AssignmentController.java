package com.lingua.controllers;

import com.lingua.DAOS.AssignmentDAO;
import com.lingua.models.Assignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/assignments")
public class AssignmentController {

    @Autowired
    private AssignmentDAO assignmentDAO;

    @GetMapping
    public String viewAssignments(Model model) {
        model.addAttribute("assignments", assignmentDAO.findAll());
        return "assignments";
    }

    @GetMapping("/review/{id}")
    public String markReviewed(@PathVariable int id) {
        Assignment assignment = assignmentDAO.findById(id).orElse(null);
        if (assignment != null) {
            assignment.setReviewed(true);
            assignmentDAO.save(assignment);
        }
        return "redirect:/admin/assignments";
    }
}

