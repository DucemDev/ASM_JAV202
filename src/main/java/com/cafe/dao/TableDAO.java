package com.cafe.dao;

import com.cafe.entity.Table;

import java.util.List;

public interface TableDAO {
    List<Table> findAll();

    Table findById(int id);
    List<Table> search(String status, String keyword);

    void create(Table t);
    void update(Table t);
    void updateStatus(int id, String status);

    boolean existsByName(String name);
    boolean existsByNameExceptId(String name, int id);

    void hide(int id);

    void show(int id);
}