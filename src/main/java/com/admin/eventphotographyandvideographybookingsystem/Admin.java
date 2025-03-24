package com.admin.eventphotographyandvideographybookingsystem;

public class Admin {
    private String userName;
    private String email;
    private String password;

    // Constructor
    public Admin(String userName, String email, String password) {
        this.userName = userName;
        this.email = email;
        this.password = password;
    }

    // Getters
    public String getUserName() {
        return userName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }
}
