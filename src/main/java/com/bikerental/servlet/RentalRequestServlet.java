package com.bikerental.servlet;

import com.bikerental.model.RentalRequest;
import com.bikerental.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet("/rental")
public class RentalRequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // Admin: Delete rental request
            String requestId = request.getParameter("requestId");
            List<RentalRequest> requests = FileUtil.readRequests(getServletContext());
            requests.removeIf(r -> r.getRequestId().equals(requestId));
            FileUtil.writeRequests(requests, getServletContext());
            response.sendRedirect("admin_dashboard.jsp#queue");

        } else {
            // Rider: Submit new rental request
            String bikeId = request.getParameter("bikeId");
            String userId = request.getParameter("userId");
            int duration = Integer.parseInt(request.getParameter("duration"));
            double pricePerHour = Double.parseDouble(request.getParameter("pricePerHour"));
            double cost = duration * pricePerHour;

            String requestId = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
            String requestDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

            RentalRequest rentalRequest = new RentalRequest(requestId, userId, bikeId, duration, cost, requestDate);
            FileUtil.appendRentalRequest(rentalRequest, getServletContext());

            response.sendRedirect("dashboard.jsp");
        }
    }
}
