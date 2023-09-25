package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersAdminDto {
	private int productNo;
	private Date ordersDate;
	private String productName;
	private int productPrice;
	private String productOptionName;
	private int ordersDetailCount;
	private String creatorName;
	private int ordersDetailNo;
}
