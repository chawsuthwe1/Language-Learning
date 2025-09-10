package com.lingua.controllers;

import com.lingua.DAOS.PaymentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/payments")
public class PaymentController {

    @Autowired private PaymentDAO paymentDAO;

    // PAGE: fixes the 404 at /admin/payments
    @GetMapping
    public String paymentsPage(Model model) {
        model.addAttribute("payments", paymentDAO.listAll());
        return "admin/payments"; // -> /WEB-INF/views/admin/payments.jsp
    }

    // JSON for AJAX tables: /admin/payments/list
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<?> listAll() {
        return ResponseEntity.ok(paymentDAO.listAll());
    }
}
