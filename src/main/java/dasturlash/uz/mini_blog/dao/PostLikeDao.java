package dasturlash.uz.mini_blog.dao;

import dasturlash.uz.mini_blog.entity.PostLike;
import jakarta.persistence.EntityManager;

public class PostLikeDao extends BaseDao {

    // 1. Foydalanuvchi ushbu postga like bosgan-bosmaganini tekshirish
    public boolean existsByPostIdAndUserId(Integer postId, Integer userId) {
        if (userId == null || postId == null) return false;
        EntityManager em = entityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(l) FROM PostLike l WHERE l.postId = :postId AND l.userId = :userId", Long.class)
                    .setParameter("postId", postId)
                    .setParameter("userId", userId)
                    .getSingleResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 2. Yangi Like saqlash
    // 2. Yangi Like saqlash
    public boolean save(PostLike postLike) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            em.persist(postLike);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 3. Like'ni o'chirish (Unlike)
    public boolean deleteByPostIdAndUserId(Integer postId, Integer userId) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            int deleted = em.createQuery("DELETE FROM PostLike l WHERE l.postId = :postId AND l.userId = :userId")
                    .setParameter("postId", postId)
                    .setParameter("userId", userId)
                    .executeUpdate();
            em.getTransaction().commit();
            return deleted > 0;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    // 4. Postning umumiy like'lar sonini hisoblash
    public long countByPostId(Integer postId) {
        EntityManager em = entityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(l) FROM PostLike l WHERE l.postId = :postId", Long.class)
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