<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniBlog - Tizimdan chiqish</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="d-flex flex-column min-vh-100 justify-content-center align-items-center">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card p-4 text-center border-0 shadow-lg">
                <div class="mb-3 text-warning">
                    <i class="bi bi-exclamation-triangle-fill display-3"></i>
                </div>

                <h4 class="fw-bold text-dark mb-2">Tizimdan chiqasizmi?</h4>
                <p class="text-secondary mb-4 fs-6">
                    Haqiqatan ham hisobingizdan chiqmoqchimisiz? Qayta kirish uchun parolingizni kiritishingizga to'g'ri keladi.
                </p>

                <!-- Tasdiqlash formasi (POST yuboradi) -->
                <form action="${pageContext.request.contextPath}/logout" method="post" class="d-flex justify-content-center gap-3">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary px-4 rounded-pill">
                        <i class="bi bi-x-circle me-1"></i> Bekor qilish
                    </a>
                    <button type="submit" class="btn btn-danger px-4 rounded-pill shadow">
                        <i class="bi bi-box-arrow-right me-1"></i> Ha, chiqish
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>