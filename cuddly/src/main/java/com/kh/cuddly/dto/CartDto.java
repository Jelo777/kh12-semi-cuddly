package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;


@Data
public class CartDto {
	private int cartNo;
	private String memberId;
	private int optionNo;
	private int cartCount;
	private int cartPrice;
	private Date cartDate;
}
