package dasturlash.uz.mini_blog.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public abstract class BaseDao {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("mini_blog");
    // Har bir thread uchun alohida EntityManager saqlash uchun ThreadLocal
    private static final ThreadLocal<EntityManager> threadLocal = new ThreadLocal<>();

    public EntityManager entityManager() {
        EntityManager em = threadLocal.get();
        if (em == null || !em.isOpen()) {
            em = emf.createEntityManager();
            threadLocal.set(em);
        }
        return em;
    }

    public void begin() {
        EntityManager em = entityManager();
        if (!em.getTransaction().isActive()) {
            em.getTransaction().begin();
        }
    }

    public void commit() {
        EntityManager em = threadLocal.get();
        if (em != null && em.isOpen()) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().commit();
            }
            em.close();
            threadLocal.remove(); // ThreadLocal xotirasini tozalash
        }
    }

    public void rollback() {
        EntityManager em = threadLocal.get();
        if (em != null && em.isOpen() && em.getTransaction().isActive()) {
            em.getTransaction().rollback();
            em.close();
            threadLocal.remove();
        }
    }
}