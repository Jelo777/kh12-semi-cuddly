package com.kh.cuddly.dto;

import lombok.Data;

@Data
public class OrdersDetailDto {
	private int ordersDetailNo; // 상세번호 
	private int ordersDetailCount; // 수량 
	private int ordersDetailPrice; // 개당금액 
}
