package com.kh.cuddly.dto;

import lombok.Data;

@Data
public class OrdersProductDto {
	
	private int productNo;
	private int productOptionNo;
	private String productName;
	private int productPrice;
	private String productOptionName;
	private int cartCount;
	private String creatorName;
	

}
