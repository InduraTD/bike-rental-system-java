package com.bikerental.model;

import com.bikerental.util.FileUtil;

import javax.servlet.ServletContext;
import java.util.List;

public class BikeInventory {
    private List<Bike> bikes;

    // Constructor: loads bikes from file using context
    public BikeInventory(ServletContext context) {
        this.bikes = FileUtil.readBikes(context);
    }

    public List<Bike> getBikes() {
        return bikes;
    }

    public Bike getBikeById(String id) {
        for (Bike b : bikes) {
            if (b.getBikeId().equals(id)) {
                return b;
            }
        }
        return null;
    }

    public void addBike(Bike bike, ServletContext context) {
        bikes.add(bike);
        FileUtil.writeBikes(bikes, context);
    }

    public void quickSortByAvailability() {
        quickSort(bikes, 0, bikes.size() - 1);
    }

    private void quickSort(List<Bike> list, int low, int high) {
        if (low < high) {
            int pi = partition(list, low, high);
            quickSort(list, low, pi - 1);
            quickSort(list, pi + 1, high);
        }
    }

    private int partition(List<Bike> list, int low, int high) {
        Bike pivot = list.get(high);
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (list.get(j).isAvailable() && !pivot.isAvailable()) {
                i++;
                Bike temp = list.get(i);
                list.set(i, list.get(j));
                list.set(j, temp);
            }
        }
        Bike temp = list.get(i + 1);
        list.set(i + 1, list.get(high));
        list.set(high, temp);
        return i + 1;
    }
}
