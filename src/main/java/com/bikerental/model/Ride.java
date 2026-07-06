package com.bikerental.model;

public class Ride {
    private String rideId;
    private String userId;
    private String bikeId;
    private String startTime;
    private int duration;
    private double cost;

    public Ride(String rideId, String userId, String bikeId, String startTime, int duration, double cost) {
        this.rideId = rideId;
        this.userId = userId;
        this.bikeId = bikeId;
        this.startTime = startTime;
        this.duration = duration;
        this.cost = cost;
    }

    public String getRideId() { return rideId; }
    public String getUserId() { return userId; }
    public String getBikeId() { return bikeId; }
    public String getStartTime() { return startTime; }
    public int getDuration() { return duration; }
    public double getCost() { return cost; }
}
