package com.cafe.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class FilterError implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        try {

            chain.doFilter(request, response);

            // ❗ CHỈ CHECK nếu chưa commit
            if (!resp.isCommitted()) {

                int status = resp.getStatus();

                if (status == 404 || status == 403 || status == 500) {

                    req.setAttribute("errorCode", status);

                    RequestDispatcher rd =
                            req.getRequestDispatcher("/WEB-INF/public/error-page.jsp");

                    rd.forward(req, resp);
                }
            }

        } catch (Exception e) {

            if (!resp.isCommitted()) {

                req.setAttribute("errorCode", 500);

                RequestDispatcher rd =
                        req.getRequestDispatcher("/WEB-INF/public/error-page.jsp");

                rd.forward(req, resp);
            }

        }
    }
}