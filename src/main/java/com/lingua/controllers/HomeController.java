package com.lingua.controllers;


import com.lingua.models.PlacementQuestion;
import com.lingua.services.PlacementService;


import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.ui.Model;
import java.util.List;
import java.util.Map;
@Controller
public class HomeController {
	
	@GetMapping("/")
    public String index() {
        return "index"; // Will load /WEB-INF/views/index.jsp
    }
	
	@GetMapping("/user/")
	 public String user() {
        return "user"; 
    }
	@GetMapping("/flashcard")
    public String flashcard() {
        return "flashcard";
    }
    
    @GetMapping("/stories")
    public String stories() {
        System.out.println("Stories endpoint called"); // Debug log
        return "stories"; // Will load /WEB-INF/views/stories.jsp
    }
    
    	@GetMapping("/story-a-busy-morning")
	public String storyABusyMorning() {
		System.out.println("A Busy Morning story endpoint called"); // Debug log
		return "story-a-busy-morning"; // Will load /WEB-INF/views/story-a-busy-morning.jsp
	}

	@GetMapping("/english-puzzles")
	public String puzzles() {
		System.out.println("Puzzles endpoint called"); // Debug log
		return "puzzles"; // Will load /WEB-INF/views/puzzles.jsp
	}


	@Autowired
	private PlacementService placementService;

	@GetMapping("/placement-test")
	public String showPublicPlacementTest(Model model) {
		List<PlacementQuestion> questions = placementService.getAllQuestions();
		model.addAttribute("questions", questions);
		return "placement-test";
	}

	@PostMapping("/placement-test")
	public String submitPublicPlacementTest(
	        @RequestParam Map<String, String> params,
	        Model model
	) {
	 
	    int total = placementService.getAllQuestions().size();

	    int score = placementService.evaluateScore(params);

	   
	    double pct = (total == 0) ? 0.0 : (score * 100.0) / total;

	   
	    String level;
	    if (pct < 34.0) {
	        level = "Beginner";
	    } else if (pct < 67.0) {
	        level = "Intermediate";
	    } else {
	        level = "Advanced";
	    }

	    System.out.printf("Placement result: score=%d, total=%d, pct=%.2f%%, level=%s%n", score, total, pct, level);

	   
	    model.addAttribute("level", level);
	    model.addAttribute("score", score);
	    model.addAttribute("total", total);
	    return "placement-result";
	}

	
	@GetMapping("/placement/save-intent")
	public String placementSaveIntentGetFallback() {
	   
	    return "redirect:/placement-test";
	}

	@PostMapping("/placement/save-intent")
	public String savePlacementIntent(
	        @RequestParam int score,
	        @RequestParam int total,
	        @RequestParam String level,
	        @RequestParam(required = false) String save,
	        @RequestParam(required = false) String next,   // make next optional
	        HttpSession session
	) {
	    if (save != null) {
	        session.setAttribute("pendingPlacementScore", score);
	        session.setAttribute("pendingPlacementTotal", total);
	        session.setAttribute("pendingPlacementLevel", level);
	    }

	 
	    if (next == null || !(next.endsWith("/login") || next.endsWith("/register"))) {
	        next = "/login";
	    }

	    return "redirect:" + next;
	}


	
}
