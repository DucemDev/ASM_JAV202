package com.cafe.entity;

import   lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Data
public class Category {
    private int id;
    private String name;
    private boolean active;
}
