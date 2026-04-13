package com.cafe.dto;

public class TopDrinkDTO {
    private String name;
    private int total;

    public TopDrinkDTO(String name, int total) {
        this.name = name;
        this.total = total;
    }

    public String getName() { return name; }
    public int getTotal() { return total; }
}