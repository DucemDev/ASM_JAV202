package com.cafe.entity;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bill {
    private int id;
    private int usserId;
    private String code;
    private LocalDate createdAt;
    private String total;
    private String status;
}
