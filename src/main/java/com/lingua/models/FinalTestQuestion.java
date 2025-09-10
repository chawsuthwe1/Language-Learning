package com.lingua.models;

public class FinalTestQuestion {
    private Long id;
    private Long finalTestId;
    private String question;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctAnswer; // A, B, C, or D
    private int sessionNumber; // 1, 2, 3, or 4
    private String difficulty; // Easy, Medium, Hard

    public FinalTestQuestion() {}

    public FinalTestQuestion(Long finalTestId, String question, String optionA, String optionB, 
                           String optionC, String optionD, String correctAnswer, int sessionNumber) {
        this.finalTestId = finalTestId;
        this.question = question;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctAnswer = correctAnswer;
        this.sessionNumber = sessionNumber;
        this.difficulty = "Medium";
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getFinalTestId() { return finalTestId; }
    public void setFinalTestId(Long finalTestId) { this.finalTestId = finalTestId; }

    public String getQuestion() { return question; }
    public void setQuestion(String question) { this.question = question; }

    public String getOptionA() { return optionA; }
    public void setOptionA(String optionA) { this.optionA = optionA; }

    public String getOptionB() { return optionB; }
    public void setOptionB(String optionB) { this.optionB = optionB; }

    public String getOptionC() { return optionC; }
    public void setOptionC(String optionC) { this.optionC = optionC; }

    public String getOptionD() { return optionD; }
    public void setOptionD(String optionD) { this.optionD = optionD; }

    public String getCorrectAnswer() { return correctAnswer; }
    public void setCorrectAnswer(String correctAnswer) { this.correctAnswer = correctAnswer; }

    public int getSessionNumber() { return sessionNumber; }
    public void setSessionNumber(int sessionNumber) { this.sessionNumber = sessionNumber; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
}
