package dasturlash.uz.mini_blog.servlets.user;



import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.dto.PostDTO;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "PostUpdateServlet", urlPatterns = "/post/update")
public class PostUpdateServlet extends HttpServlet {

    private final PostService postService = new PostService();

    // Tahrirlash formasini ochish
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer postId = Integer.parseInt(req.getParameter("id"));
        PostDTO post = postService.getPostById(postId);

        // Faqat o'zining postini tahrirlashga ruxsat beramiz
        if (post != null && post.userId().equals(user.id() )) {
            req.setAttribute("post", post);
            req.getRequestDispatcher("/html/user/post_update.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/post/my");
        }
    }

    // Tahrirlangan ma'lumotlarni saqlash
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Integer postId = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        postService.updatePost(postId, title, content, user.id());

        resp.sendRedirect(req.getContextPath() + "/post/my");
    }
}