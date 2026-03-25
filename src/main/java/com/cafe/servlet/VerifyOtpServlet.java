package com.cafe.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebServlet("/verifyotp")
public class VerifyOtpServlet  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/public/verifyotp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userOtp=req.getParameter("otp");
        HttpSession session=req.getSession();
        int otp=(int) session.getAttribute("otp");
        if(Integer.parseInt(userOtp)==otp){
            resp.sendRedirect(req.getContextPath()+"/changepassword");

        } else {
            req.setAttribute("message", "OTP không đúng");
            req.getRequestDispatcher("/WEB-INF/public/verifyotp.jsp").forward(req, resp);

        }
    }
}
