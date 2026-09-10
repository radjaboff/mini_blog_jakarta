package dasturlash.uz.mini_blog.service;

import dasturlash.uz.mini_blog.dao.AuthUserDao;
import dasturlash.uz.mini_blog.dto.LoginDTO;
import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.dto.RegisterDTO;
import dasturlash.uz.mini_blog.entity.AuthUser;
import dasturlash.uz.mini_blog.enums.Role;
import dasturlash.uz.mini_blog.enums.Status;

import java.util.Optional;

public class AuthService {

    AuthUserDao authUserDao=new AuthUserDao();

    public  boolean registration(RegisterDTO registerDTO){
        Optional<AuthUser> byUserName = authUserDao.findByUserName(registerDTO.username());
        if (byUserName.isPresent()) return false;

        AuthUser authUser=AuthUser.builder().fullName(registerDTO.fullName()).username(registerDTO.username()).password(registerDTO.password()).status(Status.ACTIVE).role(Role.USER).build();
        authUserDao.saveUser(authUser);
        return true;
    }


    public LoginSuccessDTO login(LoginDTO loginDTO) {
        Optional<AuthUser> byUserName = authUserDao.findByUserName(loginDTO.username());
        if (byUserName.isEmpty()) return null;
        AuthUser authUser = byUserName.get();
        if (!authUser.getPassword().equals(loginDTO.password())) return null;

        return new   LoginSuccessDTO(authUser.getId(),authUser.getUsername(),authUser.getRole());
    }
}
