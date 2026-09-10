<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniBlog - Bosh sahifa</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .blog-card {
            border-radius: 20px;
            background: #ffffff;
            transition: transform 0.25s cubic-bezier(0.165, 0.84, 0.44, 1), box-shadow 0.25s ease;
        }
        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08) !important;
        }

        .user-avatar {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            color: #ffffff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .post-content-preview {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            word-break: break-word;
            line-height: 1.6;
            color: #6c757d;
        }

        .btn-read-more {
            border-radius: 50rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .welcome-hero {
            border-radius: 24px;
            background: linear-gradient(145deg, #ffffff, #f8f9fa);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<!-- Navbarni ulash -->
<jsp:include page="navbar.jsp" />

<div class="container my-5 flex-grow-1">

    <!-- LOGIN BO'LMAGAN HOLAT -->
    <c:if test="${empty sessionScope.user}">
        <div class="row justify-content-center text-center my-5">
            <div class="col-md-8 col-lg-6">
                <div class="card p-5 border-0 shadow rounded-4 welcome-hero">
                    <div class="mb-3">
                        <i class="bi bi-chat-square-quote text-primary display-3"></i>
                    </div>
                    <h1 class="display-6 fw-bold text-dark mb-3">MiniBlog'ga xush kelibsiz!</h1>
                    <p class="text-secondary lead mb-4 fs-6">
                        Ajoyib fikrlaringizni ulashing, boshqalarning postlarini o'qing va hamjamiyat bilan fikr almashing.
                    </p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg px-4 fs-6 rounded-pill">Kirish</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary btn-lg px-4 fs-6 rounded-pill">Ro'yxatdan o'tish</a>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- LOGIN BO'LGAN HOLAT (Grid Layout) -->
    <c:if test="${not empty sessionScope.user}">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold text-dark m-0">
                    <i class="bi bi-grid-fill text-primary me-2"></i>So'nggi qo'shilgan postlar
                </h3>
                <p class="text-muted small mb-0">Platformadagi so'nggi maqola va fikrlar</p>
            </div>
        </div>

        <div class="row g-4">
            <c:forEach var="post" items="${posts}">
                <div class="col-lg-4 col-md-6">
                    <div class="card blog-card h-100 p-4 border-0 shadow-sm d-flex flex-column justify-content-between">
                        <div>
                            <!-- Muallif, Avatar va Sana -->
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="user-avatar shadow-sm">
                                        <c:choose>
                                            <c:when test="${not empty post.username}">
                                                <c:out value="${fn:toUpperCase(fn:substring(post.username, 0, 1))}" />
                                            </c:when>
                                            <c:otherwise>
                                                U
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <span class="fw-semibold text-dark small text-truncate" style="max-width: 120px;">
                                        <c:choose>
                                            <c:when test="${not empty post.username}">
                                                <c:out value="${post.username}" />
                                            </c:when>
                                            <c:otherwise>
                                                Noma'lum
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <!-- Sana -->
                                <small class="text-muted" style="font-size: 0.75rem;">
                                    <i class="bi bi-clock me-1"></i>
                                    <c:out value="${not empty post.createdDate ? fn:replace(post.createdDate, 'T', ' ') : ''}" />
                                </small>
                            </div>

                            <!-- Post Sarlavhasi -->
                            <h5 class="fw-bold text-dark mb-2 text-truncate" title="${post.title}">
                                <c:out value="${post.title}" />
                            </h5>

                            <!-- Matn Preview -->
                            <p class="small post-content-preview mb-3">
                                <c:out value="${post.content}" />
                            </p>
                        </div>

                        <!-- Card Footer -->
                        <div class="pt-3 border-top border-light d-flex justify-content-end align-items-center">
                            <a href="${pageContext.request.contextPath}/post/detail?id=${post.id}"
                               class="btn btn-sm btn-outline-primary btn-read-more px-3">
                                Batafsil <i class="bi bi-arrow-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Post bo'lmagan holat -->
        <c:if test="${empty posts}">
            <div class="card p-5 text-center text-secondary border-0 shadow-sm bg-white" style="border-radius: 20px;">
                <div class="mb-3">
                    <i class="bi bi-inbox text-muted display-4"></i>
                </div>
                <p class="fs-5 mb-0">Hozircha hech qanday post mavjud emas. Birinchi bo'lib post joylang!</p>
            </div>
        </c:if>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>