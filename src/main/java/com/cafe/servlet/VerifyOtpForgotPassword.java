package com.cafe.servlet;

import com.cafe.dao.UserDAO;
import com.cafe.dao.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/verify-forgot-password")
public class VerifyOtpForgotPassword extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/verify-forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newPassword = req.getParameter("password");

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        if (newPassword == null || newPassword.isEmpty()) {
            req.setAttribute("message", "Vui lòng nhập mật khẩu mới");
            req.getRequestDispatcher("/WEB-INF/public/verify-forgot-password.jsp").forward(req, resp);
            return;
        }
        UserDAO dao = new UserDAOImpl();
        dao.updatePassword(email, newPassword);
        session.removeAttribute("otp");
        session.setAttribute("success", "Đổi mật khẩu thành công!");
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
