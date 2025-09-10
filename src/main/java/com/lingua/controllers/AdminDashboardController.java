package com.lingua.controllers;

import com.lingua.services.ActivityService;
import com.lingua.services.AdminService;
import com.lingua.services.LessonService;
import com.lingua.services.QuizService;
import com.lingua.services.StudentService;
import com.lingua.DAOS.FinalTestDAO;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminDashboardController {

    @Autowired
    private LessonService lessonService;

    @Autowired
    private QuizService quizService;

    @Autowired
    private StudentService studentService;
    
    @Autowired
    private AdminService adminService;
    @Autowired private ActivityService activityService;
    @Autowired
    private FinalTestDAO finalTestDAO;
    
    @GetMapping({"", "/"})
    public String rootRedirect() {
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model, HttpSession session) {
        model.addAttribute("lessonCount", lessonService.countAll());
        model.addAttribute("quizCount", quizService.countAll());
        model.addAttribute("studentCount", studentService.countAll());
        model.addAttribute("adminCount", adminService.countAll());
        model.addAttribute("finalTestCount", finalTestDAO.countAll());
        model.addAttribute("theme", "dark");
        model.addAttribute("layout", "grid");
        // recent 5 activities
        model.addAttribute("recentActivities", activityService.getRecent(5));

        // ✅ Add theme preference from session
        Object themePref = session.getAttribute("themePref");
        model.addAttribute("themePref", themePref != null ? themePref.toString() : "system");
        return "admin-dashboard";
    }

   
}
