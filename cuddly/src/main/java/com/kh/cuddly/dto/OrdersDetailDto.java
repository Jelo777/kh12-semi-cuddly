package com.kh.cuddly.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDetailDto {
	private int ordersDetailNo;
    private int ordersNo;
    private int optionNo; 
    private int productNo; 
    private int ordersDetailCount;
    private int ordersDetailPrice;
}

