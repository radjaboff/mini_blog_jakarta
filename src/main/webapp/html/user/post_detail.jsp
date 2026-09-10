<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>${post.title} - MiniBlog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">MiniBlog</a>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">
            <i class="bi bi-arrow-left"></i> Orqaga
        </a>
    </div>
</nav>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">

                    <h1 class="card-title fw-bold text-dark mb-3">${post.title}</h1>

                    <div class="d-flex align-items-center justify-content-between text-muted border-bottom pb-3 mb-4">
                        <div class="d-flex align-items-center">
                            <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 40px; height: 40px; font-weight: bold;">
                                ${post.username.substring(0, 1).toUpperCase()}
                            </div>
                            <div>
                                <h6 class="mb-0 text-dark fw-semibold">${post.username}</h6>
                                <!-- Sanani qisqartirib ko'rsatish -->
                                <small class="text-muted"><i class="bi bi-clock"></i> ${post.createdDate.toString().replace('T', ' ').substring(0, 16)}</small>
                            </div>
                        </div>

                        <!-- Views Counter: post.viewsCount deb to'g'rilandi -->
                        <div class="text-muted">
                            <i class="bi bi-eye-fill me-1"></i>
                            <span class="fw-semibold">${post.viewsCount != null ? post.viewsCount : 0}</span> ko'rishlar
                        </div>
                    </div>

                    <!-- Post Content -->
                    <div class="card-text text-secondary mb-4" style="line-height: 1.8; font-size: 1.1rem; white-space: pre-line;">
                        ${post.content}
                    </div>

                    <!-- Like Section: post.likesCount deb to'g'rilandi -->
                    <div class="border-top pt-3 d-flex align-items-center justify-content-between">
                        <button id="likeBtn" class="btn ${isLiked ? 'btn-danger' : 'btn-outline-danger'} d-flex align-items-center gap-2" onclick="toggleLike(${post.id})">
                            <i id="likeIcon" class="bi ${isLiked ? 'bi-heart-fill' : 'bi-heart'}"></i>
                            <span id="likeCount">${post.likesCount != null ? post.likesCount : 0}</span> Like
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleLike(postId) {
        fetch('${pageContext.request.contextPath}/post/like', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'postId=' + postId
        })
            .then(response => {
                if (response.status === 401) {
                    window.location.href = '${pageContext.request.contextPath}/login';
                    return;
                }
                return response.json();
            })
            .then(data => {
                if (data) {
                    const likeBtn = document.getElementById('likeBtn');
                    const likeIcon = document.getElementById('likeIcon');
                    const likeCount = document.getElementById('likeCount');

                    likeCount.innerText = data.totalLikes;

                    if (data.isLiked) {
                        likeBtn.classList.remove('btn-outline-danger');
                        likeBtn.classList.add('btn-danger');
                        likeIcon.classList.remove('bi-heart');
                        likeIcon.classList.add('bi-heart-fill');
                    } else {
                        likeBtn.classList.remove('btn-danger');
                        likeBtn.classList.add('btn-outline-danger');
                        likeIcon.classList.remove('bi-heart-fill');
                        likeIcon.classList.add('bi-heart');
                    }
                }
            })
            .catch(error => console.error('Xatolik:', error));
    }
</script>

</body>
</html>