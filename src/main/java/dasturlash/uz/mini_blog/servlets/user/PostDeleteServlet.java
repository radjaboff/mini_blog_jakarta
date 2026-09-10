package dasturlash.uz.mini_blog.servlets.user;



import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "PostDeleteServlet", urlPatterns = "/post/delete")
public class PostDeleteServlet extends HttpServlet {

    private final PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer postId = Integer.parseInt(req.getParameter("id"));
        postService.deletePost(postId, user.id());

        resp.sendRedirect(req.getContextPath() + "/post/my");
    }
}