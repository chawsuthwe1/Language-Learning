package com.lingua.controllers;

import com.lingua.models.*;
import com.lingua.services.LessonManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/manage-lessons")
public class AdminLessonController {

    @Autowired
    private LessonManagementService service;

    @GetMapping
    public String page(Model model) {
        model.addAttribute("grammarLessons", service.listGrammarLessons());
        model.addAttribute("readingPassages", service.listReadingPassages());
        model.addAttribute("listeningExercises", service.listListeningExercises());
        model.addAttribute("vocabulary", service.listVocabulary());
        return "admin/manage-lessons";
    }

    // Grammar
    @PostMapping("/grammar/save")
    public String saveGrammar(@ModelAttribute BasicGrammarLesson lesson) {
        service.saveGrammarLesson(lesson);
        return "redirect:/admin/manage-lessons?tab=grammar";
    }

    @PostMapping("/grammar/delete")
    public String deleteGrammar(@RequestParam String slug) {
        service.deleteGrammarLesson(slug);
        return "redirect:/admin/manage-lessons?tab=grammar";
    }

    // Reading
    @PostMapping("/reading/save")
    public String saveReading(@ModelAttribute BasicReadingPassage p) {
        service.saveReadingPassage(p);
        return "redirect:/admin/manage-lessons?tab=reading";
    }

    @PostMapping("/reading/delete")
    public String deleteReading(@RequestParam long id) {
        service.deleteReadingPassage(id);
        return "redirect:/admin/manage-lessons?tab=reading";
    }

    // Listening - Upload Audio File
    @PostMapping("/listening/upload-audio")
    @ResponseBody
    public ResponseEntity<Map<String, String>> uploadListeningAudio(
            @RequestParam("audioFile") MultipartFile audioFile) {
        Map<String, String> response = new HashMap<>();

        if (audioFile.isEmpty()) {
            response.put("error", "No file selected");
            return ResponseEntity.badRequest().body(response);
        }

        if (!audioFile.getContentType().startsWith("audio/")) {
            response.put("error", "Only audio files are allowed");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            String uploadDir = "src/main/webapp/assets/audio/";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String originalName = audioFile.getOriginalFilename();
            String safeName = System.currentTimeMillis() + "_" +
                    originalName.replaceAll("[^a-zA-Z0-9._-]", "_");

            Path filePath = Paths.get(uploadDir + safeName);
            Files.write(filePath, audioFile.getBytes());

            response.put("filename", safeName);
            return ResponseEntity.ok(response);

        } catch (IOException ex) {
            response.put("error", "Upload failed: " + ex.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    // Listening - Save Exercise
    @PostMapping("/listening/save")
    public String saveListening(@ModelAttribute BasicListeningExercise e) {
        service.saveListeningExercise(e);
        return "redirect:/admin/manage-lessons?tab=listening";
    }
    @PostMapping("/listening/delete")
    public String deleteListening(@RequestParam long id) {
        try {
            BasicListeningExercise e = service.findListeningExerciseById(id);
            if (e != null) {
                File file = new File("src/main/webapp/assets/audio/" + e.getAudioFile());
                if (file.exists()) file.delete();
            }
            service.deleteListeningExercise(id);
        } catch (Exception ignore) {}
        return "redirect:/admin/manage-lessons?tab=listening";
    }
    
    // Vocabulary
    
    @PostMapping("/vocabulary/upload-image")
    @ResponseBody
    public ResponseEntity<Map<String, String>> uploadVocabularyImage(
            @RequestParam("imageFile") MultipartFile imageFile,
            @RequestParam(value = "category", required = false) String category) {
        Map<String, String> response = new HashMap<>();

        if (imageFile.isEmpty()) {
            response.put("error", "No image selected");
            return ResponseEntity.badRequest().body(response);
        }

        if (!imageFile.getContentType().startsWith("image/")) {
            response.put("error", "Only image files are allowed");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            // Use category, fallback to 'others'
            String safeCategory = (category != null && !category.trim().isEmpty())
                    ? category.trim().toLowerCase().replaceAll("[^a-zA-Z0-9]", "_")
                    : "others";

            // Create directory: src/main/webapp/assets/imgs/emotions/
            String uploadDir = "src/main/webapp/assets/imgs/" + safeCategory + "/";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            // Secure filename
            String originalName = imageFile.getOriginalFilename();
            String safeName = System.currentTimeMillis() + "_" +
                    originalName.replaceAll("[^a-zA-Z0-9._-]", "_");

            Path filePath = Paths.get(uploadDir + safeName);

            // Save file
            Files.write(filePath, imageFile.getBytes());

            // Return relative path (used in DB and JSP)
            String dbPath = "/assets/imgs/" + safeCategory + "/" + safeName;
            response.put("filename", dbPath);
            return ResponseEntity.ok(response);

        } catch (IOException ex) {
            response.put("error", "Upload failed: " + ex.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
    
    @PostMapping("/vocabulary/save")
    public String saveVocabulary(@ModelAttribute BasicVocabulary v) {
        service.saveVocabulary(v);
        return "redirect:/admin/manage-lessons?tab=vocabulary";
    }

    @PostMapping("/vocabulary/delete")
    public String deleteVocabulary(@RequestParam long id, RedirectAttributes ra) {
        try {
            BasicVocabulary v = service.findVocabularyById(id);
            if (v != null && v.getImage() != null) {
                // Convert DB path to file path
                String imagePath = "src/main/webapp/assets/" + v.getImage();
                File file = new File(imagePath);
                if (file.exists()) file.delete();
            }
            service.deleteVocabulary(id);
            ra.addFlashAttribute("message", "✅ Vocabulary deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "❌ Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/manage-lessons?tab=vocabulary";
    }
}