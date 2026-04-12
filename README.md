<a href="https://trendshift.io/repositories/151" target="_blank"><img src="https://trendshift.io/api/badge/repositories/151" alt="jaygajera17%2FE-commerce-project-springBoot | Trendshift" style="width: 250px; height: 55px;" width="250" height="55"/></a>

# E-commerce Spring Boot Project

Modernized Spring Boot + JSP e-commerce app with Spring Security, JPA, Flyway, Dockerized MySQL, and Maven wrapper support.

## Quick Navigation

- [What Changed Recently](#what-changed-recently)
- [Prerequisites](#prerequisites)
- [Project Setup](#project-setup)
- [Run the Application](#run-the-application)
- [Run Tests](#run-tests)
- [Database Configuration](#database-configuration)
- [Troubleshooting](#troubleshooting)
- [Workflow and Architecture](#workflow-and-architecture)
- [Useful Links](#useful-links)

## What Changed Recently

- Project structure moved from `JtProject/` to repository root.
- Added Docker support with `Dockerfile` and `docker-compose.yml`.
- Added Maven wrapper metadata in `.mvn/wrapper/`.
- Updated Java target in `pom.xml` to Java 17.
- Made datasource settings environment-overridable:
  - `SPRING_DATASOURCE_URL`
  - `SPRING_DATASOURCE_USERNAME`
  - `SPRING_DATASOURCE_PASSWORD`
- Aligned local defaults with Docker MySQL mapping (`localhost:3308`).
- Added H2-based test config in `src/test/resources/application.properties`.
- Added test dependency `com.h2database:h2` in `pom.xml`.
- Ignored local DB runtime files via `Db_volumes/` in `.gitignore`.

## Prerequisites

- Java 17
- Docker Desktop (for containerized MySQL)
- Git
- IntelliJ IDEA or Eclipse

## Project Setup

### 1) Clone and Open

```powershell
git clone <your-fork-or-repo-url>
Set-Location "E-commerce-project-springBoot-pr-work"
```

Open the repository root as a Maven project.

### 2) Set Java in Current PowerShell Session

```powershell
$env:JAVA_HOME="C:\Path\To\Your\JDK17"
$env:Path="$env:JAVA_HOME\bin;$env:Path"
java -version
```

### 3) Start MySQL Container

```powershell
docker compose up -d ecom-mysql-db
```

## Run the Application

```powershell
Set-Location "<path-to>E-commerce-project-springBoot-pr-work"
./mvnw.cmd spring-boot:run
```

Open these endpoints in your browser:

- `http://localhost:8080/`
- `http://localhost:8080/register`
- `http://localhost:8080/admin/products`

## Run Tests

```powershell
./mvnw.cmd test
```

Tests use H2 in-memory DB from `src/test/resources/application.properties`, so local MySQL is not required for test execution.

## Database Configuration

Runtime file: `src/main/resources/application.properties`

```properties
spring.datasource.url=${SPRING_DATASOURCE_URL:jdbc:mysql://localhost:3308/db?createDatabaseIfNotExist=true&allowPublicKeyRetrieval=true&useSSL=false}
spring.datasource.username=${SPRING_DATASOURCE_USERNAME:user}
spring.datasource.password=${SPRING_DATASOURCE_PASSWORD:password}
```

If you use local (non-Docker) MySQL, set values before running:

```powershell
$env:SPRING_DATASOURCE_URL="jdbc:mysql://localhost:3306/db?createDatabaseIfNotExist=true&allowPublicKeyRetrieval=true&useSSL=false"
$env:SPRING_DATASOURCE_USERNAME="root"
$env:SPRING_DATASOURCE_PASSWORD="root"
```

## Seed Data

- Base SQL file: `basedata.sql`
- Flyway migrations: `src/main/resources/db/migration/`

## Troubleshooting

- `JAVA_HOME not found`: set `JAVA_HOME` to a JDK (not JRE), then restart terminal.
- `release version 21 not supported`: run with Java 17.
- `Communications link failure`: ensure MySQL is up and port matches datasource URL (`3308` in current compose).
- JSP not loading in IDE: run from repository root so `src/main/webapp/WEB-INF/views` resolves correctly.

## Workflow and Architecture

![Workflow](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/69951cb7-65e2-4225-8681-2542859aaec6)

### Controller

- Handles endpoints and passes model data to JSP views (`ModelAndView`).

```java
@GetMapping("login")
public String adminlogin() {
	return "adminlogin";
}
```

- When `/login` is accessed, `src/main/webapp/views/adminlogin.jsp` is rendered.

### Models

- Represent entities and their relationships.

### View

- Renders UI with data received from controllers.

## Common Endpoints

- `http://localhost:8080/`
- `http://localhost:8080/register`
- `http://localhost:8080/admin/products`
- `http://localhost:8080/admin/customers`
- `http://localhost:8080/admin/categories`
- `http://localhost:8080/admin/Dashboard`

## Useful Links

### Spring Boot References

- [Official Apache Maven Documentation](https://maven.apache.org/guides/index.html)
- [Spring Boot Maven Plugin Reference](https://docs.spring.io/spring-boot/docs/2.6.4/maven-plugin/reference/html/)
- [Create an OCI Image](https://docs.spring.io/spring-boot/docs/2.6.4/maven-plugin/reference/html/#build-image)
- [Spring Web Reference](https://docs.spring.io/spring-boot/docs/2.6.4/reference/htmlsingle/#boot-features-developing-web-applications)

### Guides

- [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
- [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
- [Building REST Services with Spring](https://spring.io/guides/tutorials/bookmarks/)

### Project Demo

- [YouTube project walkthrough (legacy version)](https://youtu.be/c6WWdINWSlI) [![youtube][youtube-shield]][youtube-url]

## Preview

![Preview 1](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/02a04d3c-1fc9-418c-b231-639f6525d07e)
![Preview 2](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/24c4451b-43a6-4c23-a78a-786eab4303b0)
![Preview 3](https://github.com/jaygajera17/E-commerce-project-springBoot/assets/81226571/93c1baeb-326c-450f-867e-a883900a6644)

[youtube-shield]: https://img.shields.io/youtube/views/c6WWdINWSlI?style=social
[youtube-url]: https://youtu.be/c6WWdINWSlI
