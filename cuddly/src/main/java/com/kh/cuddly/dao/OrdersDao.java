package com.kh.cuddly.dao;

import com.kh.cuddly.dto.OrdersDto;


public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto selectOne(int OrdersNo);
	boolean update(OrdersDto orderDto); 
}
