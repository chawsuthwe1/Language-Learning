package com.lingua.models;

public class AdvancedReadingQuestion {
    private Long id;
    private Long readingId;
    private String questionText;
    private String choices;
    private String correctAnswer;

    public AdvancedReadingQuestion() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getReadingId() { return readingId; }
    public void setReadingId(Long readingId) { this.readingId = readingId; }

    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }

    public String getChoices() { return choices; }
    public void setChoices(String choices) { this.choices = choices; }

    public String getCorrectAnswer() { return correctAnswer; }
    public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }
}


