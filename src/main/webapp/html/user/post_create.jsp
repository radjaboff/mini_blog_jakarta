<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniBlog - Yangi Post Yaratish</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navbarni ulash -->
<jsp:include page="/html/navbar.jsp" />

<!-- Asosiy Kontent -->
<div class="container my-5 flex-grow-1">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">
            <div class="card p-4 shadow-lg border-0">

                <div class="text-center mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle mb-3" style="width: 60px; height: 60px;">
                        <i class="bi bi-pencil-square fs-3"></i>
                    </div>
                    <h3 class="fw-bold text-dark">Yangi post yaratish</h3>
                    <p class="text-secondary small">Ajoyib g'oyalaringiz va fikrlaringizni jamiyat bilan ulashing</p>
                </div>

                <!-- Xatolik bo'lsa ko'rsatiladigan blok -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Post Yaratish Formasi -->
                <form action="${pageContext.request.contextPath}/post/create" method="post">

                    <!-- Post Sarlavhasi -->
                    <div class="mb-3">
                        <label for="title" class="form-label fw-semibold text-dark">
                            <i class="bi bi-heading text-primary me-1"></i>Sarlavha
                        </label>
                        <input type="text" class="form-control form-control-lg" id="title" name="title"
                               placeholder="Mavzu sarlavhasini kiriting..." required autocomplete="off">
                    </div>

                    <!-- Post Matni -->
                    <div class="mb-4">
                        <label for="content" class="form-label fw-semibold text-dark">
                            <i class="bi bi-body-text text-primary me-1"></i>Post matni
                        </label>
                        <textarea class="form-control" id="content" name="content" rows="7"
                                  placeholder="Fikrlaringiz va maqolangizni shu yerda yozing..." required></textarea>
                    </div>

                    <!-- Tugmalar -->
                    <div class="d-flex justify-content-between align-items-center pt-2">
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary rounded-pill px-4">
                            <i class="bi bi-arrow-left me-1"></i> Orqaga
                        </a>
                        <button type="submit" class="btn btn-primary rounded-pill px-4 shadow">
                            <i class="bi bi-send-fill me-1"></i> Chop etish
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>