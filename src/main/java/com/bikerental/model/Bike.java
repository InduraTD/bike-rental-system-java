package com.bikerental.model;

public class Bike {
    private String bikeId;
    private String type;
    private boolean available;
    private String name;
    private double pricePerHour;
    private boolean shared; // ✅ New field

    public Bike(String id, String type, boolean available, String name, double pricePerHour, boolean shared) {
        this.bikeId = id;
        this.type = type;
        this.available = available;
        this.name = name;
        this.pricePerHour = pricePerHour;
        this.shared = shared;
    }

    // ✅ Overloaded constructor for backward compatibility
    public Bike(String id, String type, boolean available, String name, double pricePerHour) {
        this(id, type, available, name, pricePerHour, false); // default: not shared
    }

    public String getBikeId() { return bikeId; }
    public String getType() { return type; }
    public boolean isAvailable() { return available; }
    public String getName() { return name; }
    public double getPricePerHour() { return pricePerHour; }
    public boolean getShared() { return shared; }

    public void setName(String name) { this.name = name; }
    public void setAvailable(boolean available) { this.available = available; }
    public void setShared(boolean shared) { this.shared = shared; }

    public String toFileString() {
        return bikeId + "," + type + "," + available + "," + name + "," + pricePerHour + "," + shared;
    }
}
