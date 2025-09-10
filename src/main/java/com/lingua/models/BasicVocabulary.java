package com.lingua.models;

public class BasicVocabulary {
    private Long id;
    private String level;
    private String category;
    private String word;
    private String definition;
    private String example;
    private String image;

    public BasicVocabulary() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getLevel() { return level; }
    public void setLevel(String level) { this.level = level; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getWord() { return word; }
    public void setWord(String word) { this.word = word; }

    public String getDefinition() { return definition; }
    public void setDefinition(String definition) { this.definition = definition; }

    public String getExample() { return example; }
    public void setExample(String example) { this.example = example; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}


