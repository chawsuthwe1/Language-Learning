package com.lingua.models;

import java.time.LocalDateTime;

public class Activity {
    private int id;
    private String description;
    private String actor;
   // who performed the action
    private String type; 
    private LocalDateTime timestamp;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getActor() { return actor; }
    public void setActor(String actor) { this.actor = actor; }

    public LocalDateTime getTimestamp() { return timestamp; }
    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
    public Object getCreatedAt() {
		// TODO Auto-generated method stub
		return null;
	}
	public String getEmail() {
		// TODO Auto-generated method stub
		return null;
	}
	public String getStatus() {
		// TODO Auto-generated method stub
		return null;
	}
	public String getFullName() {
		// TODO Auto-generated method stub
		return null;
	}
}
