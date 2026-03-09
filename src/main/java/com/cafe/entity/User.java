package com.cafe.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    private int id;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private boolean role;
    private boolean active;
}
