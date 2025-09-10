package com.lingua.models;

public class AdvancedListeningMCQ {
    private Long id;
    private Long exerciseId;
    private String questionText;
    private String choices;
    private String correctAnswer;

    public AdvancedListeningMCQ() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getExerciseId() { return exerciseId; }
    public void setExerciseId(Long exerciseId) { this.exerciseId = exerciseId; }

    public String getQuestionText() { return questionText; }
    public void setQuestionText(String questionText) { this.questionText = questionText; }

    public String getChoices() { return choices; }
    public void setChoices(String choices) { this.choices = choices; }

    public String getCorrectAnswer() { return correctAnswer; }
    public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }
}


