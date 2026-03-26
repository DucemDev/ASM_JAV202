package com.cafe.servlet.CRUD;

import com.cafe.dao.UserDAOImpl;
import com.cafe.entity.User;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet({ "/manager/staff", "/manager/staff/add", "/manager/staff/edit", "/manager/staff/update-status" })
public class StaffSevlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAOImpl userDAO = new UserDAOImpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    public void listStaff(HttpServletRequest req, HttpServletResponse resp) {
        List<User> staffList = userDAO.findByRole(false);
        req.setAttribute("staffList", staffList);
    }
    public void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User staff = getStaffFromRequestAndValidate(req, resp);
        if (staff != null) {
//			Kiểm tra email đã tồn tại chưa
            User existingUser = userDAO.findByEmail(staff.getEmail());
            if (existingUser != null) {
                req.setAttribute("emailError", "Email đã được sử dụng.");
                req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
                return;
            }
            int rs = userDAO.create(staff);
            if (rs > 0) {
                resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
            } else {
                resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
            }
        }
    }
    public void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User staff = getStaffFromRequestAndValidate(req, resp);
        if (staff != null) {
            int userId = ParamUtil.getInt(req, "userId");
            staff.setId(userId);
            int rs = userDAO.updateUserInfo(staff);
            if (rs > 0) {
                resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
            } else {
                resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
            }
        }
    }
    public void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = ParamUtil.getInt(req, "userId");
        int status = ParamUtil.getInt(req, "status");
        int rs = userDAO.updateStatus(userId, status == 1);
        if (rs > 0) {
            resp.sendRedirect(req.getContextPath() + "/manager/staff?error=true");
        } else {
            resp.sendRedirect(req.getContextPath() + "/manager/staff?error=false");
        }
    }
    public User getStaffFromRequestAndValidate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = ParamUtil.getString(req, "email");
        String password = ParamUtil.getString(req, "password");
        String fullName = ParamUtil.getString(req, "fullName");
        String phone = ParamUtil.getString(req, "phone");
        int active = ParamUtil.getInt(req, "active");

        boolean hasError = false;
        if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            req.setAttribute("emailError", "Email không hợp lệ.");
            hasError = true;
        }
        if (password == null || password.length() < 6) {
            req.setAttribute("passwordError", "Mật khẩu phải có ít nhất 6 ký tự.");
            hasError = true;
        }
        if (fullName == null || fullName.isBlank()) {
            req.setAttribute("fullNameError", "Họ và tên không được để trống.");
            hasError = true;
        }
        if (phone == null || !phone.matches("^0\\d{9}$")) {
            req.setAttribute("phoneError", "Số điện thoại không hợp lệ.");
            hasError = true;
        }
        if (hasError) {
            req.getRequestDispatcher("/views/staff/staff-form.jsp").forward(req, resp);
            return null;
        }

        User staff = new User();
        staff.setEmail(email);
        staff.setPassword(password);
        staff.setFullname(fullName);
        staff.setPhone(phone);
        staff.setActive(active == 1);
        staff.setRole(false);
        return staff;
    }
}
