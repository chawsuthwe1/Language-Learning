package com.lingua.models;

public class BasicGrammarLesson {
    private String slug;
    private String title;
    private String description;
    private String contentHtml;
    private String level;

    public BasicGrammarLesson() {}

    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContentHtml() { return contentHtml; }
    public void setContentHtml(String contentHtml) { this.contentHtml = contentHtml; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }
}


