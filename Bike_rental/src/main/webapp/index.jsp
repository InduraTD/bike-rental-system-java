<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bikerental.model.Bike" %>
<%@ page import="com.bikerental.util.FileUtil" %>
<%
  List<Bike> bikes = FileUtil.readBikes(application);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>BikeRentPro</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;900&family=Quicksand:wght@600;800&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"/>
  <style>
    :root {
      --blue-dark: #3B7097;
      --blue-mid: #4A8DB7;
      --blue-light: #75BDE0;
      --blue-pale: #A2E2F8;
      --white: #ffffff;
      --text: #000;
      --bg: #f4faff;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: var(--bg);
      color: var(--text);
    }

    a {
      text-decoration: none;
    }

    /* HERO */
    .hero {
      padding: 12rem 1rem 4rem;
      background: linear-gradient(to bottom, var(--blue-light), var(--bg));
      text-align: center;
      min-height: 60vh;
    }

    .hero h1 {
      font-family: 'inter', sans-serif;
      font-size: 8rem;
      font-weight: 1000;
      color: var(--blue-dark);
      margin-bottom: 1rem;
    }

    .hero p {
      font-size: 1.5rem;
      color: var(--blue-dark);
      max-width: 800px;
      margin: 0 auto 2rem;
    }

    .pro-text {
      color: var(--white);
    }

    .hero .btn {
      padding: 1rem 3rem;
      border-radius: 30px;
      font-size: 1rem;
      font-weight: 600;
      margin: 0.5rem;
    }

    .btn-primary {
      background-color: var(--blue-dark);
      border: none;
      color: white;
    }

    .btn-outline {
      background-color: var(--white);
      border: 2px solid var(--blue-dark);
      color: var(--blue-dark);
    }

    /* SECTION TITLE */
    .section-title {
      font-size: 2rem;
      font-weight: 700;
      text-align: center;
      margin-bottom: 2rem;
    }

    /* HOW IT WORKS */
    .how-it-works .icon-box {
      background: var(--white);
      border-radius: 12px;
      text-align: center;
      padding: 2rem 1.2rem;
      box-shadow: 0 15px 20px rgba(0,0,0,0.1);
    }

    .icon-box i {
      font-size: 2rem;
      color: var(--blue-mid);
      margin-bottom: 1rem;
    }

    .icon-box h6 {
      font-size: 1.2rem;
      font-weight: 900;
      margin: 10px;
    }

    /* BIKE CARDS */
    .bike-card {
      border: none;
      border-radius: 1rem;
      background: white;
      box-shadow: 0 15px 20px rgba(0,0,0,0.1);
      overflow: hidden;
    }

    .bike-card img {
      max-height: 230px;
      object-fit: contain;
    }

    .bike-card .card-body {
      padding: 1rem;
    }

    .btn-unavailable {
      background-color: gray;
      border: none;
      font-weight: 400;
      padding: 0.75rem 1.5rem;
      border-radius: 12px;
      color: white;
    }

    .badge {
      padding: 0.7rem;
      margin-right: 0.5rem;
    }

    .badge-type {
      background-color: black;
      color: white;
    }

    .badge-price {
      border: green 0.1rem solid;
      color: green;
    }

    .badge-shared {
      background-color: #f0dbff;
      color: #6b30b0;
    }

    .badge-unavailable {
      background-color: #f8d7da;
      color: #842029;
    }

    .badge-available {
      background-color: #d1e7dd;
      color: #0f5132;
    }

    /* WHY CHOOSE */
    .why-choose {
      background-color: var(--bg);
      padding: 15rem 1rem;
    }

    .why-title {
      font-family: 'Quicksand', sans-serif;
      font-size: 2.5rem;
      color: var(--blue-dark);
    }

    .brand-name {
      font-size: 5rem;
      font-weight: 900;
      color: var(--blue-mid);
    }

    .why-card {
      background: var(--blue-light);
      color: white;
      border-radius: 14px;
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      box-shadow: 0 6px 16px rgba(0,0,0,0.06);
    }

    .why-card i {
      font-size: 1.4rem;
      margin-right: 1rem;
    }

    /* FOOTER */
    footer {
      background: linear-gradient(to top, var(--blue-light), var(--bg));
      padding: 9rem 1rem 3rem 1rem;
    }

    .footer-logo {
      font-size: 2rem;
      font-weight: 900;
      color: var(--text);
    }

    .footer-section h6 {
      font-weight: 700;
      margin-bottom: 1rem;
      color: var(--blue-dark);
    }

    .footer-links,
    .footer-contact {
      list-style: none;
      padding-left: 0;
    }

    .footer-links li,
    .footer-contact li {
      margin-bottom: 0.8rem;
    }

    .footer-links a {
      color: #000;
      text-decoration: none;
      display: flex;
      align-items: center;
    }

    .footer-links a i {
      margin-right: 10px;
      color: var(--blue-dark);
    }

    .footer-links a:hover {
      text-decoration: underline;
    }

    .footer-contact i {
      margin-right: 10px;
      color: var(--blue-dark);
      width: 20px;
      display: inline-block;
      text-align: center;
    }

    .footer-social i {
      font-size: 2rem;
      color: var(--blue-dark);
      margin-right: 1rem;
    }

    .footer-bottom {
      text-align: center;
      font-size: 1rem;
      margin-top: 2rem;
      color: var(--text);
    }

    .hr {
      border-top: 2px dashed var(--blue-dark);
    }

  </style>
</head>
<body>
<!-- HERO -->
<section class="hero">
  <h1>BikeRent<span class="pro-text">Pro</span></h1>
  <p>Rent high-quality motorbikes from trusted owners across the city</p>
  <a href="register.jsp" class="btn btn-primary">Register</a>
  <a href="login.jsp" class="btn btn-outline">Login</a>
</section>

<!-- HOW IT WORKS -->
<section class="container my-5 how-it-works pb-5">
  <h2 class="section-title">How It Works</h2>
  <div class="row g-4">
    <div class="col-md-4">
      <div class="icon-box">
        <i class="fa-solid fa-magnifying-glass-location"></i>
        <h6>Browse Motorbikes</h6>
        <p>Explore all available options.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="icon-box">
        <i class="fa-solid fa-bolt"></i>
        <h6>Book Instantly</h6>
        <p>Submit your rental request and get confirmed quickly.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="icon-box">
        <i class="fa-solid fa-map-location-dot"></i>
        <h6>Return with Ease</h6>
        <p>Drop off the bike at any approved return point.</p>
      </div>
    </div>
  </div>
</section>

<!-- POPULAR BIKES -->
<section class="container my-5 pt-5">
  <h2 class="section-title">Popular Bikes</h2>
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <% for (Bike b : bikes) { %>
    <div class="col-md-4">
      <div class="card bike-card">
        <img src="img/bike<%= b.getBikeId().substring(1) %>.jpg" class="card-img-top" alt="Bike">
        <div class="card-body text-center">
          <h5 class="fw-bold"><%= b.getName() %></h5>
          <p class="mb-2">
            <span class="badge badge-type"><%= b.getType() %></span>
            <span class="badge badge-price">Rs. <%= b.getPricePerHour() %>/hr</span>
            <span class="badge <%= b.isAvailable() ? "badge-available" : "badge-unavailable" %>">
              <%= b.isAvailable() ? "Available" : "Unavailable" %>
            </span>
            <% if (b.getShared()) { %>
              <span class="badge badge-shared">Shared</span>
            <% } %>
          </p>
          <button class="btn <%= b.isAvailable() ? "btn-primary" : "btn-unavailable" %> btn-sm w-100" <%= b.isAvailable() ? "" : "disabled" %>>Rent This Bike</button>
        </div>
      </div>
    </div>
    <% } %>
  </div>
</section>

<!-- WHY CHOOSE -->
<section class="why-choose">
  <div class="container">
    <div class="row gy-5">
      <!-- Left Title Section -->
      <div class="col-md-6 d-flex flex-column justify-content-center">
        <div class="why-title">Why Choose</div>
        <div class="brand-name">BikeRentPro</div>
      </div>

      <!-- Right Card Section -->
      <div class="col-md-6">
        <div class="d-flex flex-column gap-4">
          <div class="why-card d-flex align-items-start">
            <i class="fa-solid fa-motorcycle mt-1"></i>
            <div>
              <strong>Top-Quality Motorbikes</strong>
              <p>Only verified, high-performance bikes — ready to ride.</p>
            </div>
          </div>

          <div class="why-card d-flex align-items-start">
            <i class="fa-solid fa-shield-halved mt-1"></i>
            <div>
              <strong>Secure Booking</strong>
              <p>All transactions are encrypted & owner-verified.</p>
            </div>
          </div>

          <div class="why-card d-flex align-items-start">
            <i class="fa-solid fa-clock mt-1"></i>
            <div>
              <strong>Flexible Durations</strong>
              <p>Choose hourly or daily rentals that fit your journey.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>


<!-- footer.jsp -->
<footer>
  <div class="container">
    <div class="row gy-4">
      <div class="col-md-4">
        <div class="footer-logo">BikeRentPro</div>
        <p class="mt-2">Ride smarter, rent better.</p>
      </div>

      <div class="col-md-2 footer-section">
        <h6>Company</h6>
        <ul class="footer-links">
          <li><a href="#"><i class="fa-solid fa-user-shield"></i>Privacy Policy</a></li>
          <li><a href="#"><i class="fa-solid fa-file-signature"></i>Terms of Service</a></li>
        </ul>
      </div>

      <div class="col-md-3 footer-section">
        <h6>Support</h6>
        <ul class="footer-contact">
          <li><i class="fa-solid fa-envelope"></i> grouppgno295@gmail.com</li>
          <li><i class="fa-solid fa-phone"></i> +94 76-324227</li>
          <li><i class="fa-solid fa-location-dot"></i> Malabe, Sri Lanka</li>
        </ul>
      </div>

      <div class="col-md-3 footer-section">
        <h6>Follow Us</h6>
        <div class="footer-social">
          <a href="#"><i class="fab fa-facebook"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
        </div>
      </div>
    </div>
    <hr class="hr">
    <div class="footer-bottom">
      © 2025 BikeRentPro • PGNO-295 SE1020 Project
    </div>
  </div>
</footer>


</body>
</html>
