package com.cafe.dao;

import com.cafe.entity.Table;

import java.util.List;

public interface TableDAO {
    List<Table> findAll();
    

    List<Table> search(String status, String keyword);

    void create(Table t);

    void updateStatus(int id, String status);


    boolean existsByName(String name);

    void hide(int id);

    void show(int id);
}