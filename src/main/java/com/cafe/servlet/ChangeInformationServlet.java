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

@WebServlet({"/change-information", "changing"})
public class ChangeInformationServlet extends HttpServlet {
    UserDAO userDAO = new UserDAOImpl();
    User user = userDAO.login("", "");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getRequestURI().endsWith("change-information")) {
            req.getRequestDispatcher("/WEB-INF/public/change-information.jsp").forward(req, resp);
        } else {
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (verifyBeforeChange()==true) {
            changeInformation();
        }else {

        }
    }

    void changeInformation() {

    }

    boolean verifyBeforeChange() {
        if (user != null) {
            return true;
        } else {
            return false;
        }
    }
}
