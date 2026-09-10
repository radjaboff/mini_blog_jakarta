package dasturlash.uz.mini_blog.servlets.user;


import dasturlash.uz.mini_blog.dto.PostCreateDTO;
import dasturlash.uz.mini_blog.dto.PostDTO;
import dasturlash.uz.mini_blog.entity.Post;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "PostListServlet", urlPatterns = "/post/list")
public class PostListServlet extends HttpServlet {

    private  final PostService  postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PostDTO> posts = postService.getPosts();
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/html/user/post_list.jsp").forward(req, resp);
    }


}
