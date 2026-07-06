<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bikerental.model.*, com.bikerental.util.FileUtil, java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Bike> bikes = FileUtil.readBikes(application);
    BikeInventory inventory = new BikeInventory(application);
    inventory.quickSortByAvailability();
    List<RentalRequest> requests = FileUtil.readRequests(application);
    List<User> users = FileUtil.readUsers(application);
    long adminCount = users.stream().filter(u -> u.getRole().equals("Admin")).count();
    long riderCount = users.stream().filter(u -> u.getRole().equals("Rider")).count();
    long sharedBikes = bikes.stream().filter(b -> b.getShared()).count();
    long adminBikes = bikes.size() - sharedBikes;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard – BikeSharePro</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;900&display=swap" rel="stylesheet" />
  <style>
    :root {
      --blue-dark: #3B7097;
      --blue-mid: #4A8DB7;
      --blue-light: #75BDE0;
      --bg: #f4faff;
    }
    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--bg);
      margin: 0;
    }
    .sidebar {
      background: var(--blue-light);
      color: white;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: start;
      padding: 2rem 1rem;
    }
    .brand {
      font-size: 1.8rem;
      font-weight: 800;
      text-align: center;
      margin-bottom: 3rem;
    }
    .nav-links a {
      padding: 0.75rem 1.25rem;
      color: white;
      text-decoration: none;
      font-weight: 600;
      margin-bottom: 0.75rem;
      border-radius: 10px;
      display: block;
      text-align: center;
    }
    .nav-links a.active, .nav-links a:hover {
      background-color: var(--blue-mid);
      color: white;
    }
    .logout {
      background: #fff3f3;
      color: #d9534f;
      text-align: center;
      border-radius: 10px;
      padding: 0.6rem;
      font-weight: 600;
      text-decoration: none;
      margin-top: auto;
    }
    .content-area {
      padding: 2rem;
    }
    .card-center {
      max-width: 800px;
      margin: 3rem auto;
      box-shadow: 0 12px 30px rgba(0,0,0,0.08);
      border-radius: 24px;
      background: white;
      padding: 3rem;
    }
    .bike-card {
      border: none;
      border-radius: 1rem;
      background: white;
      box-shadow: 0 8px 16px rgba(0,0,0,0.08);
    }
    .bike-card img {
      max-height: 230px;
      object-fit: contain;
    }
    .bike-card .card-body { padding: 1rem; text-align: center; }
    .badge-shared { background: #f0dbff; color: #6b30b0; }
    .badge-available { background: #d1e7dd; color: #0f5132; }
    .badge-unavailable { background: #f8d7da; color: #842029; }
  </style>
  <script>
    function switchTab(target) {
      document.querySelectorAll('.tab-pane').forEach(tab => tab.classList.remove('show', 'active'));
      document.querySelector(target).classList.add('show', 'active');
      document.querySelectorAll('.nav-links a').forEach(link => link.classList.remove('active'));
      document.querySelector(`[href='${target}']`).classList.add('active');
    }
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', function(e) {
          e.preventDefault();
          switchTab(this.getAttribute('href'));
        });
      });
      switchTab('#add');
    });
  </script>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <div class="col-md-2 sidebar">
      <div class="brand">BikeSharePro</div>
      <div class="nav-links nav nav-pills flex-column">
        <a class="nav-link active" data-bs-toggle="tab" href="#add">Add Bike</a>
        <a class="nav-link" data-bs-toggle="tab" href="#list">View Bikes</a>
        <a class="nav-link" data-bs-toggle="tab" href="#queue">Rental Queue</a>
        <a class="nav-link" data-bs-toggle="tab" href="#users">Users</a>
      </div>
      <a href="logout" class="logout">Logout</a>
    </div>
    <div class="col-md-10 content-area">
      <div class="tab-content">
        <div class="tab-pane fade show active" id="add">
          <div class="card-center">
            <h5 class="mb-4 text-center fw-bold">Register a New Bike</h5>
            <form action="bike" method="post">
              <input type="hidden" name="action" value="add" />
              <div class="mb-3"><input name="name" type="text" class="form-control" placeholder="Bike Name" required /></div>
              <div class="mb-3"><select name="type" class="form-select"><option>Manual</option><option>Electric</option></select></div>
              <div class="mb-3"><input name="price" type="number" step="0.01" class="form-control" placeholder="Price per Hour" required /></div>
              <div class="form-check mb-3"><input type="checkbox" class="form-check-input" name="availability" checked><label class="form-check-label">Available</label></div>
              <button type="submit" class="btn btn-primary w-100">Add Bike</button>
            </form>
          </div>
        </div>
        <div class="tab-pane fade" id="list">
          <div class="row mb-4">
            <div class="col-md-4 text-center"><strong>Total Bikes:</strong> <%= bikes.size() %></div>
            <div class="col-md-4 text-center"><strong>Admin Bikes:</strong> <%= adminBikes %></div>
            <div class="col-md-4 text-center"><strong>User Shared:</strong> <%= sharedBikes %></div>
          </div>
          <div class="row">
            <% for (Bike b : bikes) { %>
              <div class="col-md-4 mb-4">
                <div class="card bike-card">
                  <img src="img/bike<%= b.getBikeId().substring(1) %>.jpg" class="card-img-top" alt="Bike">
                  <div class="card-body">
                    <h5><%= b.getName() %></h5>
                    <p>
                      <span class="badge bg-dark"><%= b.getType() %></span>
                      <span class="badge bg-success">$<%= b.getPricePerHour() %>/hr</span>
                      <span class="badge <%= b.isAvailable() ? "badge-available" : "badge-unavailable" %>">
                        <%= b.isAvailable() ? "Available" : "Unavailable" %>
                      </span>
                      <% if (b.getShared()) { %><span class="badge badge-shared">Shared</span><% } %>
                    </p>
                  </div>
                </div>
              </div>
            <% } %>
          </div>
        </div>
        <div class="tab-pane fade" id="queue">
          <table class="table table-bordered text-center">
            <thead><tr><th>Request ID</th><th>User ID</th><th>Bike ID</th><th>Duration</th><th>Date</th><th>Action</th></tr></thead>
            <tbody>
              <% for (RentalRequest r : requests) { %>
                <tr>
                  <td><%= r.getRequestId() %></td>
                  <td><%= r.getUserId() %></td>
                  <td><%= r.getBikeId() %></td>
                  <td><%= r.getDuration() %> hrs</td>
                  <td><%= r.getRequestDate() %></td>
                  <td>
                    <form action="rentalQueue" method="post">
                      <input type="hidden" name="action" value="delete" />
                      <input type="hidden" name="requestId" value="<%= r.getRequestId() %>" />
                      <button class="btn btn-sm btn-danger">Delete</button>
                    </form>
                  </td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
        <div class="tab-pane fade" id="users">
          <div class="row mb-4">
            <div class="col-md-6 text-center"><strong>Admins:</strong> <%= adminCount %></div>
            <div class="col-md-6 text-center"><strong>Riders:</strong> <%= riderCount %></div>
          </div>
          <table class="table table-striped">
            <thead><tr><th>User ID</th><th>Name</th><th>Email</th><th>Role</th></tr></thead>
            <tbody>
              <% for (User u : users) { %>
                <tr>
                  <td><%= u.getUserId() %></td>
                  <td><%= u.getName() %></td>
                  <td><%= u.getEmail() %></td>
                  <td><%= u.getRole() %></td>
                </tr>
              <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>