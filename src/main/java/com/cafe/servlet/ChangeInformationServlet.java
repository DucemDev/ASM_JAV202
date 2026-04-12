package com.cafe.servlet;

import com.cafe.dao.UserDAO;
import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/change-information", "/change-information/save"})
public class ChangeInformationServlet extends HttpServlet {


    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/change-information.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getRequestURI().endsWith("/save")) {

            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");

            // chưa login
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");


            // ===== VALIDATE =====

            if (fullname == null || fullname.trim().isEmpty()) {
                session.setAttribute("message", "Họ tên không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                session.setAttribute("message", "Email không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            // regex email chuẩn
            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                session.setAttribute("message", "Email không đúng định dạng");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            if (phone == null || phone.trim().isEmpty()) {
                session.setAttribute("message", "Số điện thoại không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            // regex phone VN
            if (!phone.matches("^0\\d{9}$")) {
                session.setAttribute("message", "Số điện thoại không hợp lệ!");

                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            // ===== UPDATE =====

            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone(phone);

            try {
                userDAO.updateChangeInformation(user);

                session.setAttribute("messageInfo", "Đổi thông tin thành công!");
                System.out.print("changed");
            } catch (Exception e) {
                session.setAttribute("messageInfo", "Đổi thông tin thất bại!");
                System.out.print("fail change");

            }

            // cập nhật lại session
            session.setAttribute("user", user);

            resp.sendRedirect(req.getContextPath() + "/profile");
        }
    }


}
