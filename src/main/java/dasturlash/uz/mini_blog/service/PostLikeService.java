package dasturlash.uz.mini_blog.service;


import dasturlash.uz.mini_blog.dao.PostLikeDao;
import dasturlash.uz.mini_blog.entity.PostLike;

public class PostLikeService {

    private final PostLikeDao postLikeDao = new PostLikeDao();

    // Like / Unlike mantiqini bajaruvchi asosiy metod
    // Qaytaradi: true (agar like bosilgan bo'lsa), false (agar unlike qilingan bo'lsa)
    private final Object lock = new Object();

    public boolean toggleLike(Integer postId, Integer userId) {
        if (postId == null || userId == null) {
            return false;
        }

        synchronized (lock) {
            boolean exists = postLikeDao.existsByPostIdAndUserId(postId, userId);

            if (exists) {
                postLikeDao.deleteByPostIdAndUserId(postId, userId);
                return false;
            } else {
                PostLike postLike = PostLike.builder()
                        .postId(postId)
                        .userId(userId)
                        .build();
                boolean saved = postLikeDao.save(postLike);
                // Agar saqlash muvaffaqiyatsiz bo'lsa (masalan, parallel so'rov
                // allaqachon qo'shib ulgurgan), haqiqiy holatni qayta tekshiramiz
                return saved || postLikeDao.existsByPostIdAndUserId(postId, userId);
            }
        }
    }

    // Postning umumiy like'lar soni
    public long getLikeCount(Integer postId) {
        return postLikeDao.countByPostId(postId);
    }

    // Joriy foydalanuvchi ushbu postga like bosgan-bosmagani
    public boolean isLikedByUser(Integer postId, Integer userId) {
        return postLikeDao.existsByPostIdAndUserId(postId, userId);
    }
}
