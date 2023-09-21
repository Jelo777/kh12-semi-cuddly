package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;


public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto selectOne(int memberNo);

	List<OrdersDto> selectList();
	OrdersProductDto viewProduct(int ordersNo);
}
