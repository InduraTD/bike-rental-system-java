package com.bikerental.model;

public class RentalRequest {
    private String requestId;
    private String userId;
    private String bikeId;
    private int duration;
    private double cost;
    private String requestDate;

    public RentalRequest(String requestId, String userId, String bikeId, int duration, double cost, String requestDate) {
        this.requestId = requestId;
        this.userId = userId;
        this.bikeId = bikeId;
        this.duration = duration;
        this.cost = cost;
        this.requestDate = requestDate;
    }


    public String getRequestId() { return requestId; }
    public String getUserId() { return userId; }
    public String getBikeId() { return bikeId; }
    public int getDuration() { return duration; }
    public String getRequestDate() { return requestDate; }
    public double getCost() { return cost; }


    public String toFileString() {
        return requestId + "," + userId + "," + bikeId + "," + duration + "," + cost + "," + requestDate;
    }

}
