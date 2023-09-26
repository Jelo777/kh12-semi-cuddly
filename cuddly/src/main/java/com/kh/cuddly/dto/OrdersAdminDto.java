package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrdersAdminDto {
	private int ordersNo;
	private Date ordersDate;
	private int ordersDetailNo;
	private String productName;
	private String creatorName;
	private int ordersDetailCount;
	private String productOptionName;
	private int ordersDetailPrice;
	private String memberId;
	private int productNo;
	private int ordersCount;
}
