package com.cafe.servlet.CRUD;

import com.cafe.dao.CategoryDAOImpl;
import com.cafe.dao.DrinkDAOImpl;
import com.cafe.entity.Category;
import com.cafe.entity.Drink;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.util.List;
@MultipartConfig
@WebServlet({"/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit", "/manager/drinks/delete"})
public class DrinkServlet extends HttpServlet {

    private DrinkDAOImpl DAO = new DrinkDAOImpl();
    private CategoryDAOImpl categoryDAO = new CategoryDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, jakarta.servlet.ServletException {

        List<Drink> list = DAO.findAll();
        req.setAttribute("drinks", list);
        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
    }

    @Override

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String uri = req.getRequestURI();

        if (uri.contains("add")) {
            create(req, resp);
        } else if (uri.contains("edit")) {
            update(req, resp);
        } else if (uri.contains("delete")) {
            delete(req, resp);
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));

        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }
        if (priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        }

        if (req.getAttribute("errorName") != null || req.getAttribute("errorPrice") != null) {
            List<Drink> list = DAO.findAll();
            req.setAttribute("drinks", list);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("openModal", true);

            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp")
                    .forward(req, resp);
            return;
        }

        if (DAO.isNameExists(name)) {
            req.setAttribute("errorName", "Tên đồ uống đã tồn tại!");

            List<Drink> list = DAO.findAll();
            req.setAttribute("drinks", list);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("openModal", true);
            req.setAttribute("oldCategory", ParamUtil.getInt(req, "categoryId"));
            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp")
                    .forward(req, resp);
            return;
        }

        Drink d = getData(req);
        DAO.create(d);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = ParamUtil.getInt(req, "id");
        String name = req.getParameter("name");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));
        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }

        if (req.getParameter("price") == null || req.getParameter("price").trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        }

        if (req.getAttribute("errorName") != null || req.getAttribute("errorPrice") != null) {
            List<Drink> list = DAO.findAll();
            req.setAttribute("drinks", list);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", req.getParameter("price"));
            req.setAttribute("openModal", true);
            req.setAttribute("oldCategory", ParamUtil.getInt(req, "categoryId"));
            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp")
                    .forward(req, resp);
            return;
        }

        Drink d = getData(req);
        d.setId(id);

        DAO.update(d);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = ParamUtil.getInt(req, "id");

        DAO.delete(id);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks");
    }

    private Drink getData(HttpServletRequest req) {

        Drink d = new Drink();

        try {
            Part filePart = req.getPart("image");
            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {

                String newFileName = System.currentTimeMillis() + "_" + fileName;

                String uploadPath = getServletContext().getRealPath("/assets/image");

                File dir = new File(uploadPath);
                if (!dir.exists()) dir.mkdirs();

                filePart.write(uploadPath + File.separator + newFileName);

                d.setImage("assets/image/" + newFileName);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        d.setName(ParamUtil.getString(req, "name"));
        d.setPrice(ParamUtil.getInt(req, "price"));


        d.setCategoryId(ParamUtil.getInt(req, "categoryId"));
        d.setDescription("demo");
        d.setActive(true);

        return d;
    }
}