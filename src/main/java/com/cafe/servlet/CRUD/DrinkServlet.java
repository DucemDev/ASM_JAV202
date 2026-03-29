package com.cafe.servlet.CRUD;

import com.cafe.dao.DrinkDAOImpl;
import com.cafe.entity.Drink;
import com.cafe.util.ParamUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({"/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit", "/manager/drinks/delete"})
public class DrinkServlet extends HttpServlet {

    private DrinkDAOImpl drinkDAO = new DrinkDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, jakarta.servlet.ServletException {

        List<Drink> list = drinkDAO.findAll();
        req.setAttribute("drinks", list);

        req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String uri = req.getRequestURI();

        if (uri.contains("add")) {
            create(req, resp);
        } else if (uri.contains("edit")) {
            update(req, resp);
        } else if (uri.contains("delete")) {
            delete(req, resp);
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Drink d = getData(req);
        drinkDAO.create(d);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Drink d = getData(req);
        d.setId(ParamUtil.getInt(req, "id"));

        drinkDAO.update(d);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        int id = ParamUtil.getInt(req, "id");
        drinkDAO.delete(id);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private Drink getData(HttpServletRequest req) {

        Drink d = new Drink();

        d.setName(ParamUtil.getString(req, "name"));
        d.setPrice(ParamUtil.getInt(req, "price"));
        d.setImage(ParamUtil.getString(req, "image"));

        d.setCategoryId(1);
        d.setDescription("demo");
        d.setActive(true);

        return d;
    }
}