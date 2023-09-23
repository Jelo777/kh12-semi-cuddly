package com.kh.cuddly.dto;

import java.util.List;

import lombok.Data;

@Data
public class MultiOrders {
	
	private List<OrdersDetailDto> details;

}
