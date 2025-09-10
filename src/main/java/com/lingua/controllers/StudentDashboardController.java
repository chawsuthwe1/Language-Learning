// src/main/java/com/lingua/controllers/StudentDashboardController.java
package com.lingua.controllers;

import com.lingua.DAOS.*;
import com.lingua.models.*;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;

@Controller
@RequestMapping("/student")
public class StudentDashboardController {

    @Autowired private GrammarLevelJdbcDAO grammarLevelDao;
    @Autowired private ReadingLevelJdbcDAO readingLevelDao;
    @Autowired private ListeningLevelJdbcDAO listeningLevelDao;
    @Autowired private VocabularyLevelJdbcDAO vocabularyLevelDao;
    @Autowired private LessonLevelQuizDAO grammarQuizDao;
    @Autowired private LevelExtraQuizDAO extraQuizDao;

    private static final List<String> LEVEL_ORDER = Arrays.asList(
        "Beginner", "Pre-Intermediate", "Intermediate", "Advanced"
    );

    // =============== MISC / ENTRY ===============

    @GetMapping("/level-error")
    public String showLevelError() {
        // IMPORTANT: return without a leading slash and include the folder
        return "student/level-error";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "student/dashboard";
    }

    // =============== LEVEL SELECTION ===============

    @GetMapping("/levels")
    public String showLevels() {
        return "student/levels";
    }

    // =============== CATEGORY SELECTION ===============

    @GetMapping("/{level}/categories")
    public String showCategories(@PathVariable String level, Model model, HttpSession session, RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        model.addAttribute("level", level);
        return "student/categories";
    }

    // =============== GRAMMAR ===============

    @GetMapping("/{level}/grammar")
    public String showGrammarList(@PathVariable String level, Model model, HttpSession session, RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicGrammarLesson> lessons = grammarLevelDao.findByLevel(dbLevel);
        model.addAttribute("lessons", lessons);
        model.addAttribute("level", level);
        return "student/grammar-list";
    }

    @GetMapping("/{level}/grammar/{slug}")
    public String showGrammarLesson(@PathVariable String level,
                                    @PathVariable String slug,
                                    Model model,
                                    HttpSession session,
                                    RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        BasicGrammarLesson lesson = grammarLevelDao.findBySlug(slug);

        List<LevelGrammarQuiz> quizzes = grammarQuizDao.findAll(level).stream()
            .filter(q -> q.getLessonSlug().equals(slug))
            .collect(Collectors.toList());

        Map<String, List<String>> processedOptions = new HashMap<>();
        for (LevelGrammarQuiz quiz : quizzes) {
            List<String> opts = Arrays.stream(quiz.getOptions().split(","))
                .map(String::trim).toList();
            processedOptions.put(quiz.getQuestion(), opts);
        }

        model.addAttribute("lesson", lesson);
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("processedOptions", processedOptions);
        model.addAttribute("level", level);
        return "student/grammar";
    }

    // =============== READING ===============

    @GetMapping("/{level}/reading")
    public String showReading(@PathVariable String level,
                              @RequestParam(defaultValue = "0") int page,
                              Model model,
                              HttpSession session,
                              RedirectAttributes ra) {

        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicReadingPassage> passages = readingLevelDao.findByLevel(dbLevel);
        List<BasicReadingQuestion> allQuestions = extraQuizDao.findReadingByLevel(dbLevel);

        int pageSize = 1;
        int totalPages = (int) Math.ceil((double) passages.size() / pageSize);
        int currentPage = Math.min(page, totalPages > 0 ? totalPages - 1 : 0);

        BasicReadingPassage reading = passages.isEmpty() ? null : passages.get(currentPage);
        List<BasicReadingQuestion> questions = allQuestions.stream()
            .filter(q -> reading != null && q.getReadingId() == reading.getId())
            .collect(Collectors.toList());

        model.addAttribute("reading", reading);
        model.addAttribute("questions", questions);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("level", level);
        return "student/reading";
    }

    @PostMapping("/{level}/reading/submit")
    public String submitReadingQuiz(@PathVariable String level,
                                    @RequestParam Map<String, String> form,
                                    @RequestParam(defaultValue = "0") int page,
                                    Model model,
                                    HttpSession session,
                                    RedirectAttributes ra) {

        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicReadingPassage> passages = readingLevelDao.findByLevel(dbLevel);
        List<BasicReadingQuestion> allQuestions = extraQuizDao.findReadingByLevel(dbLevel);

        if (passages.isEmpty()) {
            model.addAttribute("error", "No reading passages available.");
            return "student/reading";
        }

        int pageSize = 1;
        int totalPages = (int) Math.ceil((double) passages.size() / pageSize);
        int currentPage = Math.min(page, totalPages > 0 ? totalPages - 1 : 0);
        BasicReadingPassage reading = passages.get(currentPage);

        List<BasicReadingQuestion> questions = allQuestions.stream()
            .filter(q -> q.getReadingId() == reading.getId())
            .collect(Collectors.toList());

        Map<Long, String> submissionResults = new HashMap<>();
        int score = 0;

        for (BasicReadingQuestion q : questions) {
            String submitted = form.get("question_" + q.getId());
            if (submitted != null && submitted.equals(q.getCorrectAnswer())) {
                submissionResults.put(q.getId(), "✅ Correct!");
                score++;
            } else {
                submissionResults.put(q.getId(), "❌ Incorrect. Correct answer: " + q.getCorrectAnswer());
            }
        }

        model.addAttribute("reading", reading);
        model.addAttribute("questions", questions);
        model.addAttribute("submissionResults", submissionResults);
        model.addAttribute("score", score);
        model.addAttribute("total", questions.size());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("level", level);
        return "student/reading";
    }

    // =============== LISTENING ===============

    @GetMapping("/{level}/listening")
    public String showListening(@PathVariable String level,
                                @RequestParam(defaultValue = "0") int page,
                                Model model,
                                HttpSession session,
                                RedirectAttributes ra) {

        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicListeningExercise> exercises = listeningLevelDao.findByLevel(dbLevel);
        List<BasicListeningMCQ> mcq = extraQuizDao.findListeningMCQByLevel(dbLevel);
        List<BasicListeningTrueFalse> tf = extraQuizDao.findListeningTFByLevel(dbLevel);

        int pageSize = 1;
        int totalPages = (int) Math.ceil((double) exercises.size() / pageSize);
        int currentPage = Math.min(page, totalPages > 0 ? totalPages - 1 : 0);

        BasicListeningExercise listening = exercises.isEmpty() ? null : exercises.get(currentPage);

        List<BasicListeningMCQ> mcqForExercise = mcq.stream()
            .filter(q -> listening != null && q.getExerciseId() == listening.getId())
            .collect(Collectors.toList());

        List<BasicListeningTrueFalse> tfForExercise = tf.stream()
            .filter(q -> listening != null && q.getExerciseId() == listening.getId())
            .collect(Collectors.toList());

        model.addAttribute("listening", listening);
        model.addAttribute("mcq", mcqForExercise);
        model.addAttribute("tf", tfForExercise);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("level", level);
        return "student/listening";
    }

    @PostMapping("/{level}/listening/submit")
    public String submitListeningQuiz(@PathVariable String level,
                                      @RequestParam Map<String, String> form,
                                      @RequestParam(defaultValue = "0") int page,
                                      Model model,
                                      HttpSession session,
                                      RedirectAttributes ra) {

        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicListeningExercise> exercises = listeningLevelDao.findByLevel(dbLevel);
        List<BasicListeningMCQ> mcq = extraQuizDao.findListeningMCQByLevel(dbLevel);
        List<BasicListeningTrueFalse> tf = extraQuizDao.findListeningTFByLevel(dbLevel);

        if (exercises.isEmpty()) {
            model.addAttribute("error", "No listening exercises available.");
            return "student/listening";
        }

        int pageSize = 1;
        int totalPages = (int) Math.ceil((double) exercises.size() / pageSize);
        int currentPage = Math.min(page, totalPages > 0 ? totalPages - 1 : 0);
        BasicListeningExercise listening = exercises.get(currentPage);

        List<BasicListeningTrueFalse> tfQuestions = tf.stream()
            .filter(q -> q.getExerciseId() == listening.getId())
            .collect(Collectors.toList());

        List<BasicListeningMCQ> mcqQuestions = mcq.stream()
            .filter(q -> q.getExerciseId() == listening.getId())
            .collect(Collectors.toList());

        Map<String, String> submissionResults = new HashMap<>();
        String task = form.get("task");

        if ("tf".equals(task)) {
            for (BasicListeningTrueFalse q : tfQuestions) {
                String submitted = form.get("tf_" + q.getId());
                if (submitted != null && submitted.equalsIgnoreCase(q.getAnswer())) {
                    submissionResults.put("tf_" + q.getId(), "✅ Correct!");
                } else if (submitted != null) {
                    submissionResults.put("tf_" + q.getId(), "❌ Incorrect. Correct answer: " + q.getAnswer());
                }
            }
        } else if ("mcq".equals(task)) {
            for (BasicListeningMCQ q : mcqQuestions) {
                String submitted = form.get("mc_" + q.getId());
                if (submitted != null && submitted.equals(q.getCorrectAnswer())) {
                    submissionResults.put("mc_" + q.getId(), "✅ Correct!");
                } else if (submitted != null) {
                    submissionResults.put("mc_" + q.getId(), "❌ Incorrect. Correct answer: " + q.getCorrectAnswer());
                }
            }
        }

        model.addAttribute("listening", listening);
        model.addAttribute("mcq", mcqQuestions);
        model.addAttribute("tf", tfQuestions);
        model.addAttribute("submissionResults", submissionResults);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("level", level);
        return "student/listening";
    }

    // =============== VOCABULARY ===============

    @GetMapping("/{level}/vocabulary")
    public String showVocabulary(@PathVariable String level, Model model, HttpSession session, RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicVocabulary> words = vocabularyLevelDao.findByLevel(dbLevel);
        List<BasicVocabularyQuiz> quizzes = extraQuizDao.findVocabularyByLevel(dbLevel);

        Map<String, List<BasicVocabulary>> wordsByCategory = new LinkedHashMap<>();
        for (BasicVocabulary w : words) {
            wordsByCategory.computeIfAbsent(w.getCategory(), k -> new ArrayList<>()).add(w);
        }

        model.addAttribute("wordsByCategory", wordsByCategory);
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("level", level);
        return "student/vocabulary";
    }

    @GetMapping("/{level}/vocabulary-quiz")
    public String showVocabularyQuiz(@PathVariable String level,
                                     @RequestParam(defaultValue = "emotions") String category,
                                     Model model,
                                     HttpSession session,
                                     RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicVocabularyQuiz> quizzes = extraQuizDao.findVocabularyByLevel(dbLevel);
        List<BasicVocabularyQuiz> filtered = quizzes.stream()
            .filter(q -> q.getCategory().equalsIgnoreCase(category))
            .collect(Collectors.toList());

        if (filtered.isEmpty()) {
            filtered = quizzes.stream()
                .filter(q -> q.getCategory().toLowerCase().contains(category.toLowerCase()))
                .collect(Collectors.toList());
        }

        model.addAttribute("quizzes", filtered);
        model.addAttribute("level", level);
        model.addAttribute("category", category);
        return "student/vocabulary-quiz";
    }

    @PostMapping("/{level}/vocabulary-quiz/submit")
    public String submitVocabularyQuiz(@PathVariable String level,
                                       @RequestParam Map<String, String> form,
                                       @RequestParam String category,
                                       Model model,
                                       HttpSession session,
                                       RedirectAttributes ra) {
        Student student = (Student) session.getAttribute("student");
        if (student == null) return "redirect:/login";

        String dbLevel = mapLevel(level);
        if (!canAccessLevel(dbLevel, student.getLevel())) {
            ra.addFlashAttribute("error", "This level is locked. Complete " + student.getLevel() + " first.");
            return "redirect:/student/level-error";
        }

        List<BasicVocabularyQuiz> quizzes = extraQuizDao.findVocabularyByLevel(dbLevel);
        List<BasicVocabularyQuiz> filtered = quizzes.stream()
            .filter(q -> q.getCategory().equalsIgnoreCase(category))
            .collect(Collectors.toList());

        int score = 0;
        for (BasicVocabularyQuiz q : filtered) {
            String submitted = form.get("answer_" + q.getId());
            if (submitted != null && submitted.equals(q.getCorrectAnswer())) score++;
        }

        model.addAttribute("quizzes", filtered);
        model.addAttribute("score", score);
        model.addAttribute("total", filtered.size());
        model.addAttribute("category", category);
        model.addAttribute("level", level);
        return "student/vocabulary-quiz";
    }

    // =============== HELPERS ===============

    private String mapLevel(String pathLevel) {
        return switch (pathLevel.toLowerCase()) {
            case "basic" -> "Beginner";
            case "preintermediate" -> "Pre-Intermediate";
            case "intermediate" -> "Intermediate";
            case "advanced" -> "Advanced";
            default -> "Beginner";
        };
    }

    private boolean canAccessLevel(String requestedLevel, String studentLevel) {
        List<String> levels = Arrays.asList("Beginner", "Pre-Intermediate", "Intermediate", "Advanced");
        int requestedIndex = levels.indexOf(requestedLevel);
        int studentIndex = levels.indexOf(studentLevel);
        return requestedIndex != -1 && studentIndex != -1 && requestedIndex <= studentIndex;
    }
}
