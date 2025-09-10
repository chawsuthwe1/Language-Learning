package com.lingua.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lingua.DAOS.AdminDAO;
import com.lingua.DAOS.StudentDAO;
import com.lingua.models.Admin;
import com.lingua.models.Certificate;
import com.lingua.models.Student;
import com.lingua.services.CertificateService;
import com.lingua.services.StudentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class StudentController {

    @Autowired
    private StudentDAO studentDAO;
    
    @Autowired
    private CertificateService certificateService;

    @Autowired
    private StudentService studentService; // <-- you must have this

    @GetMapping("/certificate/{id}")
    public String viewCertificate(@PathVariable int id, Model model) {
        Certificate cert = certificateService.getCertificateById(id);

    
        Student student = studentService.getStudentById(cert.getStudentId());

        model.addAttribute("certificate", cert);
        model.addAttribute("student", student);

        return "studentCertificate"; // resolves to /WEB-INF/views/studentCertificate.jsp
    }
    @Autowired
    private AdminDAO adminDAO;
    @GetMapping("/register")
    public String showRegisterPage() {
        return "user"; // make sure /WEB-INF/views/register.jsp exists
    }

    @PostMapping("/register")
    public String register(
        @RequestParam("name") String name,
        @RequestParam("email") String email,
        @RequestParam("password") String password) {

        Student student = new Student();
        student.setEmail(email);
        student.setName(name);
        student.setPassword(password);

        studentDAO.saveStudent(student);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }
 // If someone GETs /check, send them to the login form
    @GetMapping("/check")
    public String checkGetFallback() {
        return "redirect:/login";
    }

    @PostMapping("/check")
    public String login(@RequestParam("email") String email,
                        @RequestParam("password") String password,
                        @RequestParam("userType") String role,
                        HttpServletRequest request) {

        HttpSession session = request.getSession();

        switch (role) {
            case "student":
                Student student = studentDAO.findbyEmailandPassword(email, password);
                if (student != null) {
                    session.setAttribute("student", student);

                    // ⬅️ ADDED: apply placement result to the account if present
                    Integer pendingScore = (Integer) session.getAttribute("pendingPlacementScore");
                    Integer pendingTotal = (Integer) session.getAttribute("pendingPlacementTotal");
                    String pendingLevel = (String) session.getAttribute("pendingPlacementLevel");

                    if (pendingLevel != null) {
                        student.setLevel(pendingLevel);
                        // If you added a column/field in Student + DB:
                        // student.setLastPlacementScore(pendingScore);

                        // Persist the updated level (and optional score)
                        studentDAO.updateStudent(student);
                        Student refreshed = studentDAO.getStudentById(student.getStudent_id());
                        session.setAttribute("student", refreshed);
                        // Clear temp session flags
                        session.removeAttribute("pendingPlacementScore");
                        session.removeAttribute("pendingPlacementTotal");
                        session.removeAttribute("pendingPlacementLevel");
                    }
                    // ⬅️ END ADDED

                    return "redirect:/student-dashboard";
                }
                break;

            case "admin":
                Admin admin = adminDAO.findbyEmailandPassword(email, password);
                if (admin != null) {
                    session.setAttribute("admin", admin);
                    return "redirect:/admin-dashboard";
                }
                break;
        }

        // If login fails
        return "redirect:/login?error=invalid";
    }

    @GetMapping("/student-dashboard")
    public String showStudentDashboard(HttpSession session) {
        Student student = (Student) session.getAttribute("student");
        System.out.println("DEBUG: Student dashboard session: " + (student != null ? student.getName() : "null"));
        if (student == null) return "redirect:/login";
        return "student-dashboard";
    }

    @GetMapping("/student-dashboard/edit-profile")
    public String editProfile(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";
        model.addAttribute("student", student);
        return "edit-profile";
    }

    @PostMapping("/student-dashboard/update-profile")
    public String updateProfile(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam(value = "profileImage", required = false) MultipartFile profileImage,
            HttpSession session,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes
    ) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        student.setName(name);
        student.setEmail(email);
        student.setPassword(password);

        try {
            if (profileImage != null && !profileImage.isEmpty()) {
                String uploadsDir = request.getServletContext().getRealPath("/assets/imgs");
                java.io.File dir = new java.io.File(uploadsDir);
                if (!dir.exists()) dir.mkdirs();
                String ext = org.springframework.util.StringUtils.getFilenameExtension(profileImage.getOriginalFilename());
                String filename = "student-" + student.getStudent_id() + "-" + System.currentTimeMillis() + (ext != null ? ("." + ext) : "");
                java.io.File dest = new java.io.File(dir, filename);
                profileImage.transferTo(dest);
                student.setImage(filename);
            }
            studentDAO.updateStudent(student);
            session.setAttribute("student", student);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully.");
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile.");
        }
        return "redirect:/student-dashboard/edit-profile";
    }

    @PostMapping("/student-dashboard/remove-profile-picture")
    public String removeProfilePicture(HttpSession session, RedirectAttributes redirectAttributes) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";
        student.setImage(null);
        studentDAO.updateStudent(student);
        session.setAttribute("student", student);
        redirectAttributes.addFlashAttribute("success", "Profile picture removed.");
        return "redirect:/student-dashboard/edit-profile";
    }

    @GetMapping("/student-dashboard/submitIssues")
    public String showSubmitIssues(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) {
            return "redirect:/login";
        }
        model.addAttribute("student", student);
        return "submit-issues";
    }

    @GetMapping("student-dashboard/logout")
    public String doLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/admin-dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        if (session.getAttribute("admin") == null) return "redirect:/login";
        return "admin-dashboard";
    }
    
}
