package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.OrdersDto;


public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto selectOne(int OrdersNo);
	List<OrdersDto> selectList();
}
