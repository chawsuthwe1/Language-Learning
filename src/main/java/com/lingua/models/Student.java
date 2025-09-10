package com.lingua.models;

public class Student {
    // NOTE: Your DB/DAO appears to use "student_id" in places; this field name is "user_id"
    // but you expose both getUser_id() and getStudent_id() for compatibility.
    private int user_id;

    private String name;
    private String email;
    private String password;
    private String image;

    // Default level is Beginner; can be overwritten after placement
    private String level = "Beginner";

    // Optional: store last placement score if you add the column in DB
    // ALTER TABLE students ADD COLUMN last_placement_score INT NULL;
    private Integer lastPlacementScore;

    public Student() {}

    public Student(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
        // level stays at its default "Beginner"
    }

    public Student(int user_id, String name, String email, String password, String image) {
        super();
        this.user_id = user_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.image = image;
        // level stays at its default "Beginner"
    }

    public Student(String email, String password) {
        super();
        this.email = email;
        this.password = password;
        // level stays at its default "Beginner"
    }

    // --- ID getters/setters (compat for existing code) ---
    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    // Many parts of your code use getStudent_id()
    public int getStudent_id() { 
        return user_id; 
    }
    public void setStudent_id(int id) { 
        this.user_id = id; 
    }
    public void setStudentId(int studentId) {
        this.user_id = studentId;
    }


    // --- Basic fields ---
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
 // add inside com.lingua.models.Student
    public String getFullname() {
        // if you later add first/last names, combine them here.
        return this.name;
    }

    public String getFullName() {
        return getFullname(); // alias for different EL casing
    }


    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    // --- Level handling ---
    public String getLevel() { 
        return level; 
    }
    public void setLevel(String level) { 
        this.level = level; 
    }

    // --- Optional score storage ---
    public Integer getLastPlacementScore() {
        return lastPlacementScore;
    }
    public void setLastPlacementScore(Integer lastPlacementScore) {
        this.lastPlacementScore = lastPlacementScore;
    }

	public int getStudentId() {
		// TODO Auto-generated method stub
		return user_id;
	}
}
