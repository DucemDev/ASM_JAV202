package com.cafe.servlet;

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
@WebServlet({"/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit"})
public class DrinkServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    private DrinkDAOImpl DAO = new DrinkDAOImpl();
    private CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

    // ========================= GET =========================
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int page = parsePage(req.getParameter("page"));
        String keyword = req.getParameter("keyword");
        Integer categoryId = parseInteger(req.getParameter("categoryId"));
        Boolean active = parseBooleanFilter(req.getParameter("active"));

        int totalDrinks = DAO.countFiltered(keyword, categoryId, active);
        int totalPages = Math.max(1, (int) Math.ceil((double) totalDrinks / PAGE_SIZE));

        if (page > totalPages) page = totalPages;

        List<Drink> list = DAO.findFilteredPage(page, PAGE_SIZE, keyword, categoryId, active);

        req.setAttribute("drinks", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("filterCategoryId", categoryId);
        req.setAttribute("filterActive", req.getParameter("active"));

        req.setAttribute("categories", categoryDAO.findAll());

        req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
    }

    // ========================= POST =========================
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String uri = req.getRequestURI();

        if (uri.contains("add")) {
            create(req, resp);
        } else if (uri.contains("edit")) {
            update(req, resp);
        }
    }

    // ========================= CREATE =========================
    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        int categoryId = ParamUtil.getInt(req, "categoryId");

        int page = parsePage(req.getParameter("page"));

        // load categories
        req.setAttribute("categories", categoryDAO.findAll());

        Integer price = null;

        // ===== VALIDATE =====
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        } else {
            try {
                price = Integer.parseInt(priceStr);

                if (price <= 0) {
                    req.setAttribute("errorPrice", "Giá phải lớn hơn 0!");
                }

            } catch (Exception e) {
                req.setAttribute("errorPrice", "Giá phải là số hợp lệ!");
            }
        }

        if (categoryId <= 0) {
            req.setAttribute("errorCategory", "Vui lòng chọn loại!");
        }

        // ===== CHECK ERROR =====
        if (req.getAttribute("errorName") != null ||
                req.getAttribute("errorPrice") != null ||
                req.getAttribute("errorCategory") != null) {

            loadPageData(req, page);

            req.setAttribute("error", "Vui lòng kiểm tra lại thông tin nhập liệu!");
            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("oldCategory", categoryId);
            req.setAttribute("openModal", true);

            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
            return;
        }

        // ===== CHECK TRÙNG =====
        if (DAO.isNameExists(name)) {

            req.setAttribute("error", "Tên đồ uống đã tồn tại trong hệ thống!");
            req.setAttribute("errorName", "Tên đồ uống đã tồn tại!");

            loadPageData(req, page);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("oldCategory", categoryId);
            req.setAttribute("openModal", true);

            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
            return;
        }

        // ===== CREATE =====
        Drink d = getData(req);
        d.setPrice(price); // dùng giá đã validate

        int result = DAO.create(d);
        if (result > 0) {
            req.getSession().setAttribute("message", "Thêm đồ uống mới thành công!");
        } else {
            req.getSession().setAttribute("error", "Không thể thêm đồ uống. Vui lòng thử lại!");
        }

        resp.sendRedirect(req.getContextPath() + "/manager/drinks?page=" + page);
    }

    // ========================= UPDATE =========================
    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        String activeStr = req.getParameter("active");
        boolean active = Boolean.parseBoolean(activeStr);
        int id = ParamUtil.getInt(req, "id");
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");
        int categoryId = ParamUtil.getInt(req, "categoryId");

        int page = parsePage(req.getParameter("page"));

        req.setAttribute("categories", categoryDAO.findAll());

        Integer price = null;

        // ===== VALIDATE =====
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("errorName", "Tên không được để trống!");
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("errorPrice", "Giá không được để trống!");
        } else {
            try {
                priceStr = priceStr.replace(",", ""); // bỏ dấu ,
                price = Integer.parseInt(priceStr);

                if (price <= 0) {
                    req.setAttribute("errorPrice", "Giá phải lớn hơn 0!");
                }

            } catch (Exception e) {
                req.setAttribute("errorPrice", "Giá phải là số hợp lệ!");
            }
        }

        if (categoryId <= 0) {
            req.setAttribute("errorCategory", "Vui lòng chọn loại!");
        }

        // ===== CHECK ERROR =====
        if (req.getAttribute("errorName") != null ||
                req.getAttribute("errorPrice") != null ||
                req.getAttribute("errorCategory") != null) {

            loadPageData(req, page);

            req.setAttribute("oldName", name);
            req.setAttribute("oldPrice", priceStr);
            req.setAttribute("oldCategory", categoryId);
            req.setAttribute("openModal", true);

            req.getRequestDispatcher("/WEB-INF/admin/drink-management.jsp").forward(req, resp);
            return;
        }

        // ===== UPDATE =====
        Drink oldDrink = DAO.findById(id); // Lấy dữ liệu cũ để giữ lại ảnh nếu không thay đổi
        Drink d = getData(req);
        d.setId(id);
        d.setPrice(price);
        d.setActive(active); 
        
        // Nếu không có ảnh mới, giữ lại ảnh cũ
        if (d.getImage() == null || d.getImage().isEmpty()) {
            d.setImage(oldDrink.getImage());
        }
        
        int result = DAO.update(d);
        if (result > 0) {
            req.getSession().setAttribute("message", "Cập nhật đồ uống thành công!");
        } else {
            req.getSession().setAttribute("error", "Không thể cập nhật đồ uống!");
        }

        resp.sendRedirect(req.getContextPath() + "/manager/drinks?page=" + page);
    }

    // ========================= DELETE =========================

    // ========================= GET DATA =========================
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
        d.setCategoryId(ParamUtil.getInt(req, "categoryId"));
        d.setDescription("demo");
        String activeStr = req.getParameter("active");
        boolean active = Boolean.parseBoolean(activeStr);
        d.setActive(active);

        return d;
    }

    // ========================= HELPER =========================
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
        if ("true".equalsIgnoreCase(value)) return true;
        if ("false".equalsIgnoreCase(value)) return false;
        return null;
    }
}
