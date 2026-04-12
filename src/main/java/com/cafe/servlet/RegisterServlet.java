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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/public/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Sửa lại name cho đúng với JSP bạn vừa gửi
        String fullName = req.getParameter("fullname"); // Bỏ chữ Ip ở đuôi
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String confirmPass = req.getParameter("confirmPassword");

        // Logic kiểm tra mật khẩu
        if (password != null && !password.equals(confirmPass)) {
            req.setAttribute("message", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("WEB-INF/public/register.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra email tồn tại
        if (userDAO.checkEmailExists(email)) {
            req.setAttribute("message", "Email này đã được sử dụng!");
            req.getRequestDispatcher("WEB-INF/public/register.jsp").forward(req, resp);
            return;
        }

        // Tạo đối tượng User
        User newUser = new User();
        newUser.setFullname(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setPhone(phone);
        newUser.setRole(0); // Khách hàng
        newUser.setActive(true);

        int result = userDAO.create(newUser);

        if (result > 0) {
            // Chuyển hướng về Login nếu thành công
            resp.sendRedirect(req.getContextPath() + "/login?message=success");
        } else {
            req.setAttribute("message", "Có lỗi xảy ra khi lưu dữ liệu!");
            req.getRequestDispatcher("WEB-INF/public/register.jsp").forward(req, resp);
        }
    }
}