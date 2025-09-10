package com.lingua.models;

public class Admin {
    private int id;
    private String name;
    private String email;
    private String password;
    private String image;

    public Admin() {}

    // Constructor for login
    public Admin(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // Constructor for creating new admin without ID
    public Admin(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // Full constructor
    public Admin(int id, String name, String email, String password, String image) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.image = image;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
