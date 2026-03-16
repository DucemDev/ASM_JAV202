package com.cafe.filter;

import java.io.IOException;

import com.cafe.entity.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class FilterLogin implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();


        if (uri.contains("/login") ||
                uri.contains("/logining") ||
                uri.contains("/assets") ||
                uri.contains(".css") ||
                uri.contains(".js") ||
                uri.contains(".png") ||
                uri.contains(".jpg")) {

            chain.doFilter(request, response);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {

            resp.sendRedirect(req.getContextPath() + "/login");

        } else {

            chain.doFilter(request, response);

        }
    }
}