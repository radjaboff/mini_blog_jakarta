<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kirish - Mini Blog</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Maxsus CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="d-flex align-items-center min-vh-100">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5 col-lg-4">
            <div class="card p-4 p-sm-5 border-0">

                <div class="text-center mb-4">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none d-inline-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-journal-text text-primary fs-2"></i>
                        <span class="brand-logo">MiniBlog</span>
                    </a>
                    <p class="text-secondary small mb-0">Hisobingizga kiring</p>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger py-2 text-center rounded-3 mb-3" role="alert">
                        <small>${errorMessage}</small>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label text-secondary fw-semibold small">Username yoki Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person text-primary"></i></span>
                            <input type="text" name="username" class="form-control" placeholder="username" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-secondary fw-semibold small">Parol</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock text-primary"></i></span>
                            <input type="password" name="password" class="form-control" placeholder="******" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold mb-3">
                        Kirish
                    </button>
                </form>

                <div class="text-center">
                    <span class="text-muted small">Hisobingiz yo'qmi?</span>
                    <a href="/register" class="text-decoration-none fw-semibold small text-primary"> Ro'yxatdan o'ting</a>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>