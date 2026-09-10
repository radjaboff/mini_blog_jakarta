<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark py-3 sticky-top shadow-sm">
    <div class="container">
        <!-- Logotip -->
        <a class="navbar-brand d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-journal-text text-primary fs-3"></i>
            <span class="brand-logo">MiniBlog</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <!-- Chap tomondagi menyu (Faqat Login bo'lganlarga ko'rinadi) -->
            <ul class="navbar-nav me-auto ms-lg-4">
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item">
                        <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/post/list">Barcha postlar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white-50" href="${pageContext.request.contextPath}/post/my">Mening postlarim</a>
                    </li>
                </c:if>
            </ul>

            <!-- O'ng tomondagi profil (Faqat Login bo'lganda chiqadi) -->
            <div class="d-flex align-items-center gap-3">
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/post/create" class="btn btn-primary btn-sm rounded-pill px-3 shadow me-2">
                        <i class="bi bi-plus-circle me-1"></i> Post yaratish
                    </a>
                    <span class="text-white fw-semibold">
                        <i class="bi bi-person-circle text-info me-1"></i> ${sessionScope.user.username}
                    </span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm rounded-pill px-3">Chiqish</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>