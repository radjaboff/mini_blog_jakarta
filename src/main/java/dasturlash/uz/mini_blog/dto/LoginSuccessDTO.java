package dasturlash.uz.mini_blog.dto;

import dasturlash.uz.mini_blog.enums.Role;

import java.io.Serializable;

public record LoginSuccessDTO(Integer id,String  username, Role role)  implements Serializable {


    public String getUsername() {
        return username;
    }

}
