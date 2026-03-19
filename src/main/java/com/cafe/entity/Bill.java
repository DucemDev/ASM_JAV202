package com.cafe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Bill {

    private int id;

    private int tableId;
    private int userId;

    private String code;

    private int total;

    private String status;
}
