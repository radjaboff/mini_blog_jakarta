<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MiniBlog - Barcha postlar</title>
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Style CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        /* Modern Card Styling */
        .blog-card {
            border-radius: 20px;
            background: #ffffff;
            transition: transform 0.25s cubic-bezier(0.165, 0.84, 0.44, 1), box-shadow 0.25s ease;
        }
        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08) !important;
        }

        /* Dynamic Avatar Style */
        .user-avatar {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            color: #ffffff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.85rem;
        }

        /* 3-Line Text Truncation */
        .post-content-preview {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            word-break: break-word;
            line-height: 1.5;
            color: #6c757d;
        }

        .btn-read-more {
            border-radius: 50rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<!-- Navbar -->
<jsp:include page="/html/navbar.jsp" />

<div class="container-fluid px-4 my-5 flex-grow-1">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark m-0">
                <i class="bi bi-grid-fill text-primary me-2"></i>Barcha postlar
            </h3>
            <p class="text-muted small mb-0">Platformadagi barcha so'nggi maqola va fikrlar</p>
        </div>
    </div>

    <!-- Empty State -->
    <c:if test="${empty posts}">
        <div class="card p-5 text-center border-0 shadow-sm bg-white" style="border-radius: 20px;">
            <div class="mb-3">
                <i class="bi bi-inbox text-muted display-4"></i>
            </div>
            <p class="text-secondary fs-5 mb-0">Hozircha hech qanday post mavjud emas.</p>
        </div>
    </c:if>

    <!-- Post Cards Grid -->
    <div class="row g-4">
        <c:forEach items="${posts}" var="post">
            <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card blog-card h-100 p-3 shadow-sm border-0 d-flex flex-column justify-content-between">
                    <div>
                        <!-- Author & Date Header -->
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
                                <span class="fw-semibold text-dark small text-truncate" style="max-width: 110px;">
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

                            <!-- Date Format -->
                            <small class="text-muted" style="font-size: 0.75rem;">
                                <i class="bi bi-clock me-1"></i>
                                <c:out value="${not empty post.createdDate ? fn:replace(post.createdDate, 'T', ' ') : ''}" />
                            </small>
                        </div>

                        <!-- Post Title -->
                        <h6 class="fw-bold text-dark text-truncate mb-2" title="${post.title}">
                            <c:out value="${post.title}" />
                        </h6>

                        <!-- Post Preview Content -->
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>