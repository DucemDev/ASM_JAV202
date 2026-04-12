package com.cafe.servlet;

import com.cafe.dao.UserDAO;
import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import com.cafe.util.MailHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("emailIp");

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("message", "Email Google không được để trống!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.findByEmail(email);

        if (user != null) {
            String otpCode = String.valueOf((int) ((Math.random() * 899999) + 100000));
            MailHelper.sendOTP(email, otpCode);

            req.getSession().setAttribute("pendingUser", user);
            req.getSession().setAttribute("otpVerify", otpCode);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("message", "Bạn chưa có tài khoản, vui lòng đăng ký tài khoản!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
        }
    }
}