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

@WebServlet({"/login", "/logining"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/public/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("emailIp");
        String password = req.getParameter("passwordIp");

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
        UserDAO userDAO = new UserDAOImpl();
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
            System.out.println("Số lần đăng nhập sai: " + failLogin + "/5");
        }
    }


}



