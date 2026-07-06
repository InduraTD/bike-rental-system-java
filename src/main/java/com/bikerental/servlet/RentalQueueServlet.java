package com.bikerental.servlet;

import com.bikerental.model.RentalRequest;
import com.bikerental.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/rentalQueue")
public class RentalQueueServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String requestId = request.getParameter("requestId");

        if ("delete".equals(action) && requestId != null && !requestId.trim().isEmpty()) {
            List<RentalRequest> requests = FileUtil.readRequests(getServletContext());

            // Only remove matching request
            boolean removed = requests.removeIf(r -> requestId.equals(r.getRequestId()));

            if (removed) {
                FileUtil.overwriteRequests(requests, getServletContext());
            }
        }

        // Redirect back to tab or refresh
        response.sendRedirect("admin_dashboard.jsp#queue");
    }
}
