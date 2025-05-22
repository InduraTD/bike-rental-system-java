package com.bikerental.model;

public class RiderUser extends User {

    public RiderUser(String id, String name, String email, String password) {
        super(id, name, email, password);
    }

    @Override
    public String getRole() {
        return "Rider";
    }

    @Override
    public String toFileString() {
        return userId + "," + name + "," + email + "," + password + "," + getRole();
    }
}
