package com.admin.eventphotographyandvideographybookingsystem;

public class User {
    private String id;
    private String name;
    private String role;
    private boolean isApproved;

    public User(String id, String name, String role, boolean isApproved) {
        this.id = id;
        this.name = name;
        this.role = role;
        this.isApproved = isApproved;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getRole() {
        return role;
    }

    public boolean isApproved() {
        return isApproved;
    }

    public void setApproved(boolean approved) {
        isApproved = approved;
    }
}
