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

    UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/public/change-information.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getRequestURI().endsWith("/save")) {

            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                resp.sendRedirect("login");
                return;
            }


            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");

            if (fullname == null || fullname.trim().equals("") || fullname.trim().isEmpty()) {
                session.setAttribute("message", "Họ tên không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }
            if (email == null || email.trim().equals("") || email.trim().isEmpty()) {
                session.setAttribute("message", "Email không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }
            if (!email.endsWith("@gmail.com") || email.endsWith("@yahoo.com")) {
                session.setAttribute("message", "Email không đúng cú pháp");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }
            if (phone == null || phone.trim().equals("") || phone.trim().isEmpty()) {
                session.setAttribute("message", "Số điện thoại không được để trống");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }
            if (phone.length() < 10 || phone.length() > 10 || !phone.startsWith("0")) {
                session.setAttribute("message", "Số điện thoại không đúng cú pháp!");
                resp.sendRedirect(req.getContextPath() + "/change-information");
                return;
            }

            user.setFullname(fullname);
            user.setEmail(email);
            user.setPhone(phone);


            try {
                userDAO.updateChangeInformation(user);
                session.setAttribute("message", "Đổi thông tin thành công!");
                System.out.print("changed");
            } catch (Exception e) {
                session.setAttribute("message", "Đổi thông tin thất bại!");
                System.out.print("fail change");
            }


            session.setAttribute("user", user);

            resp.sendRedirect(req.getContextPath() + "/change-information");

        }
    }
}