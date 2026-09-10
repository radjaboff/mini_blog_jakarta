package dasturlash.uz.mini_blog.servlets.user;

import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.service.PostLikeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "PostLikeServlet", urlPatterns = "/post/like")
public class PostLikeServlet extends HttpServlet {

    private final PostLikeService likeService = new PostLikeService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        Integer postId;
        try {
            postId = Integer.parseInt(req.getParameter("postId"));
        } catch (NumberFormatException e) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        boolean isLiked = likeService.toggleLike(postId, user.id());
        long totalLikes = likeService.getLikeCount(postId);

        resp.setContentType("application/json");
        resp.getWriter().write(String.format("{\"isLiked\": %b, \"totalLikes\": %d}", isLiked, totalLikes));
    }
}
