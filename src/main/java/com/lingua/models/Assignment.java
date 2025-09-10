package com.lingua.models;

public class Assignment {
    private Long id;
    private String title;
    private String instructions;
    private Long lessonId;

    public Assignment() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }

    public Long getLessonId() { return lessonId; }
    public void setLessonId(Long lessonId) { this.lessonId = lessonId; }

	public void setReviewed(boolean b) {
		// TODO Auto-generated method stub
		
	}

	public Assignment orElse(Object object) {
		// TODO Auto-generated method stub
		return null;
	}
}
