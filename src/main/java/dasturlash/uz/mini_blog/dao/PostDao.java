package dasturlash.uz.mini_blog.dao;

import dasturlash.uz.mini_blog.entity.Post;
import jakarta.persistence.EntityManager;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class PostDao extends BaseDao {

    public void createPost(Post post) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            em.persist(post);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close(); // Ish tugagach yopiladi
        }
    }

    public List<Post> getPosts() {
        EntityManager em = entityManager();
        try {
            return em.createQuery("SELECT p FROM Post p ORDER BY p.id DESC", Post.class)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    public List<Post> getMyPosts(Integer userId) {
        EntityManager em = entityManager();
        try {
            return em.createQuery("SELECT p FROM Post p WHERE p.userId = :userId ORDER BY p.id DESC", Post.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    public Optional<Post> findById(Integer id) {
        EntityManager em = entityManager();
        try {
            Post post = em.find(Post.class, id);
            return Optional.ofNullable(post);
        } catch (Exception e) {
            e.printStackTrace();
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public void update(Post post) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            em.merge(post);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void deleteById(Integer id) {
        EntityManager em = entityManager();
        try {
            em.getTransaction().begin();
            Post post = em.find(Post.class, id);
            if (post != null) {
                em.remove(post);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}