package com.cafe.entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
	public static final int ROLE_CUSTOMER = 0;
	public static final int ROLE_STAFF = 1;
	public static final int ROLE_ADMIN = 2;

	private int id;
	private String fullname;
	private String email;
	private String password;
	private String phone;
	private int role;
	private boolean active;
}

