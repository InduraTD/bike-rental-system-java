# 🚲 Bike Rental & Sharing Platform

A web-based **Bike Rental and Sharing System** developed in Java. This project was built as a 1st-year university application demonstrating Object-Oriented Programming (OOP) principles, Servlets, and JSP.

---

## 🚀 Key Features

* **User Authentication**: Secure register, login, and logout functionalities for both Riders and Administrators.
* **Role-Based Dashboards**:
  * **Riders**: View available bikes, submit rental requests, and view current/past rides.
  * **Admins**: Manage bike inventory, approve/reject rental requests, and view transaction queues.
* **Bike Inventory Management**: Real-time tracking of bike availability, location, and condition.
* **Queue System**: Request queue system to handle rental requests in a first-in, first-out manner.

---

## 🛠️ Tech Stack

* **Language**: Java 17+
* **Framework / Specs**: Java Servlets & JavaServer Pages (JSP)
* **Build System**: Apache Maven
* **Server**: Apache Tomcat 9+
* **Data Storage**: Text-file based database (Flat files under `WEB-INF/data/`)

---

## 📐 Object-Oriented Programming (OOP) Implementation

This application is built with a strong focus on core OOP principles:

1. **Encapsulation**: Models like `User`, `Bike`, and `RentalRequest` encapsulate their properties (private attributes with public getter/setter methods) to protect integrity.
2. **Inheritance**: Role-specific classes (`RiderUser` and `AdminUser`) extend the base `User` class to share common attributes like username and password.
3. **Polymorphism**: Method overriding is used to customize behaviors for different user roles (e.g., dashboard access rights).
4. **Abstraction**: Logic is separated into utility classes (like `FileUtil` for data loading and saving) to shield callers from file parsing details.

---

## 📁 Repository Structure

```
├── src/
│   ├── main/
│   │   ├── java/com/bikerental/
│   │   │   ├── model/         # User, Bike, RentalRequest OOP Models
│   │   │   ├── servlet/       # Request routing & handling
│   │   │   └── util/          # File parsing & database helpers
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── data/      # Text-file flat databases
│   │       │   └── web.xml    # Servlet mappings
│   │       ├── img/           # App asset files
│   │       └── *.jsp          # User interface templates
├── pom.xml                    # Maven dependency manager
└── README.md                  # Project documentation
```

---

## ⚙️ How to Setup & Run

### Prerequisites
* JDK 17 or higher
* Apache Maven
* Apache Tomcat 9.x or higher

### Local Run Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/InduraTD/bike-rental-system-java.git
   cd bike-rental-system-java
   ```
2. **Build the project** using Maven:
   ```bash
   mvn clean package
   ```
   This will generate a `.war` file under the `target/` directory.
3. **Deploy to Tomcat**:
   * Copy the generated `.war` file to your Tomcat `webapps/` folder.
   * Start your Tomcat server.
4. **Access the application**:
   * Open your browser and go to `http://localhost:8080/Bike_rental` (or your mapped context path).
