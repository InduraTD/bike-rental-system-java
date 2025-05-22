<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bikerental.model.*, com.bikerental.util.FileUtil, java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String bikeId = request.getParameter("bikeId");
    Bike selectedBike = null;
    for (Bike b : FileUtil.readBikes(application)) {
        if (b.getBikeId().equals(bikeId)) {
            selectedBike = b;
            break;
        }
    }

    if (selectedBike == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    double pricePerHour = selectedBike.getPricePerHour();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Rent This Bike</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
  <style>
    :root {
      --blue-dark: #3B7097;
      --blue-mid: #4A8DB7;
      --blue-light: #75BDE0;
      --blue-pale: #A2E2F8;
      --white: #ffffff;
      --bg: #f4faff;
    }

    body {
      background: linear-gradient(180deg, var(--blue-light), var(--bg));
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
    }

    .glass-box {
      background: var(--white);
      border-radius: 20px;
      padding: 2.5rem;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      max-width: 520px;
      width: 100%;
      color: var(--blue-dark);
    }

    .bike-name {
      font-size: 2.3rem;
      font-weight: bold;
      color: var(--blue-dark);
    }

    .bike-type {
      font-size: 0.9rem;
      background-color: var(--blue-dark);
      padding: 0.3rem 0.8rem;
      border-radius: 15px;
      display: inline-block;
      color: #fff;
    }

    .bike-price {
      font-size: 1.1rem;
      font-weight: 600;
      color: #0f5132;
      background-color: #d1e7dd;
      padding: 0.4rem 0.8rem;
      border-radius: 10px;
      display: inline-block;
    }

    .form-label {
      font-weight: 500;
      color: var(--blue-dark);
    }

    .btn-primary {
      background-color: var(--blue-mid);
      border: none;
    }

    .btn-primary:hover {
      background-color: var(--blue-dark);
    }

    .bike-img {
      max-height: 200px;
      min-height: 180px;
      object-fit: cover;
      width: 100%;
      border-radius: 15px;
      margin-bottom: 1rem;
    }

    .dropdown-menu-dark {
      background-color: var(--blue-dark);
      border: none;
    }

    .dropdown-menu-dark .dropdown-item {
      color: var(--white);
    }

    .dropdown-menu-dark .dropdown-item:hover {
      background-color: var(--blue-mid);
      color: #fff;
    }
  </style>
</head>
<body>

  <div class="dropdown position-absolute top-0 start-0 m-3">
    <button class="btn btn-light rounded-circle shadow-sm" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="width: 48px; height: 48px;">
      <i class="fa-solid fa-bars"></i>
    </button>
    <ul class="dropdown-menu dropdown-menu-dark shadow-sm rounded">
      <li><a class="dropdown-item" href="index.jsp"><i class="fa-solid fa-house me-2"></i>Home</a></li>
      <li><a class="dropdown-item" href="dashboard.jsp"><i class="fa-solid fa-gauge me-2"></i>Dashboard</a></li>
      <li><a class="dropdown-item" href="logout"><i class="fa-solid fa-right-from-bracket me-2"></i>Logout</a></li>
    </ul>
  </div>

  <div class="glass-box">
    <img src="img/bike<%= selectedBike.getBikeId().substring(1) %>.jpg" alt="Bike Image" class="bike-img">

    <div class="text-center mb-4">
      <div class="bike-name"><%= selectedBike.getName() %></div>
      <div class="d-flex justify-content-center align-items-center gap-3 mt-3 flex-wrap">
        <div class="bike-type px-3 py-2">
          <i class="fa-solid fa-gears me-1"></i><%= selectedBike.getType() %>
        </div>
        <div class="bike-price px-3 py-2">
          <i class="fa-solid fa-dollar-sign me-1"></i><%= pricePerHour %> / hr
        </div>
      </div>
    </div>

    <form action="rental" method="post">
      <input type="hidden" name="bikeId" value="<%= selectedBike.getBikeId() %>" />
      <input type="hidden" name="userId" value="<%= user.getUserId() %>" />
      <input type="hidden" name="pricePerHour" value="<%= pricePerHour %>" />

      <div class="mb-3">
        <label class="form-label">Duration (in hours)</label>
        <input type="number" name="duration" id="durationInput" class="form-control" required min="1" oninput="updateReceipt()" />
      </div>

      <button type="submit" class="btn btn-primary w-100">Rent This Bike</button>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>