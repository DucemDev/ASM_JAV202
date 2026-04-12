package com.cafe.dao;


import com.cafe.entity.Drink;
import com.cafe.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import java.util.List;

import com.cafe.entity.Drink;

public class DrinkDAOImpl implements DrinkDAO {
    @Override
    public List<Drink> findAll(){
        List<Drink> list = new ArrayList<Drink>();
        String sql = "SELECT * FROM drinks WHERE active=1";
        try {
            ResultSet rs = DBConnect.executeQuery(sql);
            while (rs.next()) {
                int id = rs.getInt("id");
                int categoryId = rs.getInt("category_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String image = rs.getString("image");
                int price = rs.getInt("price");
                boolean active = rs.getBoolean("active");
                Drink d = new Drink(id, categoryId, price, name, description, image, active);
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public List<Drink> findPage(int page, int pageSize) {
        int offset = Math.max(0, (page - 1) * pageSize);
        String sql = "SELECT * FROM drinks WHERE active = 1 ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        return findBySql(sql, offset, pageSize);
    }

    @Override
    public int countActive() {
        String sql = "SELECT COUNT(*) FROM drinks WHERE active = 1";
        try {
            ResultSet rs = DBConnect.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public List<Drink> findPageAll(int page, int pageSize) {
        int offset = Math.max(0, (page - 1) * pageSize);
        String sql = "SELECT * FROM drinks ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        return findBySql(sql, offset, pageSize);
    }

    @Override
    public int countAllDrinks() {
        String sql = "SELECT COUNT(*) FROM drinks";
        try {
            ResultSet rs = DBConnect.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public List<Drink> findFilteredPage(int page, int pageSize, String keyword, Integer categoryId, Boolean active) {
        int offset = Math.max(0, (page - 1) * pageSize);
        StringBuilder sql = new StringBuilder("SELECT * FROM drinks WHERE 1=1");
        List<Object> params = new ArrayList<>();

        appendFilter(sql, params, keyword, categoryId, active);

        sql.append(" ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(pageSize);

        return findBySql(sql.toString(), params.toArray());
    }

    @Override
    public int countFiltered(String keyword, Integer categoryId, Boolean active) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM drinks WHERE 1=1");
        List<Object> params = new ArrayList<>();

        appendFilter(sql, params, keyword, categoryId, active);

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public List<Drink> findFiltered(String keyword, Integer categoryId, Boolean active) {
        StringBuilder sql = new StringBuilder("SELECT * FROM drinks WHERE 1=1");
        List<Object> params = new ArrayList<>();

        appendFilter(sql, params, keyword, categoryId, active);
        sql.append(" ORDER BY id");

        return findBySql(sql.toString(), params.toArray());
    }
    @Override
    public Drink findById(int id) {
        Drink d = null;
        String sql = "SELECT * FROM drinks WHERE id = ?";
        try {
            ResultSet rs = DBConnect.executeQuery(sql, id);
            while (rs.next()) {
                int categoryId = rs.getInt("category_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String image = rs.getString("image");
                int price = rs.getInt("price");
                boolean active = rs.getBoolean("active");
                d = new Drink(id, categoryId, price, name, description, image, active);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }
    @Override
    public int delete(int id) {
        String sql = "UPDATE drinks SET active = 0 WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int create(Drink drink) {
        String sql = "INSERT INTO drinks(category_id, name, description, image, price, active) values (?, ?, ?, ?, ?, ?)";
        try {
            return DBConnect.executeUpdate(sql, drink.getCategoryId(), drink.getName(), drink.getDescription(),
                    drink.getImage(), drink.getPrice(), drink.isActive());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;

    }
    @Override
    public int update(Drink drink) {
        String sql = "UPDATE drinks SET category_id = ?, name = ?, description = ?, image = ?, price = ?, active = ? WHERE id = ?";
        try {
            return DBConnect.executeUpdate(sql, drink.getCategoryId(), drink.getName(), drink.getDescription(),
                    drink.getImage(), drink.getPrice(), drink.isActive(), drink.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;

    }
    @Override
    public List<Drink> findBySql(String sql, Object... value) {
        List<Drink> list = new ArrayList<Drink>();
        try {
            ResultSet rs = DBConnect.executeQuery(sql, value);
            while (rs.next()) {
                int id = rs.getInt("id");
                int categoryId = rs.getInt("category_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                String image = rs.getString("image");
                int price = rs.getInt("price");
                boolean active = rs.getBoolean("active");
                Drink d = new Drink(id, categoryId, price, name, description, image, active);
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean isNameExists(String name) {
        String sql = "SELECT COUNT(*) FROM drinks WHERE name = ? AND active = 1";
        try {
            ResultSet rs = DBConnect.executeQuery(sql, name);
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean isNameExistsForUpdate(String name, int id) {
        String sql = "SELECT COUNT(*) FROM drinks WHERE name = ? AND id <> ? AND active = 1";
        try {
            ResultSet rs = DBConnect.executeQuery(sql, name, id);
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void appendFilter(StringBuilder sql, List<Object> params, String keyword, Integer categoryId, Boolean active) {
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (categoryId != null && categoryId > 0) {
            sql.append(" AND category_id = ?");
            params.add(categoryId);
        }

        if (active != null) {
            sql.append(" AND active = ?");
            params.add(active);
        }
    }
}
