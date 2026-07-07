# Bike Rental System

A web application for renting and sharing bikes, built with Java Servlets and JSP. This was a group project from our 1st year at SLIIT, focused on applying OOP concepts in a real-world scenario.

## What it does

- Users can register as riders, browse available bikes, and submit rental requests
- Admins can manage bike inventory, approve/reject requests, and view the rental queue
- Bikes can be marked as shared, and availability is tracked in real time
- Data is stored in flat text files (no database needed to run it)

## How it's built

The project uses a standard Maven WAR structure and runs on Apache Tomcat.

**Models** — `User` is an abstract class. `RiderUser` and `AdminUser` extend it (inheritance). `Bike`, `Ride`, and `RentalRequest` handle the rest of the domain logic. `BikeInventory` includes a custom QuickSort implementation for sorting bikes by availability.

**Servlets** — Handle authentication, registration, bike management, and rental request processing.

**Data layer** — `FileUtil` reads and writes all data to `.txt` files under `WEB-INF/data/`. No external database required.

**Frontend** — JSP pages for login, registration, rider dashboard, admin dashboard, and rental request forms.

## Project structure

```
src/main/java/com/bikerental/
├── model/          User, Bike, Ride, RentalRequest, BikeInventory
├── servlet/        AuthServlet, BikeServlet, RegisterServlet, etc.
└── util/           FileUtil (file I/O helper)

src/main/webapp/
├── WEB-INF/
│   ├── data/       bikes.txt, users.txt, requests.txt, rides.txt
│   └── web.xml
├── img/            bike images
└── *.jsp           login, register, dashboard pages
```

## Running locally

You'll need JDK 17+, Maven, and Tomcat 9+.

```bash
git clone https://github.com/InduraTD/bike-rental-system-java.git
cd bike-rental-system-java
mvn clean package
```

Then deploy the generated `.war` file from `target/` to your Tomcat `webapps/` folder and start the server. The app should be available at `http://localhost:8080/Bike_rental`.

## OOP concepts used

- **Encapsulation** — private fields with getters/setters in all model classes
- **Inheritance** — `AdminUser` and `RiderUser` extend the abstract `User` class
- **Polymorphism** — `getRole()` and `toFileString()` are overridden differently in each subclass
- **Abstraction** — `FileUtil` hides all file parsing logic from the servlets

## Built with

- Java 17, Servlets, JSP
- Maven
- Apache Tomcat 9
- Flat-file storage (text files)

## Contributors

- [InduraTD](https://github.com/InduraTD)
- [Amaya1001](https://github.com/Amaya1001)
- [Senuhi2003](https://github.com/Senuhi2003)
- [hiran2004-hub](https://github.com/hiran2004-hub)
- [gaveshbandara2004](https://github.com/gaveshbandara2004)
