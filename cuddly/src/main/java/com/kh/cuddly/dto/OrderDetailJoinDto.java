package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderDetailJoinDto {
	
	private int ordersDetailNo;
	private int ordersDetailPrice;
	private int ordersNo;
	private	int productNo;
	private String productName;
	private String productOptionName;
	private String creatorName;
	private int ordersDetailCount;
	private	Date ordersDate;
	private String memberId;

}
