package com.cafe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    private int id;
    private int userId;
    private String code;
    private LocalDate createdAt;
    private String total;
    private String status;
}
