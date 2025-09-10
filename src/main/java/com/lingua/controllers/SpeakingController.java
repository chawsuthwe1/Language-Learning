package com.lingua.controllers;

import com.lingua.DAOS.SpeakingExerciseDAO;
import com.lingua.DAOS.StudentSpeakingResultDAO;
import com.lingua.models.SpeakingExercise;
import com.lingua.models.Student;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/student/speaking")
public class SpeakingController {

    private static final int PASS_THRESHOLD = 80; // change if you want 70/75/etc.

    @Autowired private SpeakingExerciseDAO speakingDAO;
    @Autowired private StudentSpeakingResultDAO resultDAO;

    // LIST (students land here first)
    @GetMapping
    public String list(HttpSession session, Model model) {
        if (session.getAttribute("student") == null) return "redirect:/login";
        model.addAttribute("exercises", speakingDAO.findAll()); // List<SpeakingExercise>
        return "student-speaking"; // JSP list page
    }

    // DETAIL (one exercise)
    @GetMapping("/{id}")
    public String detail(@PathVariable int id, HttpSession session, Model model) {
        if (session.getAttribute("student") == null) return "redirect:/login";
        SpeakingExercise ex = speakingDAO.findById(id);
        if (ex == null) return "redirect:/student/speaking";
        model.addAttribute("exercise", ex);

        // optional: for prev/next dots
        model.addAttribute("exercises", speakingDAO.findAll());
        model.addAttribute("currentId", id);

        return "student-speaking-exercise"; // JSP attempt page
    }

    /**
     * Save an attempt accuracy. If "complete"=true OR accuracy >= PASS_THRESHOLD,
     * mark this exercise as completed for the student.
     *
     * Body: accuracy=NN[&complete=1]
     */
    @PostMapping("/{id}/submit")
    @ResponseBody
    public ResponseEntity<Void> submit(
            @PathVariable int id,
            @RequestParam("accuracy") int accuracy,
            @RequestParam(value = "complete", required = false, defaultValue = "false") boolean complete,
            HttpSession session) {

        Student student = (Student) session.getAttribute("student");
        if (student == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        // Persist the attempt (keep every try)
        resultDAO.save(student.getStudent_id(), id, accuracy);
        if (complete || accuracy >= PASS_THRESHOLD) {
            resultDAO.markComplete(student.getStudent_id(), id);
        }


        // Server-side pass check (defensive, even if client already did it)
        if (complete || accuracy >= PASS_THRESHOLD) {
            resultDAO.markComplete(student.getStudent_id(), id);
        }

        return ResponseEntity.ok().build();
    }
}
