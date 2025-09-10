package com.lingua.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Ends the session
        return "redirect:/login?logout=true";
 // Redirects to login.jsp
    }
}
