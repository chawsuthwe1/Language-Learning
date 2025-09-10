package com.lingua.controllers;

import com.lingua.DAOS.CertificateDAO;
import com.lingua.DAOS.StudentDAO;
import com.lingua.models.Certificate;
import com.lingua.models.Student;
import com.lingua.services.CertificateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@Controller
@RequestMapping("/cert/admin")
public class CertificateAdminController {

    @Autowired private CertificateDAO certificateDAO;
    @Autowired private StudentDAO studentDAO;
    @Autowired private CertificateService certificateService;

    // existing list page
    @GetMapping("/certificates")
    public String list(Model model) {
        model.addAttribute("certificates", certificateDAO.findAll());
        return "certificates"; // your existing JSP
    }

    // APPROVE -> set to AWAITING_PAYMENT (already in your flow)
    @PostMapping("/{id}/approve")
    public String approve(@PathVariable int id, RedirectAttributes ra) {
        certificateDAO.updateStatus(id, "AWAITING_PAYMENT");
        ra.addFlashAttribute("toast", "Approved. Status set to AWAITING_PAYMENT.");
        return "redirect:/cert/admin/certificates";
    }

    // AWAITING_PAYMENT -> PAID (no payment id / txn ref needed)
    @PostMapping("/{id}/mark-paid")
    public String markPaid(@PathVariable int id, RedirectAttributes ra) {
        certificateDAO.updateStatus(id, "PAID");
        ra.addFlashAttribute("toast", "Marked as PAID.");
        return "redirect:/cert/admin/certificates";
    }

    // --- NEW --- preview page (HTML) from PAID row button
    @GetMapping("/{id}/preview")
    public String preview(@PathVariable int id, Model model) {
        Certificate cert = certificateDAO.findById(id);
        Student student  = studentDAO.getStudentById(cert.getStudentId());
        model.addAttribute("cert", cert);
        model.addAttribute("student", student);
        model.addAttribute("orgName", "Lingua Fem");
        return "admin/certificate-preview"; // JSP below
    }

    // --- NEW --- serve the PDF for preview (inline)
    @GetMapping("/{id}/preview.pdf")
    public ResponseEntity<byte[]> previewPdf(@PathVariable int id) throws Exception {
        Certificate cert = certificateDAO.findById(id);
        Student student  = studentDAO.getStudentById(cert.getStudentId());
        byte[] pdf = certificateService.generateCertificatePDF(cert, student);
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_PDF)
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=certificate-" + id + ".pdf")
                .body(pdf);
    }

    @GetMapping("/{id}/download")
    public ResponseEntity<byte[]> downloadPdf(@PathVariable int id) throws Exception {
        Certificate cert = certificateDAO.findById(id);
        Student student  = studentDAO.getStudentById(cert.getStudentId());
        byte[] pdf = certificateService.generateCertificatePDF(cert, student);
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_PDF)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=certificate-" + id + ".pdf")
                .body(pdf);
    }

    // --- NEW --- publish without email: set ISSUED with code+date
    @PostMapping("/{id}/publish")
    public String publish(@PathVariable int id, RedirectAttributes ra) {
        String code = "CER-" + id + "-" + System.currentTimeMillis();
        certificateDAO.issue(id, code, LocalDate.now()); // status -> ISSUED
        ra.addFlashAttribute("toast", "Certificate published as ISSUED.");
        return "redirect:/cert/admin/certificates";
    }

    // optional: reject
    @PostMapping("/{id}/reject")
    public String reject(@PathVariable int id, RedirectAttributes ra) {
        certificateDAO.updateStatus(id, "REJECTED");
        ra.addFlashAttribute("toast", "Request rejected.");
        return "redirect:/cert/admin/certificates";
    }
}
