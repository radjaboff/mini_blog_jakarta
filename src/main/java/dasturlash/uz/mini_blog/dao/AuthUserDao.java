package dasturlash.uz.mini_blog.dao;

import dasturlash.uz.mini_blog.entity.AuthUser;

import java.util.List;
import java.util.Optional;

public class AuthUserDao extends BaseDao {

    public void saveUser(AuthUser authUser) {
        try {
            begin();
            entityManager().persist(authUser);
            commit();
        } catch (Exception e) {
            rollback();
            e.printStackTrace();
        }
    }

    public Optional<AuthUser> findById(Integer id) {
        try {
            begin();
            AuthUser authUser = entityManager().find(AuthUser.class, id);
            commit();
            return Optional.ofNullable(authUser);
        } catch (Exception e) {
            rollback();
            e.printStackTrace();
            return Optional.empty();
        }
    }

    public Optional<AuthUser> findByUserName(String username) {
        try {
            begin();
            List<AuthUser> authUser = entityManager()
                    .createQuery("from AuthUser a where a.username = ?1", AuthUser.class)
                    .setParameter(1, username)
                    .getResultList();
            commit();

            if (authUser.isEmpty()) return Optional.empty();
            return Optional.of(authUser.get(0));
        } catch (Exception e) {
            rollback();
            e.printStackTrace();
            return Optional.empty();
        }
    }
}