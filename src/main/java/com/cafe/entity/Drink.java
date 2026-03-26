package com.cafe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Drink {
    private int id;

    private String categoryId;
    private int price;
    private String name;
    private String description;
    private String image;
    private boolean active;
}
