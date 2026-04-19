package com.cafe.filter;

import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import com.cafe.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class OnlineOrderBadgeFilter implements Filter {

    private final BillDAO billDAO = new BillDAOImpl();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        if (session != null) {
            Object u = session.getAttribute("user");
            if (u instanceof User user) {
                int role = user.getRole();
                if (role == 1 || role == 2) {
                    boolean hasPendingOnlineOrders = !billDAO.findPendingOnlineOrders().isEmpty();
                    req.setAttribute("hasPendingOnlineOrders", hasPendingOnlineOrders);
                }
            }
        }

        chain.doFilter(request, response);
    }
}