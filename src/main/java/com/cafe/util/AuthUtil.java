package com.cafe.util;


import com.cafe.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthUtil {
    public static final String SESSION_USER = "user";
    //Lưu thông tin user đăng nhập
    public static void setUser(HttpServletRequest req, User user) {
        HttpSession session = req.getSession();
        session.setAttribute(SESSION_USER, user);
    }
    // Lấy thông tin user đăng nhập
    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute(SESSION_USER);
    }
    // Đã login chưa?
    public static boolean isAuthenticated(HttpServletRequest request) {
        return getUser(request) != null;
    }
    // Kiểm tra quyền
    public static boolean isManager(HttpServletRequest request) {
        User u = getUser(request);
        return u != null && u.getRole() == 2;
    }
    //Xóa thông tin đăng nhập
    public static void clear(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute(SESSION_USER);
    }
}



