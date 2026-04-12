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
    private static final int PAGE_SIZE = 10;

    private DrinkDAOImpl DAO = new DrinkDAOImpl();
    private CategoryDAOImpl categoryDAO = new CategoryDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, jakarta.servlet.ServletException {
        int page = parsePage(req.getParameter("page"));
        String keyword = req.getParameter("keyword");
        Integer categoryId = parseInteger(req.getParameter("categoryId"));
        Boolean active = parseBooleanFilter(req.getParameter("active"));
        int totalDrinks = DAO.countFiltered(keyword, categoryId, active);
        int totalPages = Math.max(1, (int) Math.ceil((double) totalDrinks / PAGE_SIZE));
        if (page > totalPages) {
            page = totalPages;
        }

        List<Drink> list = DAO.findFilteredPage(page, PAGE_SIZE, keyword, categoryId, active);
        req.setAttribute("drinks", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("filterCategoryId", categoryId);
        req.setAttribute("filterActive", req.getParameter("active"));
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
        int page = parsePage(req.getParameter("page"));

        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }
        if (priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        }

        if (req.getAttribute("errorName") != null || req.getAttribute("errorPrice") != null) {
            loadPageData(req, page);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("openModal", true);

            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp")
                    .forward(req, resp);
            return;
        }

        if (DAO.isNameExists(name)) {
            req.setAttribute("errorName", "Tên đồ uống đã tồn tại!");

            loadPageData(req, page);

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

        resp.sendRedirect(req.getContextPath() + "/manager/drinks?page=" + parsePage(req.getParameter("page")));
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = ParamUtil.getInt(req, "id");
        String name = req.getParameter("name");
        int page = parsePage(req.getParameter("page"));
        List<Category> categories = categoryDAO.findAll();
        req.setAttribute("categories", categories);
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }

        if (req.getParameter("price") == null || req.getParameter("price").trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        }

        if (req.getAttribute("errorName") != null || req.getAttribute("errorPrice") != null) {
            loadPageData(req, page);

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

        resp.sendRedirect(req.getContextPath() + "/manager/drinks?page=" + parsePage(req.getParameter("page")));
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = ParamUtil.getInt(req, "id");

        DAO.delete(id);

        resp.sendRedirect(req.getContextPath() + "/manager/drinks?page=" + parsePage(req.getParameter("page")));
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

    private int parsePage(String pageParam) {
        try {
            int page = Integer.parseInt(pageParam);
            return Math.max(page, 1);
        } catch (Exception e) {
            return 1;
        }
    }

    private void loadPageData(HttpServletRequest req, int page) {
        String keyword = req.getParameter("keyword");
        Integer categoryId = parseInteger(req.getParameter("categoryId"));
        Boolean active = parseBooleanFilter(req.getParameter("active"));
        int totalDrinks = DAO.countFiltered(keyword, categoryId, active);
        int totalPages = Math.max(1, (int) Math.ceil((double) totalDrinks / PAGE_SIZE));
        int currentPage = Math.min(Math.max(page, 1), totalPages);

        req.setAttribute("drinks", DAO.findFilteredPage(currentPage, PAGE_SIZE, keyword, categoryId, active));
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("filterCategoryId", categoryId);
        req.setAttribute("filterActive", req.getParameter("active"));
    }

    private Integer parseInteger(String value) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : null;
        } catch (Exception e) {
            return null;
        }
    }

    private Boolean parseBooleanFilter(String value) {
        if ("true".equalsIgnoreCase(value)) {
            return true;
        }
        if ("false".equalsIgnoreCase(value)) {
            return false;
        }
        return null;
    }
}
