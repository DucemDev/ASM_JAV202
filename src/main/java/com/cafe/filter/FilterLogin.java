package com.cafe.filter;

import com.cafe.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;


public class FilterLogin implements Filter {

    private static final String[] PUBLIC_PATHS = {
            "/login",
            "/register",
            "/forgotpassword",
            "/verify",
            "/assets"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (isPublic(uri)) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");


        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int role = user.getRole();


        if (role == User.ROLE_ADMIN) {
            // admin được vào tất cả
            chain.doFilter(request, response);
            return;
        }


        if (role == User.ROLE_STAFF) {

            // ❌ không cho vào admin
            if (uri.contains("/admin") || uri.contains("/manager")) {
                resp.sendRedirect(req.getContextPath() + "/seller/tables");
                return;
            }


            chain.doFilter(request, response);
            return;
        }


        if (role == User.ROLE_CUSTOMER) {

            // ❌ không cho vào admin + staff
            if (uri.contains("/admin") ||
                    uri.contains("/manager") ||
                    uri.contains("/seller") ||
                    uri.contains("/staff")) {

                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            chain.doFilter(request, response);
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublic(String uri) {
        for (String path : PUBLIC_PATHS) {
            if (uri.contains(path)) return true;
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