package com.cafe.servlet.CRUD;

import com.cafe.dao.TableDAOImpl;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@MultipartConfig
@WebServlet({"/manager/tables", "/manager/tables/add", "/manager/tables/edit","/manager/tables/delete" })
public class TableServlet extends HttpServlet {

    TableDAOImpl dao = new TableDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = ParamUtil.getInt(req, "id");
        String name = ParamUtil.getString(req,"name");


        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
