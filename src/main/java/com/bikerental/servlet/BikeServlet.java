package com.bikerental.servlet;

import com.bikerental.model.Bike;
import com.bikerental.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/bike")
public class BikeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            // ✅ Update availability (Admin use case)
            String bikeId = request.getParameter("bikeId");
            boolean available = Boolean.parseBoolean(request.getParameter("availability"));

            List<Bike> bikes = FileUtil.readBikes(getServletContext());
            for (Bike b : bikes) {
                if (b.getBikeId().equals(bikeId)) {
                    b.setAvailable(available);
                    break;
                }
            }
            FileUtil.writeBikes(bikes, getServletContext());
            response.sendRedirect("admin_dashboard.jsp");

        } else if ("share".equals(action)) {
            // ✅ Rider shared a new bike
            String bikeId = UUID.randomUUID().toString();
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            double price = Double.parseDouble(request.getParameter("price"));
            boolean available = request.getParameter("availability") != null;
            boolean shared = true; // always true when shared by user

            Bike sharedBike = new Bike(bikeId, type, available, name, price, shared);
            List<Bike> bikes = FileUtil.readBikes(getServletContext());
            bikes.add(sharedBike);
            FileUtil.writeBikes(bikes, getServletContext());

            response.sendRedirect("dashboard.jsp"); // back to rider view

        } else {
            // ✅ Add new admin bike
            String bikeId = UUID.randomUUID().toString();
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            double price = Double.parseDouble(request.getParameter("price"));
            boolean available = request.getParameter("availability") != null;
            boolean shared = false; // default

            Bike newBike = new Bike(bikeId, type, available, name, price, shared);
            List<Bike> bikes = FileUtil.readBikes(getServletContext());
            bikes.add(newBike);
            FileUtil.writeBikes(bikes, getServletContext());

            response.sendRedirect("admin_dashboard.jsp");
        }
    }
}
