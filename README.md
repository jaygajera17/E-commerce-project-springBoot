<a href="https://trendshift.io/repositories/151" target="_blank"><img src="https://trendshift.io/api/badge/repositories/151" alt="jaygajera17%2FE-commerce-project-springBoot | Trendshift" style="width: 250px; height: 55px;" width="250" height="55"/></a>

# E-commerce Spring Boot (JSP + Hibernate)

Production-oriented Java e-commerce web application built with Spring Boot, JSP, Spring Security, and Hibernate SessionFactory.

This project follows a layered MVC architecture and supports role-based access for admin and customer workflows.

<br/><br/>

<h1>🛒 E-Commerce Spring Boot</h1>
 
<p>A production-oriented Java e-commerce web application built with Spring Boot, JSP, Spring Security, and Hibernate — featuring role-based access for admin and customer workflows.</p>
<br/>
<!-- Badges Row 1: Community -->
<p>
  <a href="https://github.com/jaygajera17/E-commerce-project-springBoot/stargazers">
    <img src="https://img.shields.io/github/stars/jaygajera17/E-commerce-project-springBoot?style=flat-square&logo=github&labelColor=1a1a2e&color=f5a623&label=Stars" alt="Stars"/>
  </a>
  <a href="https://github.com/jaygajera17/E-commerce-project-springBoot/network/members">
    <img src="https://img.shields.io/github/forks/jaygajera17/E-commerce-project-springBoot?style=flat-square&logo=github&labelColor=1a1a2e&color=4a90d9&label=Forks" alt="Forks"/>
  </a>
  <a href="https://github.com/jaygajera17/E-commerce-project-springBoot/issues">
    <img src="https://img.shields.io/github/issues/jaygajera17/E-commerce-project-springBoot?style=flat-square&logo=github&labelColor=1a1a2e&color=e05c5c&label=Issues" alt="Issues"/>
  </a>
  <a href="https://github.com/jaygajera17/E-commerce-project-springBoot/pulls">
    <img src="https://img.shields.io/github/issues-pr/jaygajera17/E-commerce-project-springBoot?style=flat-square&logo=github&labelColor=1a1a2e&color=8e44ad&label=Pull+Requests" alt="Pull Requests"/>
  </a>
  <a href="https://github.com/jaygajera17/E-commerce-project-springBoot/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/jaygajera17/E-commerce-project-springBoot?style=flat-square&logo=github&labelColor=1a1a2e&color=27ae60&label=Contributors" alt="Contributors"/>
  </a>
</p>

<br/>

## Highlights

- Server-rendered e-commerce app (JSP views)
- Spring Security authentication and role-based authorization
- Custom Hibernate SessionFactory configuration (non-Spring-Data JPA runtime)
- MySQL-backed persistence with DAO and service layers
- Admin modules for products, categories, and customer listing
- User modules for registration, login, profile management, and product browsing
- Jenkins pipeline file included for CI/CD bootstrap

## Tech Stack

<p>
  <img src="https://img.shields.io/badge/Java-11-ED8B00?style=flat-square&logo=openjdk&logoColor=white&labelColor=1a1a2e" alt="Java 11"/>
  <img src="https://img.shields.io/badge/Spring%20Boot-2.6.4-6DB33F?style=flat-square&logo=springboot&logoColor=white&labelColor=1a1a2e" alt="Spring Boot"/>
  <img src="https://img.shields.io/badge/Spring%20Security-5.x-6DB33F?style=flat-square&logo=springsecurity&logoColor=white&labelColor=1a1a2e" alt="Spring Security"/>
  <img src="https://img.shields.io/badge/Hibernate-ORM-59666C?style=flat-square&logo=hibernate&logoColor=white&labelColor=1a1a2e" alt="Hibernate"/>
  <img src="https://img.shields.io/badge/MySQL-8.x-4479A1?style=flat-square&logo=mysql&logoColor=white&labelColor=1a1a2e" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Maven-Build-C71A36?style=flat-square&logo=apachemaven&logoColor=white&labelColor=1a1a2e" alt="Maven"/>
</p>

- Java 11
- Spring Boot 2.6.4
- Spring MVC
- Spring Security
- Hibernate ORM (via `LocalSessionFactoryBean`)
- JSP + JSTL + Tomcat Jasper
- MySQL 8 connector
- Maven

## Project Structure

```text
src/main/java/com/jtspringproject/JtSpringProject/
  configuration/     # Security config
  controller/        # MVC controllers
  dao/               # Data access layer
  models/            # Entities
  services/          # Business layer
  repository/        # Spring Data repository (partial)
  HibernateConfiguration.java
  JtSpringProjectApplication.java
src/main/resources/
  application.properties
src/main/webapp/views/
  *.jsp
basedata.sql
pom.xml
```

## Getting Started

### Prerequisites

- Java 11+
- Maven 3.8+
- MySQL or MariaDB

### 1) Clone and move into project

```bash
git clone https://github.com/jaygajera17/E-commerce-project-springBoot.git
cd E-commerce-project-springBoot
```

### 2) Configure database

Update `src/main/resources/application.properties`:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/ecommjava?createDatabaseIfNotExist=true
db.username=your_db_user
db.password=your_db_password

hibernate.dialect=org.hibernate.dialect.MySQL5Dialect
hibernate.show_sql=true
hibernate.hbm2ddl.auto=update
entitymanager.packagesToScan=com
```

### 3) Optional: seed sample data

Run `basedata.sql` against your database if you want initial categories/users/products.

Note: sample credentials in `basedata.sql` are development-only defaults.

### 4) Run the app

```bash
mvn clean package
mvn spring-boot:run
```

App URL: http://localhost:8080/

## IDE Notes (IntelliJ)

If JSP views are not resolved, set the run configuration working directory to `$MODULE_WORKING_DIR$`.

## Core Endpoints

### Public/User

- `/`
- `/login`
- `/register`
- `/newuserregister`
- `/user/products`
- `/profileDisplay`

### Admin

- `/admin/`
- `/admin/Dashboard`
- `/admin/products`
- `/admin/categories`
- `/admin/customers`

## Security Model

- Admin routes under `/admin/**` require role `ADMIN`
- User routes require role `USER`
- Login pages:
  - Admin: `/admin/login`
  - User: `/login`
- CSRF protection is enabled for form submissions

## Build and Test

```bash
mvn clean verify
```

Notes:

- `mvn test` requires a reachable database because context startup initializes Hibernate and datasource beans.

## CI/CD

A Jenkins pipeline is included in `jenkins file` with stages for:

- Checkout
- Build
- Test
- Deploy (template placeholder)

Adjust branch, deployment steps, and credentials for your environment.

## Troubleshooting

- `Could not resolve placeholder 'db.driver'`:
  - Ensure all `db.*` keys exist in `application.properties`
- JSP pages not rendering:
  - Verify working directory and `spring.mvc.view.prefix=/views/`
- Tests failing on startup:
  - Start MySQL and verify connection credentials first

## ❗ Common Errors & Fixes

### 1. JSP views not loading (404 error after startup)
**Symptom:** App starts but http://localhost:8080/ shows 404.
**Fix:** In IntelliJ IDEA:
- Go to Run → Edit Configurations
- Select `JtSpringProjectApplication`
- Set "Working directory" to `$MODULE_WORKING_DIR$`
- Click Apply → OK → Restart the app

### 2. Maven build fails / project not recognized
**Symptom:** `mvn install` errors or IntelliJ doesn't see Spring Boot.
**Fix:**
- Right-click `pom.xml` → "Add as Maven Project"
- Make sure you open the **JtProject** subfolder, not the root folder
- Use JDK 11 or JDK 17 (not JDK 21+ — Hibernate dialect may conflict)

### 3. Database connection error on startup
**Symptom:** `Communications link failure` or `Access denied for user`.
**Fix:** Open `JtProject/src/main/resources/application.properties` and set:
```properties
db.url=jdbc:mysql://localhost:3306/ecommjava?createDatabaseIfNotExist=true
db.username=YOUR_MYSQL_USERNAME
db.password=YOUR_MYSQL_PASSWORD
```
Then run `basedata.sql` in MySQL Workbench to load initial data.

### 4. `mvn test` fails without a database
**Symptom:** Tests fail immediately with datasource errors.
**Fix:** This project's tests require a running MySQL instance.
Start MySQL first, then run `mvn test`.

## Screenshots

![Preview 1](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/02a04d3c-1fc9-418c-b231-639f6525d07e)
![Preview 2](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/24c4451b-43a6-4c23-a78a-786eab4303b0)
![Preview 3](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/93c1baeb-326c-450f-867e-a883900a6644)

## Roadmap

See the full roadmap in [roadmap.md](roadmap.md).

Current priorities:

- Solid foundation: CI, Docker Compose, contribution workflow, and test coverage.
- Complete e-commerce domain: cart, checkout, auth, search, and API docs.
- Industry patterns: caching, concurrency control, observability, and scalability.
- Long-term architecture: event-driven patterns and microservice decomposition guide.

## Demo

demo video: https://youtu.be/c6WWdINWSlI

## ⭐ Support This Project

If this project helped you, please consider giving it a star on GitHub.
Your support helps improve visibility and motivates future maintenance.

## Star History

<a href="https://www.star-history.com/?repos=jaygajera17%2FE-commerce-project-springBoot&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=jaygajera17/E-commerce-project-springBoot&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=jaygajera17/E-commerce-project-springBoot&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=jaygajera17/E-commerce-project-springBoot&type=date&legend=top-left" />
 </picture>
</a>

<div align="center">
  <sub>Built as a college project · Grown into a community resource · Maintained with ❤️</sub>
</div>
