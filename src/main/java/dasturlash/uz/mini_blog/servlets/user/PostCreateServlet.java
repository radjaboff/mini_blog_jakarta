package dasturlash.uz.mini_blog.servlets.user;

import dasturlash.uz.mini_blog.dto.LoginSuccessDTO; // <-- LoginSuccessDTO import qilindi
import dasturlash.uz.mini_blog.dto.PostCreateDTO;
import dasturlash.uz.mini_blog.service.PostService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "PostCreateServlet", urlPatterns = "/post/create")
public class PostCreateServlet extends HttpServlet {

    private final PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/html/user/post_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        LoginSuccessDTO user = (LoginSuccessDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String title = req.getParameter("title");
        String content = req.getParameter("content");

        // DTO ga title, content va session'dagi user.getId() uzatiladi
        PostCreateDTO dto = new PostCreateDTO(title, content, user.id());
        postService.createPost(dto);

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}