# MiniBlog

A simple blog platform built with Jakarta EE (Servlet, JSP, JPA/Hibernate). Users can register, write posts, view other users' posts, and like them.

## 📋 Table of Contents
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Getting Started](#-getting-started)
- [Project Structure](#-project-structure)

## ✨ Features
- 🔐 User registration and login (session-based authentication)
- 📝 Create, edit, and delete posts (CRUD)
- ❤️ Like / unlike posts
- 👁️ Track view count per post (counted once per user)
- 👤 "My Posts" page for a user's own content
- 🛡️ Filter-based route protection for pages that require login

## 🛠 Tech Stack
| Layer | Technology |
|---|---|
| Backend | Java, Jakarta Servlet API |
| View | JSP + JSTL |
| ORM | Hibernate (Jakarta Persistence / JPA) |
| Database | PostgreSQL |
| Build tool | Maven |

## 🏗 Architecture
The project follows a classic layered architecture:

```
Servlet (controller) → Service (business logic) → DAO (database access) → Entity
```

## 🚀 Getting Started

### Prerequisites
- JDK 17+
- PostgreSQL
- Apache Maven
- Servlet container (Tomcat)

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/radjaboff/mini_blog_jakarta.git
   cd mini_blog_jakarta
   ```
2. Create a database in PostgreSQL:
   ```sql
   CREATE DATABASE mini_blog;
   ```
3. Set up your local config file:
   ```bash
   cp src/main/resources/META-INF/persistence.xml.example src/main/resources/META-INF/persistence.xml
   ```
   Then update `jakarta.persistence.jdbc.user` and `jakarta.persistence.jdbc.password` in `persistence.xml` with your own PostgreSQL credentials.
4. Build the project and deploy it to Tomcat.

> ⚠️ `persistence.xml` is listed in `.gitignore` (it holds your DB password) — never commit it. Only the `.example` file is tracked in the repository.

## 📁 Project Structure
```
src/main/java/dasturlash/uz/mini_blog/
├── dao/         → database access layer
├── dto/         → data transfer objects
├── entity/      → JPA entity classes
├── enums/       → enum types
├── security/    → authentication filters
├── service/     → business logic
└── servlets/    → HTTP request controllers
```

## 👤 Author
**Akmal Rajabov**
[GitHub](https://github.com/radjaboff) · [LinkedIn](https://www.linkedin.com/in/akmal-rajabov)
