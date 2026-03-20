package com.cafe.servlet;

import com.cafe.util.MailHelper;
import com.cafe.dao.UserDAO;
import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/login", "/logining", "/verify-otp"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/verify-otp".equals(path)) {
            if (req.getSession().getAttribute("pendingUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/public/verify-otp.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        UserDAO userDAO = new UserDAOImpl();

        if ("/verify-otp".equals(path)) {
            String otpInput = req.getParameter("otpCode");
            String otpSession = (String) req.getSession().getAttribute("otpVerify");
            User pendingUser = (User) req.getSession().getAttribute("pendingUser");

            if (otpInput != null && otpInput.equals(otpSession)) {
                req.getSession().setAttribute("user", pendingUser);
                req.getSession().removeAttribute("otpVerify");
                req.getSession().removeAttribute("pendingUser");
                resp.sendRedirect(req.getContextPath() + "/home");
            } else {
                req.setAttribute("message", "Mã OTP không chính xác!");
                req.getRequestDispatcher("/WEB-INF/public/verify-otp.jsp").forward(req, resp);
            }
            return;
        }

        String googleLogin = req.getParameter("googleLogin");
        String email = req.getParameter("emailIp");
        String password = req.getParameter("passwordIp");

        if ("true".equals(googleLogin)) {
            User user = userDAO.findByEmail(email);

            if (user != null) {
                String otpCode = String.valueOf((int) ((Math.random() * 899999) + 100000));
                boolean isSent = MailHelper.sendOTP(email, otpCode);
                req.getSession().setAttribute("pendingUser", user);
                req.getSession().setAttribute("otpVerify", otpCode);
                System.out.println(">>> MA OTP MOI: " + otpCode);

                resp.sendRedirect(req.getContextPath() + "/verify-otp");
                return;
            } else {
                req.setAttribute("message", "Email Google chưa có trong hệ thống!");
                req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
                return;
            }
        }
        // 3. LOGIC ĐĂNG NHẬP THƯỜNG (GIỮ NGUYÊN 100%)
        Integer failLogin = (Integer) req.getSession().getAttribute("failLogin");
        if (failLogin == null) {
            failLogin = 1;
        }

        if (failLogin >= 5) {
            req.setAttribute("message", "Bạn bị tạm ngưng login vì đăng nhập sai quá nhiều lần");
            req.getRequestDispatcher("/WEB-INF/public/fail-login.jsp").forward(req, resp);
            return;
        }

        if ((email == null || email.trim().isEmpty()) && (password == null || password.trim().isEmpty())) {
            req.setAttribute("message", "Vui lòng nhập Email và Password!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("message", "Không được để trống Email!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("message", "Không được để trống Password!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.login(email, password);
        if (user != null) {
            req.getSession().setAttribute("user", user);
            req.getSession().removeAttribute("failLogin");
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            failLogin++;
            req.getSession().setAttribute("failLogin", failLogin);
            req.setAttribute("message", "Sai thông tin đăng nhập!");
            req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
        }
    }
}