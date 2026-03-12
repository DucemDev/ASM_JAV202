package com.cafe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Table {
    private int id;
    private String name;
    private String capacity;
    private String status;
    private boolean active;
}
