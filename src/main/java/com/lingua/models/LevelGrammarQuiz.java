package com.lingua.models;

public class LevelGrammarQuiz {
    private Long id;
    private String lessonSlug;
    private String question;
    private String options;
    private String answer;

    // Getters and setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLessonSlug() { return lessonSlug; }
    public void setLessonSlug(String lessonSlug) { this.lessonSlug = lessonSlug; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getOptions() { return options; }
    public void setOptions(String options) { this.options = options; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
}