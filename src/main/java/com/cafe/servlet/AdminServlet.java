package com.cafe.servlet;

import java.io.IOException;
import java.util.List;

import com.cafe.dao.DashBoardDAO;
import com.cafe.dao.DashBoardDAOImpl;
import com.cafe.dto.TopDrinkDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    // ✅ CHỈ 1 DAO DUY NHẤT
    private DashBoardDAO dashboardDAO = new DashBoardDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            // ===== PARAM FILTER DATE =====
            String fromDate = req.getParameter("fromDate");
            String toDate = req.getParameter("toDate");

            // ===== THỐNG KÊ =====
            int totalRevenue = dashboardDAO.getTotalRevenue(fromDate, toDate);
            int todayRevenue = dashboardDAO.getTodayRevenue();
            int billCount = dashboardDAO.getBillCount(fromDate, toDate);
            int usingTables = dashboardDAO.getUsingTables();

            req.setAttribute("totalRevenue", totalRevenue);
            req.setAttribute("todayRevenue", todayRevenue);
            req.setAttribute("billCount", billCount);
            req.setAttribute("usingTables", usingTables);


            // ===== TOP DRINK =====
            List<TopDrinkDTO> topDrinks = dashboardDAO.getTop5Drinks();

            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");

            for (int i = 0; i < topDrinks.size(); i++) {
                TopDrinkDTO d = topDrinks.get(i);

                labels.append("'").append(d.getName()).append("'");
                data.append(d.getTotal());

                if (i < topDrinks.size() - 1) {
                    labels.append(",");
                    data.append(",");
                }
            }

            labels.append("]");
            data.append("]");

            req.setAttribute("labels", labels.toString());
            req.setAttribute("data", data.toString());


            // ===== REVENUE CHART =====
            String daysParam = req.getParameter("days");
            int days = 7;

            if (daysParam != null) {
                days = Integer.parseInt(daysParam);
            }

            List<Object[]> revenueList = dashboardDAO.getRevenueByDate(days);

            StringBuilder revenueData = new StringBuilder("[");

            for (int i = 0; i < revenueList.size(); i++) {
                Object[] row = revenueList.get(i);

                revenueData.append("{ x: '")
                        .append(row[0])
                        .append("', y: ")
                        .append(row[1])
                        .append("}");

                if (i < revenueList.size() - 1) {
                    revenueData.append(",");
                }
            }

            revenueData.append("]");

            req.setAttribute("revenueData", revenueData.toString());
            req.setAttribute("days", days);


            // ===== FORWARD =====
            req.getRequestDispatcher("/WEB-INF/admin/admin-page.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}