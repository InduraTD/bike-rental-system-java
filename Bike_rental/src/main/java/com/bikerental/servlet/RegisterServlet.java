package com.bikerental.servlet;

import com.bikerental.model.*;
import com.bikerental.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String userId = UUID.randomUUID().toString();
        User user;

        if ("Admin".equalsIgnoreCase(role)) {
            user = new AdminUser(userId, name, email, password);
        } else {
            user = new RiderUser(userId, name, email, password);
        }

        FileUtil.appendUser(user, getServletContext());

        // Auto-login after register
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // Redirect based on role
        if (user.getRole().equalsIgnoreCase("Admin")) {
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            response.sendRedirect("dashboard.jsp");
        }
    }
}
