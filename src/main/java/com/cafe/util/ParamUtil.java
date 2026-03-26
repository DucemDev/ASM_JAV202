package com.cafe.util;

import jakarta.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ParamUtil {
    public static String getString(HttpServletRequest request, String name) {
        try {
            return request.getParameter(name);
        } catch (Exception e) {
            // TODO: handle exception
            return null;
        }
    }
    public static int getInt(HttpServletRequest request, String name) {
        try {
            return Integer.parseInt(request.getParameter(name));
        } catch (Exception e) {
            // TODO: handle exception
            return 0;
        }

    }
    //Trả về giá trị kiểu Date
    public static Date getDate(HttpServletRequest request, String name, String pattern) {
        try {
            String value = request.getParameter(name);
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            return sdf.parse(value);
        } catch (Exception e) {
            return null;
        }
    }
}