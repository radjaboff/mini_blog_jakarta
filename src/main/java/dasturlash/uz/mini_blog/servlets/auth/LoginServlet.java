package dasturlash.uz.mini_blog.servlets.auth;
import dasturlash.uz.mini_blog.dto.LoginDTO;
import dasturlash.uz.mini_blog.dto.LoginSuccessDTO;
import dasturlash.uz.mini_blog.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "LoginServlet" ,urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    private  final AuthService  authService=new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/html/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        LoginDTO loginDTO = new LoginDTO(username, password);
        LoginSuccessDTO login = authService.login(loginDTO);

        if (login != null) {
            req.getSession().setAttribute("user", login);
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            resp.sendError(400, "login error");
        }
    }
}
