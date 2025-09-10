package com.lingua.controllers;

import com.lingua.models.Admin;
import com.lingua.services.AdminService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/admins")
public class ManageAdminController {

	@Autowired
	private AdminService adminService;

	@GetMapping
	public String showManageAdmins(Model model) {
	    List<Admin> admins = adminService.getAllAdmins();
	    int adminCount = adminService.countAll();

	    model.addAttribute("admins", admins);
	    model.addAttribute("adminCount", adminCount);

	    return "manage-admins"; // or your actual JSP name
	}


    @PostMapping("/add")
    public String addAdmin(@RequestParam("name") String name,
                           @RequestParam("email") String email,
                           @RequestParam("password") String password) {

        Admin admin = new Admin();
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(password);
        adminService.saveAdmin(admin);
        return "redirect:/admin/admins";
    }

    @GetMapping("/edit/{id}")
    public String editAdmin(@PathVariable("id") int id, Model model) {
        Admin admin = adminService.getAdminById(id);
        model.addAttribute("admin", admin);
        return "edit-admin"; // Make sure this JSP file exists
    }

    @PostMapping("/edit/{id}")
    public String updateAdmin(@PathVariable("id") int id,
                              @RequestParam("name") String name,
                              @RequestParam("email") String email,
                              @RequestParam("password") String password) {

        Admin admin = new Admin();
        admin.setId(id);
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(password);
        adminService.updateAdmin(admin);
        return "redirect:/admin/admins";
    }

    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable("id") int id) {
        adminService.deleteAdmin(id);
        return "redirect:/admin/admins";
    }
}
