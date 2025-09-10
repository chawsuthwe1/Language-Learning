package com.lingua.models;

public class AdvancedListeningTF {
    private Long id;
    private Long exerciseId;
    private String statement;
    private String answer;

    public AdvancedListeningTF() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getExerciseId() { return exerciseId; }
    public void setExerciseId(Long exerciseId) { this.exerciseId = exerciseId; }

    public String getStatement() { return statement; }
    public void setStatement(String statement) { this.statement = statement; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
}


