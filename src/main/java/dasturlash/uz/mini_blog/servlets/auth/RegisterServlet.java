package dasturlash.uz.mini_blog.servlets.auth;

import dasturlash.uz.mini_blog.dto.RegisterDTO;
import dasturlash.uz.mini_blog.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterServlet" ,urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {


    private  final AuthService authService=new AuthService();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/html/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        RegisterDTO registerDTO=new RegisterDTO(fullName, username, password);
        boolean registration = authService.registration(registerDTO);
        if(registration){
            resp.sendRedirect("/login");
        }else {
            resp.sendError(400,"username or password is incorrect");
        }



    }
}
