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
        // 1. Lấy dữ liệu từ form
        String fullName = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String confirmPass = req.getParameter("confirmPassword");

        // 2. Định nghĩa các Regex chuẩn
        // Email: Phải có đuôi @gmail.com
        String emailRegex = "^[a-zA-Z0-9._%+-]+@gmail\\.com$";
        // Phone: Bắt đầu bằng số 0 và đúng 10 chữ số
        String phoneRegex = "^0\\d{9}$";

        // --- VALIDATION LOGIC ---

        // Kiểm tra trống dữ liệu cơ bản
        if (fullName == null || fullName.trim().isEmpty() || email == null || password == null || phone == null) {
            error(req, resp, "Vui lòng nhập đầy đủ thông tin!");
            return;
        }

        // Kiểm tra định dạng Gmail
        if (!email.matches(emailRegex)) {
            error(req, resp, "Email không hợp lệ (ví dụ: example@gmail.com)!");
            return;
        }

        // Kiểm tra định dạng Số điện thoại
        if (!phone.matches(phoneRegex)) {
            error(req, resp, "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số!");
            return;
        }

        // Kiểm tra mật khẩu xác nhận
        if (!password.equals(confirmPass)) {
            error(req, resp, "Mật khẩu xác nhận không khớp!");
            return;
        }

        // --- DATABASE CHECK ---

        // Kiểm tra trùng Email trong DB
        if (userDAO.checkEmailExists(email)) {
            error(req, resp, "Email này đã được sử dụng!");
            return;
        }

        // Kiểm tra trùng Số điện thoại trong DB
        if (userDAO.checkPhoneExists(phone)) {
            error(req, resp, "Số điện thoại này đã được sử dụng!");
            return;
        }

        // --- LƯU DỮ LIỆU ---

        User newUser = new User();
        newUser.setFullname(fullName);
        newUser.setEmail(email);
        newUser.setPassword(password); // Nên mã hóa password nếu có thể
        newUser.setPhone(phone);
        newUser.setRole(0);      // Mặc định là Khách hàng
        newUser.setActive(true); // Mặc định kích hoạt

        int result = userDAO.create(newUser);

        if (result > 0) {
            // Đăng ký thành công, chuyển hướng về trang login kèm thông báo
            resp.sendRedirect(req.getContextPath() + "/login?message=success");
        } else {
            error(req, resp, "Đã có lỗi xảy ra trong quá trình lưu dữ liệu. Thử lại sau!");
        }
    }

    // Hàm hỗ trợ đẩy thông báo lỗi về trang register
    private void error(HttpServletRequest req, HttpServletResponse resp, String msg) throws ServletException, IOException {
        req.setAttribute("message", msg);
        req.getRequestDispatcher("WEB-INF/public/register.jsp").forward(req, resp);
    }
}