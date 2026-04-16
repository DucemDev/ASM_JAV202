package com.cafe.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


public class CharacterEncodingFilter implements Filter {

    private static final String ENCODING = "UTF-8";

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // Set encoding cho request (form submit, parameter)
        request.setCharacterEncoding(ENCODING);

        // Set encoding cho response (trả về browser)
        response.setCharacterEncoding(ENCODING);

        // Set content-type chuẩn UTF-8
        if (response instanceof HttpServletResponse) {
            ((HttpServletResponse) response).setContentType("text/html; charset=UTF-8");
        }

        chain.doFilter(request, response);
    }
}