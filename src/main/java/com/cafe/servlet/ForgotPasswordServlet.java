package com.cafe.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/forgetpassword.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        if(email.isEmpty()) {
            req.setAttribute("message","Vui long nhap day du thong tin");
            req.getRequestDispatcher("/WEB-INF/public/forgetpassword.jsp");
            return;
        }
        Random ran=new Random();
        int otp= 1000 + ran.nextInt(9000);

        HttpSession session=req.getSession();
        session.setAttribute("otp",otp);
        session.setAttribute("email",email);
        System.out.println("OTP đã guửi tới email"+otp);
        resp.sendRedirect(req.getContextPath() + "/verifyotp");
    }
}
