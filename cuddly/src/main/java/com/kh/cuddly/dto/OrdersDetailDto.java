package com.kh.cuddly.dto;

import lombok.Data;


@Data
public class OrdersDetailDto {
	private int ordersDetailNo;
    private int ordersNo;
    private int optionNo; 
    private int productNo; 
    private int ordersDetailCount;
    private int ordersDetailPrice;
}

