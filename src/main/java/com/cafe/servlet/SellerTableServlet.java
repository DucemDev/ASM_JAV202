package com.cafe.servlet;

import com.cafe.dao.TableDAO;
import com.cafe.dao.TableDAOImpl;
import com.cafe.entity.Table;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({"/seller/tables", "/seller/tables/add"})
public class SellerTableServlet extends HttpServlet {

    TableDAO tableDAO = new TableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Table> list = tableDAO.findAll();

        req.setAttribute("tables", list);

        req.getRequestDispatcher("/WEB-INF/public/seller/table.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String uri = req.getRequestURI();

        if (uri.contains("add")) {

            Table t = new Table();
            t.setName(req.getParameter("name"));
            t.setStatus("empty");
            t.setActive(true);

            tableDAO.create(t);
        }

        resp.sendRedirect(req.getContextPath() + "/seller/tables");
    }
}