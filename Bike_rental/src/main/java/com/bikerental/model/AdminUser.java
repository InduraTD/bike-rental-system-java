package com.bikerental.model;

public class AdminUser extends User {

    public AdminUser(String id, String name, String email, String password) {
        super(id, name, email, password);
    }

    @Override
    public String getRole() {
        return "Admin";
    }

    @Override
    public String toFileString() {
        return userId + "," + name + "," + email + "," + password + "," + getRole();
    }
}
