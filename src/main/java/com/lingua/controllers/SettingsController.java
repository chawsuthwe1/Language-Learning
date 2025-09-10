package com.lingua.controllers;

import com.lingua.models.Activity;
import com.lingua.services.ActivityService;
import com.lingua.services.StudentService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin/settings")
public class SettingsController {

    @Autowired private StudentService  studentService;
    @Autowired private ActivityService activityService;

    @GetMapping("")
    public String page(Model model, HttpSession session) {
        // preload (real values optional)
        model.addAttribute("platformName", "LinguaFem");
        model.addAttribute("supportEmail", "support@linguafem.io");
        model.addAttribute("defaultLang", "en");
        model.addAttribute("timezone", "UTC");
        model.addAttribute("currency", "USD");

        // pass current theme from session so <select> reflects it
        String themePref = (String) session.getAttribute("themePref"); // "light"|"dark"|"system"
        if (themePref == null) themePref = "system";
        model.addAttribute("themePref", themePref);

        return "settings"; // /WEB-INF/views/settings.jsp
    }

    /** Save settings (for now, we only persist theme to the session). */
    @PostMapping("/save")
    public String save(@RequestParam(name = "theme", required = false, defaultValue = "system") String theme,
                       RedirectAttributes ra,
                       HttpSession session) {
        // Persist theme server-side (session). You can replace with DB later.
        session.setAttribute("themePref", theme);
        ra.addFlashAttribute("message", "Settings saved successfully!");
        return "redirect:/admin/settings?saved=1";
    }

    // ------------------ CSV EXPORTS ------------------

 // === Students CSV (matches your schema) ===
    @GetMapping("/export/students")
    public void exportStudentsCsv(HttpServletResponse resp) throws Exception {
        prepareCsv(resp, "students.csv");
        try (java.io.PrintWriter out = resp.getWriter()) {
            out.write('\uFEFF'); // optional BOM for Excel
            out.println("student_id,name,email,image");

            // IMPORTANT: use the method that returns real DB rows
            for (com.lingua.models.Student s : studentService.getAllStudents()) {
                out.printf("%d,%s,%s,%s%n",
                    s.getStudentId(),              // camelCase field in model
                    csv(s.getName()),
                    csv(s.getEmail()),
                    csv(s.getImage())
                );
            }
            out.flush();
        }
    }


 // ---------- Activity CSV ----------
    @GetMapping("/export/activity")
    public void exportActivityCsv(HttpServletResponse resp) throws Exception {
        prepareCsv(resp, "activity.csv");
        java.time.format.DateTimeFormatter fmt = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        try (java.io.PrintWriter out = resp.getWriter()) {
            out.write('\uFEFF');
            out.println("id,type,description,actor,timestamp");
            for (com.lingua.models.Activity a : activityService.getAll()) {
                String ts = a.getTimestamp() != null ? a.getTimestamp().format(fmt) : "";
                out.printf("%d,%s,%s,%s,%s%n",
                        a.getId(),
                        csv(a.getType()),
                        csv(a.getDescription()),
                        csv(a.getActor()),
                        csv(ts));
            }
            out.flush();
        }
    }

 // === CSV helpers ===
    private void prepareCsv(HttpServletResponse resp, String filename) {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/csv; charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
    }
    private String csv(String s) {
        if (s == null) return "";
        String v = s.replace("\"", "\"\"");
        if (v.contains(",") || v.contains("\"") || v.contains("\n") || v.contains("\r")) {
            return "\"" + v + "\"";
        }
        return v;
    }
}