<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniBlog - Mening postlarim</title>
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

        /* Tahrirlash va O'chirish icon tugmalari */
        .btn-action-icon {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            text-decoration: none;
            transition: all 0.2s ease;
        }
        .btn-action-icon.edit {
            color: #ffc107;
        }
        .btn-action-icon.edit:hover {
            background-color: #fff8e1;
            border-color: #ffe082;
            color: #ffb300;
        }
        .btn-action-icon.delete {
            color: #dc3545;
        }
        .btn-action-icon.delete:hover {
            background-color: #ffebee;
            border-color: #ffcdd2;
            color: #bd2130;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<!-- Navbarni ulash -->
<jsp:include page="/html/navbar.jsp" />

<div class="container my-5 flex-grow-1">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark m-0">
                <i class="bi bi-grid-fill text-primary me-2"></i>Mening postlarim
            </h3>
            <p class="text-muted small mb-0">Siz tomoningizdan chop etilgan barcha maqola va fikrlar</p>
        </div>
    </div>

    <!-- POSTLAR RO'YXATI (Grid Layout) -->
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

                    <!-- Card Footer: Batafsil + Edit & Delete tugmalari -->
                    <div class="pt-3 border-top border-light d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/post/detail?id=${post.id}"
                           class="btn btn-sm btn-outline-primary btn-read-more px-3">
                            Batafsil <i class="bi bi-arrow-right ms-1"></i>
                        </a>

                        <div class="d-flex align-items-center gap-2">
                            <!-- Tahrirlash tugmasi -->
                            <a href="${pageContext.request.contextPath}/post/update?id=${post.id}"
                               class="btn-action-icon edit"
                               title="Tahrirlash">
                                <i class="bi bi-pencil-fill fs-6"></i>
                            </a>

                            <!-- O'chirish tugmasi -->
                            <a href="${pageContext.request.contextPath}/post/delete?id=${post.id}"
                               class="btn-action-icon delete"
                               title="O'chirish"
                               onclick="return confirm('Haqiqatdan ham ushbu postni o\'chirmoqchimisiz?');">
                                <i class="bi bi-trash-fill fs-6"></i>
                            </a>
                        </div>
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
            <p class="fs-5 mb-0">Sizda hali hech qanday post mavjud emas.</p>
        </div>
    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>