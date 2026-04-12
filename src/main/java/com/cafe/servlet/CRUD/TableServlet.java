package com.cafe.servlet.CRUD;

import com.cafe.dao.TableDAO;
import com.cafe.dao.TableDAOImpl;
import com.cafe.entity.Table;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.cafe.dao.BillDAO;
import com.cafe.dao.BillDAOImpl;
import java.io.IOException;
import java.util.List;

@MultipartConfig
@WebServlet({
        "/manager/tables",
        "/manager/tables/add",
        "/manager/tables/edit",
        "/manager/tables/hide",
        "/manager/tables/show"
})
public class TableServlet extends HttpServlet {

    private final TableDAO dao = new TableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = ParamUtil.getInt(req, "id");

            if (id > 0) {
                Table table = dao.findById(id);

                if (table != null && ("occupied".equalsIgnoreCase(table.getStatus()) || "using".equalsIgnoreCase(table.getStatus()))) {
                    req.getSession().setAttribute("error", "Không thể sửa bàn đang sử dụng!");
                } else {
                    req.setAttribute("table", table);
                }
            }
            List<Table> list = dao.findAll();
            req.setAttribute("list", list);

            req.getRequestDispatcher("/WEB-INF/admin/Table-management.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/manager/tables");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String uri = req.getRequestURI();

            if (uri.contains("/add")) {
                create(req);
            } else if (uri.contains("/edit")) {
                update(req);
            } else if (uri.contains("/hide")) {
                hide(req);
            } else if (uri.contains("/show")) {
                show(req);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Có lỗi xảy ra khi xử lý bàn!");
        }

        resp.sendRedirect(req.getContextPath() + "/manager/tables");
    }

    private void create(HttpServletRequest req) {
        String name = ParamUtil.getString(req, "name");
        String status = req.getParameter("status");

        if (name == null || name.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Tên bàn không được để trống!");
            return;
        }

        if (status == null || status.trim().isEmpty()) {
            status = "empty";
        }

        if (dao.existsByName(name.trim())) {
            req.getSession().setAttribute("error", "Tên bàn đã tồn tại!");
            return;
        }

        Table table = new Table();
        table.setName(name.trim());
        table.setStatus(status.trim());

        dao.create(table);
        req.getSession().setAttribute("message", "Thêm bàn thành công!");
    }

    private void update(HttpServletRequest req) {
        int id = ParamUtil.getInt(req, "id");
        String name = req.getParameter("name");
        String status = req.getParameter("status");

        if (id <= 0) {
            req.getSession().setAttribute("error", "ID bàn không hợp lệ!");
            return;
        }

        if (name == null || name.trim().isEmpty()) {
            req.getSession().setAttribute("error", "Tên bàn không được để trống!");
            return;
        }

        if (status == null || status.trim().isEmpty()) {
            status = "empty";
        }

        if (dao.existsByNameExceptId(name.trim(), id)) {
            req.getSession().setAttribute("error", "Tên bàn đã tồn tại!");
            return;
        }

        Table table = new Table();
        table.setId(id);
        table.setName(name.trim());
        table.setStatus(status.trim());

        dao.update(table);
        req.getSession().setAttribute("message", "Cập nhật bàn thành công!");
    }

    private void hide(HttpServletRequest req) {
        int id = ParamUtil.getInt(req, "id");
        if (id <= 0) {
            req.getSession().setAttribute("error", "ID bàn không hợp lệ!");
            return;
        }

        Table table = dao.findById(id);
        if (table == null) {
            req.getSession().setAttribute("error", "Không tìm thấy bàn!");
            return;
        }

        if (!"empty".equalsIgnoreCase(table.getStatus())) {
            req.getSession().setAttribute("error", "Chỉ có bàn trống mới được ẩn!");
            return;
        }

        dao.hide(id);
        req.getSession().setAttribute("message", "Đã ẩn bàn!");
    }

    private void show(HttpServletRequest req) {
        int id = ParamUtil.getInt(req, "id");
        if (id <= 0) {
            req.getSession().setAttribute("error", "ID bàn không hợp lệ!");
            return;
        }

        dao.show(id);
        req.getSession().setAttribute("message", "Đã hiện bàn!");
    }
}