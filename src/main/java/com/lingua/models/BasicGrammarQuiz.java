package com.lingua.models;

public class BasicGrammarQuiz {
    private Long id;
    private String question;
    private String options; // JSON or CSV
    private String answer;
    private String lessonSlug;

    public BasicGrammarQuiz() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getOptions() { return options; }
    public void setOptions(String options) { this.options = options; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public String getLessonSlug() { return lessonSlug; }
    public void setLessonSlug(String lessonSlug) { this.lessonSlug = lessonSlug; }
}


