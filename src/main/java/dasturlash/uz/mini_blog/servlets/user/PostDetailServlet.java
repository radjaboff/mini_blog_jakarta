package dasturlash.uz.mini_blog.servlets.user;

import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.dto.PostDTO;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "PostDetailServlet", urlPatterns = "/post/detail")
public class PostDetailServlet extends HttpServlet {

    private final PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestURI = req.getRequestURI();

        if (requestURI.endsWith("favicon.ico")) {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isBlank()) {
            Integer postId = Integer.parseInt(idParam);

            HttpSession session = req.getSession(true);
            LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");
            Integer currentUserId = (user != null) ? user.id() : null;

            PostDTO post = postService.getPostDetail(postId, currentUserId, session);

            if (post != null) {
                boolean isLiked = postService.isLikedByUser(postId, currentUserId);

                req.setAttribute("post", post);
                req.setAttribute("isLiked", isLiked);
                req.getRequestDispatcher("/html/user/post_detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}