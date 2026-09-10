package dasturlash.uz.mini_blog.security;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Set;

@WebFilter("/*")
public class MyWebFilter implements Filter {

    private static final Set<String> PUBLIC_PATHS = Set.of(
            "/home",
            "/login",
            "/register"
    );

    private static final Set<String> PUBLIC_EXTENSIONS = Set.of(
            ".css", ".js", ".png", ".jpg", ".jpeg", ".svg", ".ico"
    );

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String path = request.getRequestURI().substring(request.getContextPath().length());

        boolean isPublic = PUBLIC_PATHS.contains(path) ||
                PUBLIC_EXTENSIONS.stream().anyMatch(path::endsWith);

        // Session'dan obyektni Object ko'rinishida olamiz (ClassCastException bermaydi)
        HttpSession session = request.getSession(false);
        Object currentUser = (session != null) ? session.getAttribute("user") : null;

        if (isPublic || currentUser != null) {
            chain.doFilter(req, resp);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}