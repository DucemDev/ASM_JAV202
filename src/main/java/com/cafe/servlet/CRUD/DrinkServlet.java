package com.cafe.servlet.CRUD;

import com.cafe.dao.CategoryDAOImpl;
import com.cafe.dao.DrinkDAOImpl;
import com.cafe.entity.Drink;
import com.cafe.util.FileUtil;
import com.cafe.util.ParamUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

@WebServlet({ "/manager/drinks", "/manager/drinks/add", "/manager/drinks/edit", "/manager/drinks/delete" })
public class DrinkServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DrinkDAOImpl drinkDAO = new DrinkDAOImpl();
    private CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uriString = req.getRequestURI();
        if (uriString.contains("create") || uriString.contains("edit")) {
            req.getRequestDispatcher("/views/drink/drink-form.jsp").forward(req, resp);
            return;
        }
        if (uriString.contains("/manager/drinks")) {
            getDrinksManager(req);
            req.getRequestDispatcher("/views/drink/manager-list.jsp").forward(req, resp);
            return;
        }
    }

    private void getDrinksManager(HttpServletRequest request) {
        List<Drink> list = drinkDAO.findAll();
        request.setAttribute("drinks", list);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uriString = req.getRequestURI();
        if (uriString.contains("add")) {
            create(req, resp);
            return;
        }
        if (uriString.contains("edit")) {
            edit(req, resp);
            return;
        }
        if (uriString.contains("delete")) {
            delete(req, resp);
            return;
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response) {
        try {
            Drink drink = getDrinkFromRequestAndValidate(request, response);
            if (drink != null) {
                int rs = drinkDAO.create(drink);

                if (rs > 0) {
                    response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
                }

            }
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    private void edit(HttpServletRequest request, HttpServletResponse response) {
        try {
            Drink drink = getDrinkFromRequestAndValidate(request, response);
            if (drink != null) {
                int drinkId = ParamUtil.getInt(request, "drinkId");
                drink.setId(drinkId);
                int rs = drinkDAO.update(drink);

                if (rs > 0) {
                    response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
                }

            }
        } catch (IOException | ServletException e) {
            e.printStackTrace();
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        try {
            int drinkId = ParamUtil.getInt(request, "drinkId");
            int rs = drinkDAO.delete(drinkId);

            if (rs > 0) {
                response.sendRedirect(request.getContextPath() + "/manager/drinks?error=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/manager/drinks?error=false");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Drink getDrinkFromRequestAndValidate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//		Lấy dữ liệu từ form
        int categoryId = ParamUtil.getInt(request, "categoryId");
        String name = ParamUtil.getString(request, "name");
        String description = ParamUtil.getString(request, "description");
        int price = ParamUtil.getInt(request, "price");
        int active = ParamUtil.getInt(request, "active");
        Part imagePart = request.getPart("image");

        boolean hasError = false;
        if (categoryId == 0) {
            request.setAttribute("errCat", "Vui lòng chọn danh mục");
            hasError = true;
        }
        if (name == null || name.isBlank()) {
            request.setAttribute("errName", "Vui lòng nhập tên đồ uống");
            hasError = true;
        }
        if (price <= 0) {
            request.setAttribute("errPrice", "Giá phải lớn hơn 0");
            hasError = true;
        }
        if (description == null || description.isBlank()) {
            request.setAttribute("errDesc", "Vui lòng nhập mô tả");
            hasError = true;
        }
        if (imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("errImage", "Vui lòng chọn hình ảnh");
            hasError = true;
        }
        if (hasError) {
            request.getRequestDispatcher("/views/drink/drink-form.jsp").forward(request, response);
            return null;
        }
        String imageName = FileUtil.upload(request, "image");
        //		Lưu dữ liệu vào đối tượng Drink
        Drink drink = new Drink();
        drink.setCategoryId(categoryId);
        drink.setName(name);
        drink.setDescription(description);
        drink.setPrice(price);
        drink.setActive(active == 1);
        drink.setImage(imageName);

        return drink;
    }
}
