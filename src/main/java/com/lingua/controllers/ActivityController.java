package com.lingua.controllers;

import com.lingua.DAOS.ActivityDAO;
import com.lingua.models.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin/activity")
public class ActivityController {

    @Autowired
    private ActivityDAO activityDAO;

    @GetMapping
  
       
    public String showActivityPage(
            @RequestParam(value = "type", required = false, defaultValue = "All") String type,
            @RequestParam(value = "q", required = false, defaultValue = "") String q,
            @RequestParam(value = "from", required = false, defaultValue = "") String from,
            @RequestParam(value = "to", required = false, defaultValue = "") String to,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            Model model
    ) {
        int pageSize = 20;

        List<Activity> activities = activityDAO.getRecentActivities(type, q, from, to, page, pageSize);
        int totalRows  = activityDAO.countActivities(type, q, from, to);
        int totalPages = (int) Math.ceil(totalRows / (double) pageSize);

        model.addAttribute("activities", activities);
        return "admin/activity"; // JSP file
    
    
     

       
    }
}