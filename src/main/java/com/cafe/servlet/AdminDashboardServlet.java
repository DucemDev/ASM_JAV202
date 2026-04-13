package com.cafe.servlet;

import com.cafe.dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            DashboardDAO dao = new DashboardDAO();

            String from = request.getParameter("fromDate");
            String to = request.getParameter("toDate");

            int totalRevenue = dao.getTotalRevenue(from, to);
            int todayRevenue = dao.getTodayRevenue();
            int billCount = dao.getBillCount(from, to);
            int usingTables = dao.getUsingTables();

            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("todayRevenue", todayRevenue);
            request.setAttribute("billCount", billCount);
            request.setAttribute("usingTables", usingTables);

            request.getRequestDispatcher("/WEB-INF/admin/admin-page.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
