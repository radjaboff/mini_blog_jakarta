package dasturlash.uz.mini_blog.service;

import dasturlash.uz.mini_blog.dao.PostViewDao;
import dasturlash.uz.mini_blog.entity.PostView;
import jakarta.servlet.http.HttpSession;

public class PostViewService {

    private final PostViewDao postViewDao = new PostViewDao();

    // Har bir foydalanuvchidan (yoki mehmondan) 1 marta oshirish
    public long incrementViewOnce(Integer postId, Integer userId, HttpSession session) {
        if (postId == null) return 0;

        boolean alreadyViewed;
        String sessionKey = "viewed_post_" + postId;

        if (userId != null) {
            // Login qilgan foydalanuvchi: bazadan tekshiramiz,
            // shunda logout/login qilinsa ham son noto'g'ri oshib ketmaydi
            alreadyViewed = postViewDao.existsByPostIdAndUserId(postId, userId);
        } else {
            // Mehmon (anonim) foydalanuvchi: faqat session orqali tekshiramiz
            alreadyViewed = session != null && session.getAttribute(sessionKey) != null;
        }

        if (!alreadyViewed) {
            PostView postView = PostView.builder()
                    .postId(postId)
                    .userId(userId)
                    .build();

            postViewDao.save(postView);
            if (session != null) {
                session.setAttribute(sessionKey, true);
            }
        }

        return postViewDao.countByPostId(postId);
    }

    // Faqat ko'rishlar sonini olish (Increment qilmaydi)
    public long getViewsCount(Integer postId) {
        if (postId == null) return 0;
        return postViewDao.countByPostId(postId);
    }
}