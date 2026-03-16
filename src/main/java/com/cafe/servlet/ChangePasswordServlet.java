package com.cafe.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/changepassword.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String email = (String ) session.getAttribute("email");
        if(email == null){
            resp.sendRedirect(req.getContextPath()+"//WEB-INF/public/login.jsp");
            return;

        }
        String password=req.getParameter("password");
        String confirm = req.getParameter("confirm");
        if(password == null || password.isEmpty() || confirm == null || confirm.isEmpty()){
            req.setAttribute("message", "Vui lòng nhập đủ thông tin");
            req.getRequestDispatcher("/WEB-INF/public/changepassword.jsp").forward(req, resp);
            return;
        }
        if(!password.equals(confirm)){
            req.setAttribute("message","Mật khẩu không khớp");
            req.getRequestDispatcher("/WEB-INF/public/changepassword.jsp").forward(req, resp);
            return;

        }
        req.setAttribute("message", "Đổi mật khẩu thành công");
        req.getRequestDispatcher("/WEB-INF/public/changepassword.jsp").forward(req, resp);
    }
}
