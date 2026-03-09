package com.cafe.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BillDetail {
    private int id;
    private int billId;
    private int drinkId;
    private int quantity;
    private int price;

}
