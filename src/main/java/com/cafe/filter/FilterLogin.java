package com.cafe.filter;

import com.cafe.entity.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class FilterLogin implements Filter {
    private static final String[] PUBLIC_PATHS = {
            "/login",
            "/logining",
            "/register",
            "/forgotpassword",
            "/verify-forgot-password",
            "/changing-password",
            "/verifyotp",
            "/verify-otp",
            "/login-google",
            "/assets"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (isPublicResource(uri)) {

            chain.doFilter(request, response);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {

            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ⭐ kiểm tra quyền admin
        if ((uri.contains("/admin") || uri.contains("/manager")) && user.getRole() != User.ROLE_ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        if ((uri.contains("/staff") || uri.contains("/seller") || uri.contains("/employee"))
                && user.getRole() == User.ROLE_CUSTOMER) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicResource(String uri) {
        for (String publicPath : PUBLIC_PATHS) {
            if (uri.contains(publicPath)) {
                return true;
            }
        }

        return uri.endsWith(".css")
                || uri.endsWith(".js")
                || uri.endsWith(".png")
                || uri.endsWith(".jpg")
                || uri.endsWith(".jpeg")
                || uri.endsWith(".gif")
                || uri.endsWith(".svg")
                || uri.endsWith(".ico");
    }
}
