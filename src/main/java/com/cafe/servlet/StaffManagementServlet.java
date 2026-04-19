package com.cafe.servlet;

import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/manager/staff",
        "/manager/staff/add",
        "/manager/staff/edit",
        "/manager/staff/delete",
        "/manager/staff/update-status"
})
public class StaffManagementServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    private UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        switch (path) {

            // LIST
            case "/manager/staff":
                listStaff(req);
                req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp")
                        .forward(req, resp);
                break;

            // 👉 ADD FORM
            case "/manager/staff/add":
                listStaff(req);
                req.setAttribute("formMode", "add");
                req.setAttribute("user", new User()); // Đặt user mới để tránh lấy user từ session
                req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp")
                        .forward(req, resp);
                break;

            // 👉 EDIT FORM
            case "/manager/staff/edit":
                int id = ParamUtil.getInt(req, "userId");
                User user = userDAO.findById(id);

                listStaff(req);
                req.setAttribute("formMode", "edit");
                req.setAttribute("user", user);

                req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp")
                        .forward(req, resp);
                break;

            case "/manager/staff/delete":
                delete(req, resp);
                break;

            case "/manager/staff/update-status":
                updateStatus(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        switch (path) {
            case "/manager/staff/add":
                create(req, resp);
                break;

            case "/manager/staff/edit":
                update(req, resp);
                break;
        }
    }

    // LIST
    private void listStaff(HttpServletRequest req) {
        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");

        int page = parsePage(req.getParameter("page"));

        int totalUsers = userDAO.countUsers(keyword, status);
        int totalPages = Math.max(1, (int) Math.ceil((double) totalUsers / PAGE_SIZE));

        if (page > totalPages) {
            page = totalPages;
        }

        List<User> staffList = userDAO.findPage(page, PAGE_SIZE, keyword, status);

        req.setAttribute("staffList", staffList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("keyword", keyword);
        req.setAttribute("status", status);
    }

    // CREATE
    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        User u = getFormData(req);

        if (u.getEmail().isEmpty() || u.getPassword().isEmpty() || u.getPhone().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "add");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

        // VALIDATE FORMAT
        if (!u.getEmail().matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
            req.setAttribute("error", "Email không hợp lệ!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "edit");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }


        if (!u.getEmail().contains("@gmail.com")) {
            req.setAttribute("error", "Email không hợp lệ!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "add");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

        if (!u.getPhone().matches("^(0[3|5|7|8|9])[0-9]{8}$")) {
            req.setAttribute("error", "Số điện thoại không hợp lệ!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "add");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

        if (userDAO.findByEmail(u.getEmail()) != null) {
            req.setAttribute("error", "Email đã tồn tại!");
            listStaff(req);
            req.setAttribute("formMode", "add");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

        userDAO.create(u);
        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // UPDATE
    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        System.out.println("UPDATE CALLED");
        int id = ParamUtil.getInt(req, "userId");
        User old = userDAO.findById(id);

        User u = getFormData(req);
        u.setId(id);

        if (u.getPassword() == null || u.getPassword().isBlank()) {
            u.setPassword(old.getPassword());
        }


        if (u.getEmail() == null || u.getEmail().isBlank()
                || u.getFullname() == null || u.getFullname().isBlank()
                || u.getPhone() == null || u.getPhone().isBlank()) {

            req.setAttribute("error", "Không được để trống thông tin!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "edit");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

        if (!u.getEmail().contains("@gmail.com")) {
            req.setAttribute("error", "Email không hợp lệ!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "edit");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }



        if (!u.getPhone().matches("^(0[3|5|7|8|9])[0-9]{8}$")) {
            req.setAttribute("error", "Số điện thoại không hợp lệ!");
            req.setAttribute("user", u);
            listStaff(req);
            req.setAttribute("formMode", "edit");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }

// ✅ CHECK EMAIL TRÙNG (trừ chính nó)
        User exist = userDAO.findByEmail(u.getEmail());
        if (exist != null && exist.getId() != id) {
            req.setAttribute("error", "Email đã tồn tại!");
            listStaff(req);
            req.setAttribute("formMode", "edit");
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp").forward(req, resp);
            return;
        }
        userDAO.update(u);
        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // DELETE
    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = ParamUtil.getInt(req, "userId");

        // 👉 Lấy user đang login
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 🚨 CHẶN TỰ XÓA
        if (currentUser != null && currentUser.getId() == id) {
            req.setAttribute("error", "Bạn không thể tự xóa tài khoản của chính mình!");
            listStaff(req);
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp")
                    .forward(req, resp);
            return;
        }

        userDAO.updateStatus(id, false);
        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // STATUS
    private void updateStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = ParamUtil.getInt(req, "userId");
        int status = ParamUtil.getInt(req, "status");

        // 👉 Lấy user đang login
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");

        // 🚨 CHẶN TỰ KHÓA
        if (currentUser != null && currentUser.getId() == id && status == 0) {
            req.setAttribute("error", "Bạn không thể tự khóa tài khoản của chính mình!");
            listStaff(req);
            req.getRequestDispatcher("/WEB-INF/admin/user-management.jsp")
                    .forward(req, resp);
            return;
        }

        userDAO.updateStatus(id, status == 1);

        resp.sendRedirect(req.getContextPath() + "/manager/staff");
    }

    // FORM DATA
    private User getFormData(HttpServletRequest req) {
        User u = new User();

        u.setEmail(req.getParameter("email"));
        u.setPassword(req.getParameter("password"));
        u.setFullname(req.getParameter("fullName"));
        u.setPhone(req.getParameter("phone"));

        // STATUS
        u.setActive("1".equals(req.getParameter("active")));

        // ROLE (NEW)
        try {
            int role = Integer.parseInt(req.getParameter("role"));
            u.setRole(role);
        } catch (Exception e) {
            u.setRole(User.ROLE_STAFF); // fallback
        }

        return u;
    }

    private int parsePage(String pageParam) {
        try {
            int page = Integer.parseInt(pageParam);
            return Math.max(page, 1);
        } catch (Exception e) {
            return 1;
        }
    }
}
