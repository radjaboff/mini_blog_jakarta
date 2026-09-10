package dasturlash.uz.mini_blog.servlets.user;

import dasturlash.uz.mini_blog.dto.LoginSuccessDTO; // <-- LoginSuccessDTO import qilindi
import dasturlash.uz.mini_blog.dto.PostCreateDTO;
import dasturlash.uz.mini_blog.dto.PostDTO;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyPostServlet", urlPatterns = "/post/my")
public class MyPostServlet extends HttpServlet {

    private final PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Servlet ichida:
        List<PostDTO> myPosts = postService.getMyPosts(user.id()); // Integer tipida
        req.setAttribute("posts", myPosts);

        req.getRequestDispatcher("/html/user/my_posts.jsp").forward(req, resp);
    }

}