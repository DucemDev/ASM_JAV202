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
    private int userId;
    private String code;
    private LocalDate createdAt;
    private int total; // tiền sao dùng string vậy ní double thì phải ní
    private String status;
    private int tableId;
    private String type;
}
