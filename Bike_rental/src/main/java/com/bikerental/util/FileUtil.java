package com.bikerental.util;

import com.bikerental.model.Bike;
import com.bikerental.model.User;
import com.bikerental.model.AdminUser;
import com.bikerental.model.RiderUser;
import com.bikerental.model.RentalRequest;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {

    // USERS ----------------------------------------

    public static List<User> readUsers(ServletContext context) {
        List<User> users = new ArrayList<>();
        String path = context.getRealPath("/WEB-INF/data/users.txt");

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Format: id,name,email,password,role
                String[] parts = line.split(",");
                if (parts.length >= 5) {
                    String role = parts[4].trim();
                    User u = role.equalsIgnoreCase("Admin")
                            ? new AdminUser(parts[0], parts[1], parts[2], parts[3])
                            : new RiderUser(parts[0], parts[1], parts[2], parts[3]);
                    users.add(u);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static void writeUsers(List<User> users, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/users.txt");

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(path))) {
            for (User u : users) {
                bw.write(u.toFileString());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void appendUser(User user, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/users.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
            writer.write(user.toFileString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // BIKES ----------------------------------------

    public static List<Bike> readBikes(ServletContext context) {
        List<Bike> bikes = new ArrayList<>();
        String path = context.getRealPath("/WEB-INF/data/bikes.txt");

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Format: id,type,available,name,price,shared
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    Bike b = new Bike(
                            parts[0],
                            parts[1],
                            Boolean.parseBoolean(parts[2]),
                            parts[3],
                            Double.parseDouble(parts[4]),
                            Boolean.parseBoolean(parts[5])
                    );
                    bikes.add(b);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bikes;
    }

    public static void writeBikes(List<Bike> bikes, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/bikes.txt");

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(path))) {
            for (Bike b : bikes) {
                bw.write(b.toFileString());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // RENTAL REQUESTS -------------------------------

    public static List<RentalRequest> readRequests(ServletContext context) {
        List<RentalRequest> requests = new ArrayList<>();
        String path = context.getRealPath("/WEB-INF/data/requests.txt");

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Format: requestId,userId,bikeId,duration,cost,requestDate
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    requests.add(new RentalRequest(
                            parts[0],
                            parts[1],
                            parts[2],
                            Integer.parseInt(parts[3]),
                            Double.parseDouble(parts[4]),
                            parts[5]
                    ));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public static void appendRentalRequest(RentalRequest req, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/requests.txt");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
            writer.write(req.toFileString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void writeRequests(List<RentalRequest> requests, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/requests.txt");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            for (RentalRequest r : requests) {
                writer.write(r.toFileString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void overwriteRequests(List<RentalRequest> list, ServletContext context) {
        String path = context.getRealPath("/WEB-INF/data/requests.txt");
        try (PrintWriter pw = new PrintWriter(new FileWriter(path))) {
            for (RentalRequest r : list) {
                pw.println(r.getRequestId() + "," +
                        r.getUserId() + "," +
                        r.getBikeId() + "," +
                        r.getDuration() + "," +
                        r.getCost() + "," +
                        r.getRequestDate());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
