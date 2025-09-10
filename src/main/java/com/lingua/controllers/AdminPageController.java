package com.lingua.controllers;

import com.lingua.DAOS.CertificateDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminPageController {

    @Autowired
    private CertificateDAO certificateDAO;

    @GetMapping("/admin/certificates")
    public String adminCertificatesPage(Model model) {
        model.addAttribute("certificates", certificateDAO.findAll());
        return "certificates"; // -> /WEB-INF/views/admin/certificate.jsp
    }
}