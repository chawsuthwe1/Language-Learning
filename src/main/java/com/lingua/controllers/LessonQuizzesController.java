// src/main/java/com/lingua/controllers/LessonQuizzesController.java

package com.lingua.controllers;

import com.lingua.DAOS.LessonLevelQuizDAO;
import com.lingua.DAOS.LevelExtraQuizDAO;
import com.lingua.models.LevelGrammarQuiz;
import com.lingua.models.BasicReadingQuestion;
import com.lingua.models.BasicListeningTrueFalse;
import com.lingua.models.BasicVocabularyQuiz;
import com.lingua.models.BasicListeningMCQ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/lesson-quizzes")
public class LessonQuizzesController {

    @Autowired
    private LessonLevelQuizDAO dao;

    @Autowired
    private LevelExtraQuizDAO extraDao;

    // Map URL level to DB level
    private String mapLevel(String pathLevel) {
        return switch (pathLevel.toLowerCase()) {
            case "basic" -> "Beginner";
            case "preintermediate" -> "Pre-Intermediate";  // ✅ No hyphen in input, with hyphen in output
            case "intermediate" -> "Intermediate";
            case "advanced" -> "Advanced";
            default -> "Beginner";
        };
    }

    // =============== GRAMMAR ===============

    @PostMapping("/{level}/save")
    public String saveGrammar(@PathVariable String level,
                              @ModelAttribute LevelGrammarQuiz q,
                              RedirectAttributes ra) {
        try {
            // Validate lesson_slug exists
            if (q.getLessonSlug() != null && !dao.lessonSlugExists(level, q.getLessonSlug())) {
                ra.addFlashAttribute("error", "Invalid Lesson Slug: '" + q.getLessonSlug() + "'");
                return "redirect:/admin/lesson-quizzes";
            }
            dao.save(level, q);
            ra.addFlashAttribute("message", "Grammar quiz saved!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Save failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @PostMapping("/{level}/delete")
    public String deleteGrammar(@PathVariable String level, @RequestParam long id, RedirectAttributes ra) {
        try {
            dao.delete(level, id);
            ra.addFlashAttribute("message", "Grammar quiz deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @GetMapping("/{level}/edit")
    public String editGrammar(@PathVariable String level, @RequestParam long id, Model model) {
        LevelGrammarQuiz q = dao.findById(level, id);
        if (q == null) {
            return "redirect:/admin/lesson-quizzes?error=Quiz+not+found";
        }
        model.addAttribute("editQuiz", q);
        model.addAttribute("editLevel", level);
        return index(model); // Reuse index to keep all data
    }

    // =============== READING ===============

    @PostMapping("/{level}/reading/save")
    public String saveReading(@PathVariable String level,
                              @ModelAttribute BasicReadingQuestion q,
                              RedirectAttributes ra) {
        try {
            String lv = mapLevel(level);
            extraDao.saveReading(lv, q);
            ra.addFlashAttribute("message", "Reading question saved!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Save failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @PostMapping("/{level}/reading/delete")
    public String deleteReading(@PathVariable String level, @RequestParam long id, RedirectAttributes ra) {
        try {
            extraDao.deleteReading(id);
            ra.addFlashAttribute("message", "Reading question deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @GetMapping("/{level}/reading/edit")
    public String editReading(@PathVariable String level, @RequestParam long id, Model model) {
        String lv = mapLevel(level);
        BasicReadingQuestion q = extraDao.findReadingById(lv, id);
        if (q == null) {
            return "redirect:/admin/lesson-quizzes?error=Reading+question+not+found";
        }
        model.addAttribute("editReading", q);
        model.addAttribute("editLevel", level);
        return index(model);
    }

    // =============== LISTENING TRUE/FALSE ===============

    @PostMapping("/{level}/listening/tf/save")
    public String saveListeningTF(@PathVariable String level,
                                  @ModelAttribute BasicListeningTrueFalse q,
                                  RedirectAttributes ra) {
        try {
            String lv = mapLevel(level);
            extraDao.saveListeningTF(lv, q);
            ra.addFlashAttribute("message", "Listening True/False saved!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Save failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @PostMapping("/{level}/listening/tf/delete")
    public String deleteListeningTF(@PathVariable String level, @RequestParam long id, RedirectAttributes ra) {
        try {
            extraDao.deleteListeningTF(id);
            ra.addFlashAttribute("message", "Listening TF deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @GetMapping("/{level}/listening/tf/edit")
    public String editListeningTF(@PathVariable String level, @RequestParam long id, Model model) {
        String lv = mapLevel(level);
        BasicListeningTrueFalse q = extraDao.findListeningTFById(lv, id);
        if (q == null) {
            return "redirect:/admin/lesson-quizzes?error=Listening+TF+not+found";
        }
        model.addAttribute("editListeningTF", q);
        model.addAttribute("editLevel", level);
        return index(model);
    }

    // =============== LISTENING MCQ ===============

    @PostMapping("/{level}/listening/mcq/save")
    public String saveListeningMCQ(@PathVariable String level,
                                   @ModelAttribute BasicListeningMCQ q,
                                   RedirectAttributes ra) {
        try {
            String lv = mapLevel(level);
            extraDao.saveListeningMCQ(lv, q);
            ra.addFlashAttribute("message", "Listening MCQ saved!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Save failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @PostMapping("/{level}/listening/mcq/delete")
    public String deleteListeningMCQ(@PathVariable String level, @RequestParam long id, RedirectAttributes ra) {
        try {
            extraDao.deleteListeningMCQ(id);
            ra.addFlashAttribute("message", "Listening MCQ deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @GetMapping("/{level}/listening/mcq/edit")
    public String editListeningMCQ(@PathVariable String level, @RequestParam long id, Model model) {
        String lv = mapLevel(level);
        BasicListeningMCQ q = extraDao.findListeningMCQById(lv, id);
        if (q == null) {
            return "redirect:/admin/lesson-quizzes?error=Listening+MCQ+not+found";
        }
        model.addAttribute("editListeningMCQ", q);
        model.addAttribute("editLevel", level);
        return index(model);
    }

    // =============== VOCABULARY ===============

    @PostMapping("/{level}/vocab/save")
    public String saveVocab(@PathVariable String level,
                            @ModelAttribute BasicVocabularyQuiz q,
                            RedirectAttributes ra) {
        try {
            String lv = mapLevel(level);
            extraDao.saveVocabulary(lv, q);
            ra.addFlashAttribute("message", "Vocabulary quiz saved!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Save failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @PostMapping("/{level}/vocab/delete")
    public String deleteVocab(@PathVariable String level, @RequestParam long id, RedirectAttributes ra) {
        try {
            extraDao.deleteVocabulary(id);
            ra.addFlashAttribute("message", "Vocabulary quiz deleted!");
        } catch (Exception ex) {
            ra.addFlashAttribute("error", "Delete failed: " + ex.getMessage());
        }
        return "redirect:/admin/lesson-quizzes";
    }

    @GetMapping("/{level}/vocab/edit")
    public String editVocab(@PathVariable String level, @RequestParam long id, Model model) {
        String lv = mapLevel(level);
        BasicVocabularyQuiz q = extraDao.findVocabularyById(lv, id);
        if (q == null) {
            return "redirect:/admin/lesson-quizzes?error=Vocabulary+quiz+not+found";
        }
        model.addAttribute("editVocab", q);
        model.addAttribute("editLevel", level);
        return index(model);
    }

    // =============== INDEX (Load All Data) ===============

    @GetMapping
    public String index(Model model) {
        model.addAttribute("basic", dao.findAll("basic"));
        model.addAttribute("preintermediate", dao.findAll("pre-intermediate"));
        model.addAttribute("intermediate", dao.findAll("intermediate"));
        model.addAttribute("advanced", dao.findAll("advanced"));

        model.addAttribute("rq_basic", extraDao.findReadingByLevel("Beginner"));
        model.addAttribute("rq_pre", extraDao.findReadingByLevel("Pre-Intermediate"));
        model.addAttribute("rq_int", extraDao.findReadingByLevel("Intermediate"));
        model.addAttribute("rq_adv", extraDao.findReadingByLevel("Advanced"));

        model.addAttribute("tf_basic", extraDao.findListeningTFByLevel("Beginner"));
        model.addAttribute("tf_pre", extraDao.findListeningTFByLevel("Pre-Intermediate"));
        model.addAttribute("tf_int", extraDao.findListeningTFByLevel("Intermediate"));
        model.addAttribute("tf_adv", extraDao.findListeningTFByLevel("Advanced"));

        model.addAttribute("mcq_basic", extraDao.findListeningMCQByLevel("Beginner"));
        model.addAttribute("mcq_pre", extraDao.findListeningMCQByLevel("Pre-Intermediate"));
        model.addAttribute("mcq_int", extraDao.findListeningMCQByLevel("Intermediate"));
        model.addAttribute("mcq_adv", extraDao.findListeningMCQByLevel("Advanced"));

        model.addAttribute("vq_basic", extraDao.findVocabularyByLevel("Beginner"));
        model.addAttribute("vq_pre", extraDao.findVocabularyByLevel("Pre-Intermediate"));
        model.addAttribute("vq_int", extraDao.findVocabularyByLevel("Intermediate"));
        model.addAttribute("vq_adv", extraDao.findVocabularyByLevel("Advanced"));

        // ✅ Load lesson slugs for dropdowns
        model.addAttribute("basicLessons", dao.findAllLessonSlugs("basic"));
        model.addAttribute("preIntermediateLessons", dao.findAllLessonSlugs("pre-intermediate"));
        model.addAttribute("intermediateLessons", dao.findAllLessonSlugs("intermediate"));
        model.addAttribute("advancedLessons", dao.findAllLessonSlugs("advanced"));

        return "admin/lesson-quizzes";
    }
}