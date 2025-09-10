package com.lingua.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FlashcardController {

    @GetMapping("/flashboard")
    public String showFlashcardPage() {
        return "flashboard"; 
    }
}