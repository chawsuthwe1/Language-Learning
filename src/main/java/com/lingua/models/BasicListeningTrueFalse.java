package com.lingua.models;

public class BasicListeningTrueFalse {
    private Long id;
    private Long exerciseId;
    private String statement;
    private String answer; // TRUE or FALSE

    public BasicListeningTrueFalse() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getExerciseId() { return exerciseId; }
    public void setExerciseId(Long exerciseId) { this.exerciseId = exerciseId; }

    public String getStatement() { return statement; }
    public void setStatement(String statement) { this.statement = statement; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }
}


