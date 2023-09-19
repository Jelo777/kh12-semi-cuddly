package com.kh.cuddly.dao;

import com.kh.cuddly.dto.OrdersDetailDto;


public interface OrdersDetailDao {
	int sequence();
	void insert(OrdersDetailDto ordersDetailDto);
}
