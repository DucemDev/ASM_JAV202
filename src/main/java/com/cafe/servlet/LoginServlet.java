package com.cafe.servlet;

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

    private UserDAO userDAO = new UserDAOImpl();

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

        if ("/verify-otp".equals(path)) {
            String otpInput = req.getParameter("otpCode");
            String otpSession = (String) req.getSession().getAttribute("otpVerify");
            User pendingUser = (User) req.getSession().getAttribute("pendingUser");

            if (otpInput != null && otpInput.equals(otpSession)) {
                req.getSession().setAttribute("user", pendingUser);
                req.getSession().removeAttribute("otpVerify");
                req.getSession().removeAttribute("pendingUser");

                redirectByRole(pendingUser, req, resp);
            } else {
                req.setAttribute("message", "Mã OTP không chính xác!");
                req.getRequestDispatcher("/WEB-INF/public/verify-otp.jsp").forward(req, resp);
            }
            return;
        }

        if ("/logining".equals(path)) {
            Integer failLogin = (Integer) req.getSession().getAttribute("failLogin");
            if (failLogin == null) failLogin = 0;

            if (failLogin >= 5) {
                req.setAttribute("message", "Bạn bị tạm ngưng vì đăng nhập sai quá nhiều lần");
                req.getRequestDispatcher("/WEB-INF/public/fail-login.jsp").forward(req, resp);
                return;
            }

            String username = req.getParameter("emailIp");
            String password = req.getParameter("passwordIp");

            // Kiểm tra rỗng
            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                req.setAttribute("message", "Vui lòng nhập đầy đủ thông tin!");
                req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra định dạng Email (Ưu tiên logic của master)
            if (!username.contains("@gmail.com")) {
                req.setAttribute("message", "Email không đúng cú pháp!");
                req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra ký tự đặc biệt trong Password (Ưu tiên logic của master)
            if (password.contains("#") || password.contains("$") || password.contains("%") || password.contains("^")
                    || password.contains("*") || password.contains("?") || password.contains("{") || password.contains("}")
                    || password.contains("[") || password.contains("]") || password.contains("`") || password.contains("~")
                    || password.contains("|") || password.contains(",") || password.contains(";") || password.contains("!")
                    || password.contains("@") || password.contains("=")) {
                req.setAttribute("message", "Password không được chứa các ký hiệu đặc biệt!");
                req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
                return;
            }

            User user = userDAO.login(username, password);

            if (user != null) {
                req.getSession().setAttribute("user", user);
                req.getSession().removeAttribute("failLogin");

                // Điều hướng theo Role
                redirectByRole(user, req, resp);
            } else {
                failLogin++;
                req.getSession().setAttribute("failLogin", failLogin);
                req.setAttribute("message", "Sai thông tin đăng nhập!");
                req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
            }
        }
    }

    private void redirectByRole(User user, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (user.getRole() == User.ROLE_CUSTOMER) {
            resp.sendRedirect(req.getContextPath() + "/customer");
        } else if (user.getRole() == User.ROLE_STAFF) {
            resp.sendRedirect(req.getContextPath() + "/staff");
        } else if(user.getRole() == User.ROLE_ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/admin");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
