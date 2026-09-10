<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Postni Tahrirlash - MiniBlog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f6f9;
        }
        .custom-navbar {
            background-color: #1a1c2e;
        }
        .form-card {
            border: none;
            border-radius: 16px;
        }
        .form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.25rem rgba(37, 99, 235, 0.15);
        }
    </style>
</head>
<body>

<!-- Modern Dark Navbar -->
<nav class="navbar navbar-expand-lg custom-navbar text-white py-3">
    <div class="container">
        <a class="navbar-brand text-white fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-grid-1x2-fill text-primary"></i> MiniBlog
        </a>

        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/home" class="nav-link text-white-50">Barcha postlar</a>
            <a href="${pageContext.request.contextPath}/post/my" class="nav-link text-white-50">Mening postlarim</a>
        </div>

        <div class="d-flex align-items-center gap-2">
            <c:if test="${not empty sessionScope.user}">
                <div class="dropdown">
                    <button class="btn btn-outline-light btn-sm rounded-pill dropdown-toggle" type="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.username}
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Chiqish</a></li>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>
</nav>

<!-- Form Container -->
<div class="container my-5" style="max-width: 750px;">
    <div class="card form-card shadow-sm p-4">
        <div class="card-body">

            <div class="d-flex align-items-center gap-2 mb-4">
                <div class="bg-warning text-dark p-2 rounded-circle d-flex align-items-center justify-content-center" style="width: 42px; height: 42px;">
                    <i class="bi bi-pencil-fill fs-5"></i>
                </div>
                <div>
                    <h4 class="fw-bold mb-0 text-dark">Postni tahrirlash</h4>
                    <small class="text-secondary">Maqolangiz sarlavhasi va mazmunini o'zgartirishingiz mumkin</small>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/post/update" method="post">
                <!-- Post ID yashirin ravishda yuboriladi -->
                <input type="hidden" name="id" value="${post.id()}">

                <div class="mb-4">
                    <label for="title" class="form-label fw-semibold text-dark">Sarlavha</label>
                    <input type="text"
                           class="form-control form-control-lg fs-6 rounded-3"
                           id="title"
                           name="title"
                           value="${post.title()}"
                           placeholder="Post sarlavhasini kiriting"
                           required>
                </div>

                <div class="mb-4">
                    <label for="content" class="form-label fw-semibold text-dark">Maqola matni</label>
                    <textarea class="form-control rounded-3"
                              id="content"
                              name="content"
                              rows="8"
                              placeholder="Fikrlaringizni bu yerga yozing..."
                              required>${post.content()}</textarea>
                </div>

                <div class="d-flex align-items-center justify-content-end gap-2 border-top pt-3">
                    <a href="${pageContext.request.contextPath}/post/my" class="btn btn-light rounded-pill px-4 text-secondary">
                        Bekor qilish
                    </a>
                    <button type="submit" class="btn btn-warning rounded-pill px-4 text-dark fw-semibold">
                        <i class="bi bi-check-circle-fill me-1"></i> Saqlash
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>