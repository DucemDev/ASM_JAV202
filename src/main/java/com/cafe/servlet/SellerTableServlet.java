package com.cafe.servlet;

import com.cafe.dao.TableDAO;
import com.cafe.dao.TableDAOImpl;
import com.cafe.entity.Table;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/seller/tables",
        "/seller/tables/add",
        "/seller/tables/hide",
        "/seller/tables/show"
})
public class SellerTableServlet extends HttpServlet {

    private TableDAO tableDAO = new TableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String status = req.getParameter("status");
            String keyword = req.getParameter("keyword");

            List<Table> list = tableDAO.search(status, keyword);

            req.setAttribute("tables", list);
            req.setAttribute("currentStatus", status);
            req.setAttribute("keyword", keyword);

            req.getRequestDispatcher("/WEB-INF/public/seller/table.jsp")
                    .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/seller/tables");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            String uri = req.getRequestURI();

            // ===== ADD =====
            if (uri.contains("/add")) {

                String name = req.getParameter("name");

                if (name != null && !name.trim().isEmpty()) {

                    // check duplicate
                    if (tableDAO.existsByName(name.trim())) {
                        resp.sendRedirect(req.getContextPath() + "/seller/tables?error=duplicate");
                        return;
                    }

                    Table t = new Table();
                    t.setName(name.trim());
                    t.setStatus("empty");

                    tableDAO.create(t);
                }
            }

            // ===== HIDE =====
            else if (uri.contains("/hide")) {

                String idParam = req.getParameter("id");
                String status = req.getParameter("status");

                if (idParam != null && status != null) {

                    int id = Integer.parseInt(idParam);

                    // 🔥 chỉ cho ẩn khi bàn trống
                    if ("empty".equalsIgnoreCase(status)) {
                        tableDAO.hide(id);
                    }
                }
            }


            // ===== SHOW =====
            else if (uri.contains("/show")) {

                String idParam = req.getParameter("id");

                if (idParam != null) {
                    int id = Integer.parseInt(idParam);
                    tableDAO.show(id);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/seller/tables");
    }
}