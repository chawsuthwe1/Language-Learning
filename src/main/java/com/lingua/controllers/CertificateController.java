// src/main/java/com/lingua/controllers/CertificateController.java
package com.lingua.controllers;

import com.lingua.DAOS.CertificateDAO;
import com.lingua.DAOS.StudentDAO;
import com.lingua.models.Certificate;
import com.lingua.models.Student;
import com.lingua.services.CertificateService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.*;

@Controller
@RequestMapping({"/cert","/student"})
public class CertificateController {
	@GetMapping("/certificate/{id}")
    public String showCertificate(@PathVariable int id, Model model) {
        Certificate cert = certificateService.getCertificateById(id);
        if (cert == null) {
            return "error/404"; // or a fallback page
        }

        // put data into request scope so JSP can use it
        model.addAttribute("certificate", cert);

        // this will forward to /WEB-INF/views/cert-download.jsp
        return "cert-download";
    }

  @Autowired private StudentDAO studentDAO;
  @Autowired private CertificateDAO certificateDAO;
  @Autowired private CertificateService certificateService;

  // ---- STUDENT: create request from final test
  @PostMapping("/request/from-final/{finalTestId}")
  @ResponseBody
  public Map<String,Object> requestFromFinalTest(@PathVariable int finalTestId, HttpSession session) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) throw new ResponseStatusException(UNAUTHORIZED, "Not logged in");
    var cert = certificateDAO.createRequestFromFinalTest(s.getStudent_id(), finalTestId);
    return Map.of("certificateId", cert.getId(), "status", cert.getStatus());
  }

  // ---- STUDENT: pay page
  @GetMapping("/pay")
  public String payCertificate(@RequestParam("cid") int certId, HttpSession session, Model model) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) return "redirect:/login";
    Certificate cert = certificateDAO.findById(certId);
    if (cert == null || cert.getStudentId() != s.getStudent_id()) return "redirect:/student-dashboard";
    model.addAttribute("cert", cert);
    return "cert-pay";
  }

  // ---- STUDENT: confirm paid
  @PostMapping("/pay/confirm")
  public String confirmPayment(@RequestParam("cid") int certId, HttpSession session, RedirectAttributes ra) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) return "redirect:/login";
    Certificate cert = certificateDAO.findById(certId);
    if (cert == null || cert.getStudentId() != s.getStudent_id()) {
      ra.addFlashAttribute("error", "Unable to confirm payment.");
      return "redirect:/student-dashboard";
    }
    certificateDAO.updateStatus(certId, "PENDING_VERIFICATION");
    ra.addFlashAttribute("success", "Thanks! Your payment is submitted. An admin will verify it shortly.");
    return "redirect:/student-dashboard";
  }

  // ---- (Admin view page but not under /cert/admin => safe)
  @GetMapping("/payments")
  public String adminPaymentsPage() { return "/payments"; }

  // ---- payments data used by the page above
  @GetMapping("/payments/list")
  @ResponseBody
  public List<Map<String, Object>> listPayments(
      @RequestParam(name="status", defaultValue = "PENDING_VERIFICATION") String status) {
    var list = "ALL".equals(status) ? certificateDAO.findAll() : certificateDAO.listByStatus(status);
    return list.stream().map(c -> {
      Map<String,Object> m = new LinkedHashMap<>();
      m.put("id", c.getId());
      m.put("studentId", c.getStudentId());
      m.put("courseName", c.getCourseName());
      m.put("status", c.getStatus());
      return m;
    }).collect(Collectors.toList());
  }

  // ---- student status & “download” screen
  @GetMapping("/status")
  public String statusPage(@RequestParam(name="cid", required=false) Integer certId,
                           HttpSession session, Model model) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) throw new ResponseStatusException(UNAUTHORIZED, "Not logged in");
    Certificate currentCert = (certId != null) ? certificateDAO.findById(certId) : null;
    model.addAttribute("cert", currentCert);
    model.addAttribute("certificates", certificateDAO.findByStudentId(s.getStudent_id()));
    return "student/cert-status";               // shows list and/or a “Download” button
  }

  // ---- student notification poll
  @GetMapping("/check-notifications")
  @ResponseBody
  public List<Map<String,String>> checkCertificateNotifications(HttpSession session) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) return List.of();
    return certificateDAO.listByStatusForStudent("AWAITING_PAYMENT", s.getStudent_id())
        .stream()
        .map(c -> Map.of("id", String.valueOf(c.getId()), "courseName", c.getCourseName()))
        .collect(Collectors.toList());
  }

  // ---- student guard page (optional)
  @GetMapping("/download/{certId}")
  public String downloadCertificate(@PathVariable int certId, HttpSession session, Model model) {
    Student s = (Student) session.getAttribute("student");
    if (s == null) return "redirect:/login";
    Certificate cert = certificateDAO.findById(certId);
    if (cert == null || cert.getStudentId() != s.getStudent_id()) return "redirect:/student-dashboard";
    if (!"PAID".equals(cert.getStatus()) && !"ISSUED".equals(cert.getStatus()))
      return "redirect:/cert/status?cid=" + certId;
    model.addAttribute("cert", cert);
    return "cert-download";                     // simple page with “Preview” & “Save PDF” links
  }

  // =========================
  // STUDENT-ONLY PDF ENDPOINTS
  // =========================

  // Inline preview in browser
  @GetMapping("/file/{id}.pdf")
  public ResponseEntity<byte[]> viewPdf(@PathVariable int id, HttpSession session) throws Exception {
    Student s = (Student) session.getAttribute("student");
    if (s == null) throw new ResponseStatusException(UNAUTHORIZED, "Not logged in");

    Certificate cert = certificateDAO.findById(id);
    if (cert == null || cert.getStudentId() != s.getStudent_id())
      throw new ResponseStatusException(NOT_FOUND, "Certificate not found");

    // Only allow after payment verified / issued
    if (!"PAID".equals(cert.getStatus()) && !"ISSUED".equals(cert.getStatus()))
      throw new ResponseStatusException(FORBIDDEN, "Certificate not available yet");

    byte[] pdf = certificateService.generateCertificatePDF(cert, s); // may throw checked Exception

    return ResponseEntity.ok()
        .contentType(MediaType.APPLICATION_PDF)
        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=certificate-" + id + ".pdf")
        .body(pdf);
  }

  // Force download
  @GetMapping("/file/{id}/download")
  public ResponseEntity<byte[]> downloadPdf(@PathVariable int id, HttpSession session) throws Exception {
    Student s = (Student) session.getAttribute("student");
    if (s == null) throw new ResponseStatusException(UNAUTHORIZED, "Not logged in");

    Certificate cert = certificateDAO.findById(id);
    if (cert == null || cert.getStudentId() != s.getStudent_id())
      throw new ResponseStatusException(NOT_FOUND, "Certificate not found");

    if (!"PAID".equals(cert.getStatus()) && !"ISSUED".equals(cert.getStatus()))
      throw new ResponseStatusException(FORBIDDEN, "Certificate not available yet");

    byte[] pdf = certificateService.generateCertificatePDF(cert, s);

    return ResponseEntity.ok()
        .contentType(MediaType.APPLICATION_PDF)
        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=certificate-" + id + ".pdf")
        .body(pdf);
  }
  
}
