package com.cafe.dao;


import com.cafe.entity.Drink;
import com.cafe.util.DBConnect;

import java.sql.ResultSet;
import java.util.ArrayList;

import java.util.List;

import com.cafe.entity.Drink;

public class DrinkDAOImpl implements DrinkDAO {
    @Override
    public List<Drink> findAll(){
        List<Drink> list = new ArrayList<Drink>();
        String sql = "SELECT * FROM drinks";
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
}
