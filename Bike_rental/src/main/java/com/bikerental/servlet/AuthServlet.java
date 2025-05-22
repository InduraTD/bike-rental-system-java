package com.bikerental.servlet;

import com.bikerental.model.*;
import com.bikerental.util.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class AuthServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        List<User> users = FileUtil.readUsers(getServletContext());
        for (User u : users) {
            if (u.getEmail().equalsIgnoreCase(email) && u.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", u);

                // Redirect all roles to dashboard.jsp
                if (u instanceof AdminUser) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    response.sendRedirect("dashboard.jsp");
                }
                return;
            }
        }

        // Failed login
        request.setAttribute("error", "Invalid email or password.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
