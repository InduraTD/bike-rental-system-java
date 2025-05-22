<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login – BikeSharePro</title>

  <!-- Bootstrap and Font Awesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;900&display=swap" rel="stylesheet"/>

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
      height: 510px;
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

  <!-- Background Vector Circles -->
  <div class="circle circle1"></div>
  <div class="circle circle2"></div>
  <div class="circle circle3"></div>
  <div class="circle circle4"></div>

  <!-- Auth Card -->
  <div class="container px-3 px-md-4 py-5">
    <div class="auth-card row g-0 mx-auto">

      <!-- LEFT PANEL -->
      <div class="col-md-6 d-none d-md-flex align-items-center justify-content-center left-panel p-5">
        <div class="text-center px-4">
          <h2 class="text-bold">Welcome Back</h2>
          <p class="mt-3">Continue renting with BikeSharePro</p>
        </div>
      </div>

      <!-- RIGHT FORM PANEL -->
      <div class="col-12 col-md-6 d-flex align-items-center justify-content-center p-5 bg-white">
        <div class="w-100" style="max-width: 400px;">
          <h3 class="fw-bold text-center mb-4 main-text">Login</h3>
          <form action="login" method="post">
            <div class="form-group mb-3">
              <i class="fa-solid fa-envelope input-icon"></i>
              <input type="email" class="form-control" name="email" placeholder="Email address" required />
            </div>
            <div class="form-group mb-4">
              <i class="fa-solid fa-lock input-icon"></i>
              <input type="password" class="form-control" name="password" placeholder="Password" required />
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
            <p class="text-center mt-3 mb-0">Don't have an account? <a href="register.jsp">Register</a></p>
          </form>
        </div>
      </div>

    </div>
  </div>
</div>
</body>
</html>
