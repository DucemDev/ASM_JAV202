package com.cafe.servlet.CRUD;

import com.cafe.dao.CategoryDAO;
import com.cafe.dao.CategoryDAOImpl;
import com.cafe.entity.Category;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({"/manager/categories","/manager/categories/add","/manager/categories/edit","/manager/categories/delete"})
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    CategoryDAOImpl categoryDAO = new CategoryDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = ParamUtil.getInt(req, "id");
        if (id > 0) {
            Category category = categoryDAO.findById(id);
            req.setAttribute("category", category);
        }
        List<Category> list = categoryDAO.findAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/WEB-INF/admin/CategoryJsp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uriString = req.getRequestURI();
        if (uriString.contains("add")) {
            create(req);
        }
        if (uriString.contains("edit")) {
            update(req);
        }
        if (uriString.contains("delete")) {
            delete(req);
        }
        List<Category> list = categoryDAO.findAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/WEB-INF/admin/CategoryJsp.jsp").forward(req, resp);
    }
    //xử lý thêm mới
    public void create(HttpServletRequest request) {
        int id = ParamUtil.getInt(request, "id");
        String name = ParamUtil.getString(request, "name");
        if (name.isEmpty()) {
            request.setAttribute("error", "Tên không được để trống");
        }else {
            Category category = new Category(id, name, true);
            int rs = categoryDAO.create(category);
            if (rs > 0) {
                request.setAttribute("message", "Thêm mới thành công");
            }else {
                request.setAttribute("error", "Thêm mới thất bại");
            }
        }
    }
    //xử lý cập nhật
    public void update(HttpServletRequest request) {
        int id = ParamUtil.getInt(request, "id");
        String name = ParamUtil.getString(request, "name");
        Category category = categoryDAO.findById(id);
        if (category != null) {
            category.setName(name);
            int rs = categoryDAO.update(category);
            if (rs > 0) {
                request.setAttribute("message", "Cập nhật thành công");
            }else {
                request.setAttribute("error", "Cập nhật thất bại");
            }
            request.setAttribute("category", category);
        }else {
            request.setAttribute("error", "Loại không tồn tại");
        }

    }
    //xử lý xóa
    public void delete(HttpServletRequest request) {
        Integer id = ParamUtil.getInt(request, "id");
        if (id > 0) {
            Category category = categoryDAO.findById(id);
            int countDrink = categoryDAO.countDrinkInCategory(id);
            if (countDrink > 0) {
                category.setActive(false);
                categoryDAO.update(category);
            }else {
                categoryDAO.delete(id);
            }
            request.setAttribute("message", "Xóa thành công");
            request.setAttribute("category", null);
        }else {
            request.setAttribute("error", "Không tìm thấy loại đồ uống");
        }
    }
}
