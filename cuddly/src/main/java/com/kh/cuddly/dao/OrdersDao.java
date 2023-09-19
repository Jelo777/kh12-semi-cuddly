package com.kh.cuddly.dao;

import com.kh.cuddly.dto.OrdersDto;

public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
}
