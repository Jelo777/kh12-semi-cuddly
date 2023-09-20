package com.kh.cuddly.dto;

import java.sql.Date;

import lombok.Data;


@Data
public class OrdersDto {
	private int ordersNo; // 주문번호
	private String memberId;
	private int addressNo;
	private int ordersPrice; // 결제금액 
	private String ordersPayment; // 결제수단 
	private Date ordersDate; // 주문날짜 
}
