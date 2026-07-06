<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Register – BikeSharePro</title>

  <!-- External Links -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;900&display=swap" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>

  <style>
    :root {
      --blue-dark: #3B7097;
      --blue-mid: #4A8DB7;
      --blue-light: #75BDE0;
      --bg: #e1f2ff;
    }

    body {
      font-family: 'Inter', sans-serif;
      background-color: var(--bg);
      margin: 0;
      min-height: 100vh;
    }

    .page-wrapper {
      position: relative;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }

    .circle {
      position: absolute;
      border-radius: 50%;
      filter: blur(30px);
      z-index: 0;
    }

    .circle1 { width: 400px; height: 400px; background: var(--blue-light); top: -100px; left: -100px; opacity: 0.4; }
    .circle2 { width: 220px; height: 220px; background: var(--blue-mid); bottom: -80px; right: -60px; opacity: 0.7; }
    .circle3 { width: 150px; height: 150px; background: var(--blue-dark); top: 60%; left: 80px; opacity: 0.3; }
    .circle4 { width: 100px; height: 100px; background: var(--blue-light); bottom: 30%; right: 40px; opacity: 0.5; }

    .auth-card {
      width: 100%;
      max-width: 950px;
      border-radius: 1.5rem;
      overflow: hidden;
      box-shadow: 0 10px 30px rgba(0,0,0,0.05);
      background: white;
      position: relative;
      z-index: 2;
    }

    .left-panel {
      background: linear-gradient(to right, var(--blue-dark), var(--blue-light));
      color: white;
    }

    .form-control {
      border-color: var(--blue-dark);
      border-radius: 10px;
      padding: 0.5rem 1rem 0.5rem 2.5rem;
    }

    select.form-control {
      padding-left: 1rem;
    }

    .text-bold {
      font-weight: 900;
      font-size: 2.5rem;
    }

    .main-text {
      color: var(--blue-dark);
      font-size: 2rem;
    }

    .input-icon {
      position: absolute;
      left: 1rem;
      top: 50%;
      transform: translateY(-50%);
      color: var(--blue-mid);
    }

    .form-group {
      position: relative;
    }

    .btn-primary {
      background-color: var(--blue-dark);
      border: none;
      border-radius: 10px;
      font-weight: 600;
    }

    .btn-primary:hover {
      background-color: var(--blue-mid);
    }

    @media (max-width: 767px) {
      .left-panel { display: none; }
      .auth-card { border-radius: 0; box-shadow: none; }
      .main-text { font-size: 1.6rem; }
    }
  </style>
</head>

<body>
<div class="page-wrapper">

  <!-- Background Circles -->
  <div class="circle circle1"></div>
  <div class="circle circle2"></div>
  <div class="circle circle3"></div>
  <div class="circle circle4"></div>

  <!-- Registration Card -->
  <div class="container px-3 px-md-4 py-5">
    <div class="auth-card row g-0 mx-auto">

      <!-- Left Welcome Panel -->
      <div class="col-md-6 d-none d-md-flex align-items-center justify-content-center left-panel p-5">
        <div class="text-center px-4">
          <h2 class="text-bold">Create Account</h2>
          <p class="mt-3">Join the ride with BikeSharePro</p>
        </div>
      </div>

      <!-- Right Form Panel -->
      <div class="col-12 col-md-6 d-flex align-items-center justify-content-center p-5 bg-white">
        <div class="w-100" style="max-width: 400px;">
          <h3 class="fw-bold text-center mb-4 main-text">Register</h3>
          <form action="register" method="post">
            <div class="form-group mb-3">
              <i class="fa-solid fa-user input-icon"></i>
              <input type="text" name="fullName" class="form-control" placeholder="Full Name" required />
            </div>
            <div class="form-group mb-3">
              <i class="fa-solid fa-envelope input-icon"></i>
              <input type="email" name="email" class="form-control" placeholder="Email address" required />
            </div>
            <div class="form-group mb-3">
              <i class="fa-solid fa-lock input-icon"></i>
              <input type="password" name="password" class="form-control" placeholder="Password" required />
            </div>
            <div class="form-group mb-4">
              <label class="form-label ps-1">Select Role</label>
              <select class="form-control" name="role" required>
                <option value="" disabled selected>Select your role</option>
                <option value="Rider">Rider</option>
                <option value="Admin">Admin</option>
              </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
            <p class="text-center mt-3 mb-0">Already have an account? <a href="login.jsp">Login</a></p>
          </form>
        </div>
      </div>

    </div>
  </div>
</div>
</body>
</html>
