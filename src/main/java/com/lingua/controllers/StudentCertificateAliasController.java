// src/main/java/com/lingua/controllers/StudentCertificateAliasController.java
package com.lingua.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class StudentCertificateAliasController {

  // Old path with ID -> forward to your existing handler
  @GetMapping("/student/certificate/{id}")
  public String aliasWithId(@PathVariable int id) {
    return "forward:/cert/certificate/" + id;
  }

  // Old path without ID -> redirect to status page (no 404)
  @GetMapping("/student/certificate")
  public String aliasNoId() {
    return "redirect:/cert/status";
  }
}
