package com.cafe.servlet;

import com.cafe.dao.UserDAO;
import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet({"/change-password"})
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/change-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword == null || confirmPassword == null
                || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập đầy đủ thông tin");
            req.getRequestDispatcher("/WEB-INF/public/change-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("message", "Mật khẩu không khớp");
            req.getRequestDispatcher("/WEB-INF/public/change-password.jsp").forward(req, resp);
            return;
        }

        User user = (User) req.getSession().getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        UserDAO dao = new UserDAOImpl();
        dao.updatePassword(user.getEmail(), newPassword);

        user.setPassword(newPassword);
        req.getSession().setAttribute("user", user);

        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}


