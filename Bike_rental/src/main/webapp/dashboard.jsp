<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bikerental.model.*, com.bikerental.util.FileUtil, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Rider".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    BikeInventory inventory = new BikeInventory(application);
    inventory.quickSortByAvailability();
    List<Bike> bikes = inventory.getBikes();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Rider Dashboard – BikeSharePro</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
      justify-content: space-between;
      padding: 2rem 1rem;
    }
    .brand {
      font-size: 1.8rem;
      font-weight: 800;
      text-align: center;
      margin-bottom: 2rem;
    }
    .nav-links {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .nav-links a {
      padding: 0.75rem 1.25rem;
      color: white;
      text-decoration: none;
      font-weight: 600;
      margin-bottom: 0.75rem;
      border-radius: 10px;
      width: 100%;
      text-align: center;
    }
    .nav-links a.active {
      background-color: var(--blue-mid);
    }
    .logout {
      background: #fff3f3;
      color: #d9534f;
      text-align: center;
      border-radius: 10px;
      padding: 0.6rem;
      font-weight: 600;
      text-decoration: none;
    }
    .content-area {
      padding: 2rem;
    }
    .section-title {
      text-align: center;
      color: var(--blue-dark);
      font-size: 2.4rem;
      font-weight: 900;
      margin-bottom: 2rem;
    }
    .bike-card {
      border: none;
      border-radius: 1rem;
      background: white;
      box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    }
    .bike-card img {
      max-height: 220px;
      object-fit: contain;
    }
    .bike-card .card-body {
      padding: 1rem;
      text-align: center;
    }
    .badge {
      padding: 0.7rem;
      margin-right: 0.5rem;
    }
    .badge-type { background-color: black; color: white; }
    .badge-price { border: green 0.1rem solid; color: green; }
    .badge-shared { background-color: #f0dbff; color: #6b30b0; }
    .badge-unavailable { background-color: #f8d7da; color: #842029; }
    .badge-available { background-color: #d1e7dd; color: #0f5132; }
    .card-center {
      max-width: 800px;
      margin: 3rem auto;
      box-shadow: 0 12px 30px rgba(0,0,0,0.08);
      border-radius: 24px;
      background: white;
      padding: 3rem;
    }
    .form-label { font-weight: 600; }
    .form-icon {
      position: absolute;
      left: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: var(--blue-mid);
    }
    .form-group {
      position: relative;
      margin-bottom: 1.5rem;
    }
    .form-control, .form-select {
      padding-left: 2.5rem;
      border-radius: 12px;
    }
    .btn-primary {
      background-color: var(--blue-dark);
      border: none;
      font-weight: 600;
      padding: 0.75rem 1.5rem;
      border-radius: 12px;
    }
    .btn-primary:hover { background-color: var(--blue-mid); }
    .btn-unavailable {
      background-color: gray;
      border: none;
      font-weight: 400;
      padding: 0.75rem 1.5rem;
      border-radius: 12px;
      color: white;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <div class="col-md-2 sidebar">
      <div class="brand">BikeSharePro</div>
      <div class="nav-links nav nav-pills flex-column">
        <a class="nav-link active" data-bs-toggle="tab" href="#bikes">Available Bikes</a>
        <a class="nav-link" data-bs-toggle="tab" href="#share">Share a Bike</a>
      </div>
      <a href="logout" class="logout">Logout</a>
    </div>

    <div class="col-md-10 content-area">
      <div class="tab-content">
        <div class="tab-pane fade show active" id="bikes">
          <h2 class="section-title">Available Bikes</h2>
          <div class="row g-4">
            <% for (Bike b : bikes) { %>
              <div class="col-md-4">
                <div class="card bike-card">
                  <img src="img/bike<%= b.getBikeId().substring(1) %>.jpg" class="card-img-top" alt="Bike">
                  <div class="card-body">
                    <h5 class="fw-bold"><%= b.getName() %></h5>
                    <p class="mb-2">
                      <span class="badge badge-type"><%= b.getType() %></span>
                      <span class="badge badge-price">Rs. <%= b.getPricePerHour() %>/hr</span>
                      <span class="badge <%= b.isAvailable() ? "badge-available" : "badge-unavailable" %>">
                        <%= b.isAvailable() ? "Available" : "Unavailable" %></span>
                      <% if (b.getShared()) { %>
                        <span class="badge badge-shared">Shared</span>
                      <% } %>
                    </p>
                    <% if (b.isAvailable()) { %>
                      <a href="rental_request.jsp?bikeId=<%= b.getBikeId() %>" class="btn btn-primary btn-sm w-100">Rent This Bike</a>
                    <% } else { %>
                      <button class="btn btn-unavailable btn-sm w-100" disabled>Not Available</button>
                    <% } %>
                  </div>
                </div>
              </div>
            <% } %>
          </div>
        </div>

        <div class="tab-pane fade" id="share">
          <div class="card-center">
            <h5 class="mb-4 text-center fw-bold">Share Your Bike</h5>
            <form action="<%= request.getContextPath() %>/bike" method="post">
              <input type="hidden" name="action" value="share" />
              <input type="hidden" name="shared" value="true" />
              <div class="form-group">
                <i class="fa-solid fa-motorcycle form-icon"></i>
                <input type="text" class="form-control" name="name" placeholder="Bike Name" required />
              </div>
              <div class="form-group">
                <i class="fa-solid fa-gear form-icon"></i>
                <select class="form-select" name="type">
                  <option>Manual</option>
                  <option>Electric</option>
                </select>
              </div>
              <div class="form-group">
                <i class="fa-solid fa-dollar-sign form-icon"></i>
                <input type="number" class="form-control" name="price" placeholder="Price per Hour" step="0.01" required />
              </div>
              <div class="form-check mb-4">
                <input class="form-check-input" type="checkbox" name="availability" checked>
                <label class="form-check-label">Available</label>
              </div>
              <button type="submit" class="btn btn-primary w-100">
                <i class="fa-solid fa-share-nodes me-2"></i>Share My Bike
              </button>
            </form>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
