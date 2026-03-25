package com.cafe.servlet;

import com.cafe.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import java.io.IOException;
@WebServlet("/forgotpassword")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("chuyen trang");
        req.getRequestDispatcher("/WEB-INF/public/forgotpassword.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if(email == null || email.isEmpty()) {
            req.setAttribute("message","Vui long nhap day du thong tin");
            req.getRequestDispatcher("/WEB-INF/public/forgotpassword.jsp").forward(req,resp);
            return;
        }
        Random ran=new Random();
        int otp= 1000 + ran.nextInt(9000);

        HttpSession session=req.getSession();
        session.setAttribute("otp",otp);
        session.setAttribute("email",email);
        EmailUtil.sendOTP(email, otp);
        resp.sendRedirect(req.getContextPath() + "/verifyotp");
    }
}
