package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersProductDto {
	
	private int cartNo;
	private int productNo;
	private int productOptionNo;
	private String productName;
	private int productPrice;
	private String productOptionName;
	private int cartCount;
	private String creatorName;
	private String memberId;
	private Date cartDate;
	private int cartPrice;

}
