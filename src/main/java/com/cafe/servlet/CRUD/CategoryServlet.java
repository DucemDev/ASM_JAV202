package com.cafe.servlet.CRUD;

import com.cafe.dao.CategoryDAOImpl;
import com.cafe.entity.Category;
import com.cafe.util.ParamUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/manager/categories","/manager/categories/add","/manager/categories/edit","/manager/categories/delete"})
public class CategoryServlet extends HttpServlet {

    CategoryDAOImpl dao = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = ParamUtil.getInt(req, "id");
        String keyword = req.getParameter("keyword");
        String active = req.getParameter("active");

        if (id > 0) {
            req.setAttribute("category", dao.findById(id));
        }

        req.setAttribute("keyword", keyword);
        req.setAttribute("active", active);
        req.setAttribute("list", dao.search(keyword, active));
        req.getRequestDispatcher("/WEB-INF/admin/CategoryJsp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("add")) {
            boolean success = create(req);
            if (success) {
                req.getSession().setAttribute("message", "Thêm loại thành công!");
            }
        }

        if (uri.contains("edit")) {
            boolean success = update(req);
            if (success) {
                req.getSession().setAttribute("message", "Cập nhật thành công!");
            }
        }

        if (uri.contains("delete")) {
            delete(req);
        }

        resp.sendRedirect(req.getContextPath() + "/manager/categories");
    }

    private boolean create(HttpServletRequest req) {
        String name = req.getParameter("name");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));

        if (dao.existsByName(name)) {
            req.getSession().setAttribute("error", "Tên loại đã tồn tại!");
            return false;
        }

        dao.create(new Category(0, name, active));
        return true;
    }

    private boolean update(HttpServletRequest req) {
        int id = ParamUtil.getInt(req, "id");
        String name = req.getParameter("name");
        boolean active = Boolean.parseBoolean(req.getParameter("active"));

        if (dao.existsByNameExceptId(name, id)) {
            req.getSession().setAttribute("error", "Tên loại đã tồn tại!");
            return false;
        }

        dao.update(new Category(id, name, active));
        return true;
    }

    private void delete(HttpServletRequest req) {
        int id = ParamUtil.getInt(req, "id");

        int count = dao.countDrinkInCategory(id);

        if (count > 0) {
            req.getSession().setAttribute("error",
                    "Không thể xóa! Có " + count + " đồ uống đang sử dụng loại này.");
        } else {
            dao.delete(id);
            req.getSession().setAttribute("message", "Xóa thành công!");
        }
    }
}
