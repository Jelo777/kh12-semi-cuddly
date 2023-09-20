package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;


@Data
public class CartDto {
	private int cartNo;
	private int cartCount;
	private int cartPrice;
	private Date cartDate;
}
