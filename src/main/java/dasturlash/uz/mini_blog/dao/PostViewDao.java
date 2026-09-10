package dasturlash.uz.mini_blog.dao;

import dasturlash.uz.mini_blog.entity.PostView;
import jakarta.persistence.EntityManager;

public class PostViewDao extends BaseDao {

    // 1. Yangi ko'rishni saqlash
    public void save(PostView postView) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            em.persist(postView);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close(); // Resursni yopamiz
        }
    }

    // 2. Foydalanuvchi ushbu postni ilgari ko'rganmi-yo'qmi (bazadan, session'dan emas)
    public boolean existsByPostIdAndUserId(Integer postId, Integer userId) {
        if (postId == null || userId == null) return false;
        EntityManager em = entityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(v) FROM PostView v WHERE v.postId = :postId AND v.userId = :userId", Long.class)
                    .setParameter("postId", postId)
                    .setParameter("userId", userId)
                    .getSingleResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 3. Postning umumiy ko'rishlar sonini hisoblash
    public long countByPostId(Integer postId) {
        EntityManager em = entityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(v) FROM PostView v WHERE v.postId = :postId", Long.class)
                    .setParameter("postId", postId)
                    .getSingleResult();
            return count != null ? count : 0L;
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        } finally {
            em.close();
        }
    }
}