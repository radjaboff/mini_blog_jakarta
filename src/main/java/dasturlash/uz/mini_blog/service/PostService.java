package dasturlash.uz.mini_blog.service;

import dasturlash.uz.mini_blog.dao.AuthUserDao;
import dasturlash.uz.mini_blog.dao.PostDao;
import dasturlash.uz.mini_blog.dto.PostCreateDTO;
import dasturlash.uz.mini_blog.dto.PostDTO;
import dasturlash.uz.mini_blog.entity.AuthUser;
import dasturlash.uz.mini_blog.entity.Post;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Optional;

public class PostService {

    private final PostDao postDao = new PostDao();
    private final AuthUserDao authUserDao = new AuthUserDao();

    private final PostLikeService postLikeService = new PostLikeService();
    private final PostViewService postViewService = new PostViewService();

    public void createPost(PostCreateDTO postCreateDTO) {
        Post post = new Post();
        post.setTitle(postCreateDTO.title());
        post.setContent(postCreateDTO.content());
        post.setUserId(postCreateDTO.userId());
        postDao.createPost(post);
    }

    public List<PostDTO> getPosts() {
        return postDao.getPosts().stream()
                .map(this::toDTO)
                .toList();
    }

    public List<PostDTO> getMyPosts(Integer userId) {
        if (userId == null) {
            return List.of();
        }
        return postDao.getMyPosts(userId).stream()
                .map(this::toDTO)
                .toList();
    }

    // 1. Oddiy olish (Views oshmaydi)
    public PostDTO getPostById(Integer postId) {
        if (postId == null) {
            return null;
        }
        Optional<Post> postOptional = postDao.findById(postId);
        return postOptional.map(this::toDTO).orElse(null);
    }

    // 2. Detail sahifasi uchun: Session orqali 1 marta oshirib postni qaytaradi
    public PostDTO getPostDetail(Integer postId, Integer currentUserId, HttpSession session) {
        if (postId == null) {
            return null;
        }

        // Ko'rishni oshiramiz
        postViewService.incrementViewOnce(postId, currentUserId, session);

        // Postni DTO shaklida qaytaramiz
        return getPostById(postId);
    }



    // Joriy foydalanuvchi ushbu postga like bosganmi-yo'qmi
    public boolean isLikedByUser(Integer postId, Integer currentUserId) {
        if (postId == null || currentUserId == null) {
            return false;
        }
        return postLikeService.isLikedByUser(postId, currentUserId);
    }


    public List<PostDTO> getPostsByUserId(Integer userId) {
        return postDao.getPosts().stream()
                .filter(post -> post.getUserId() != null && post.getUserId().equals(userId))
                .map(this::toDTO)
                .toList();
    }

    public boolean updatePost(Integer postId, String title, String content, Integer currentUserId) {
        Optional<Post> optionalPost = postDao.findById(postId);
        if (optionalPost.isPresent()) {
            Post post = optionalPost.get();

            if (post.getUserId() != null && post.getUserId().equals(currentUserId)) {
                post.setTitle(title);
                post.setContent(content);

                postDao.update(post);
                return true;
            }
        }
        return false;
    }

    public boolean deletePost(Integer postId, Integer currentUserId) {
        Optional<Post> optionalPost = postDao.findById(postId);
        if (optionalPost.isPresent()) {
            Post post = optionalPost.get();
            if (post.getUserId() != null && post.getUserId().equals(currentUserId)) {
                postDao.deleteById(postId);
                return true;
            }
        }
        return false;
    }

    public PostDTO toDTO(Post post) {
        String username = "Noma'lum";

        if (post.getUserId() != null) {
            Optional<AuthUser> user = authUserDao.findById(post.getUserId());
            if (user.isPresent() && user.get().getUsername() != null) {
                username = user.get().getUsername();
            }
        }

        long likesCount = postLikeService.getLikeCount(post.getId());
        long viewsCount = postViewService.getViewsCount(post.getId());

        return new PostDTO(
                post.getId(),
                post.getTitle(),
                post.getContent(),
                post.getUserId(),
                username,
                post.getCreatedDate(),
                (int) likesCount,
                (int) viewsCount
        );
    }
}