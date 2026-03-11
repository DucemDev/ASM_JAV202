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
        String uri = req.getRequestURI();

        Integer failLogin = (Integer) req.getSession().getAttribute("failLogin");

        if (failLogin == null) {
            failLogin = 0;
        }
        if (uri.endsWith("/logining")) {
            String password = req.getParameter("passwordIp");
            String username = req.getParameter("emailIp");
            UserDAO userDAO = new UserDAOImpl();
            User user = userDAO.login(username, password);
            if (user != null) {
                req.getSession().setAttribute("user", user);
               if(user.isRole()){

                   resp.sendRedirect(req.getContextPath()+"/admin");
//                   System.out.println(req.getSession().getAttribute("user",));
               }else{
                resp.sendRedirect(req.getContextPath()+"/staff");
               }
            }else{
                resp.sendRedirect(req.getContextPath()+"/login");
                failLogin++;
                req.getSession().setAttribute("failLogin", failLogin);
                System.out.println("Số lần đăng nhập sai: "+failLogin+"/5");
            }

            if (failLogin==5){

            }
        }
    }
}
