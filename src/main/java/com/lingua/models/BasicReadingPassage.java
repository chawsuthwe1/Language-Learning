package com.lingua.models;

public class BasicReadingPassage {
    private Long id;
    private String level;
    private String title;
    private String paragraph;

    public BasicReadingPassage() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getParagraph() { return paragraph; }
    public void setParagraph(String paragraph) { this.paragraph = paragraph; }
}


