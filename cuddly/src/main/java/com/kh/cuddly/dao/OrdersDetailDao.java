package com.kh.cuddly.dao;

import java.util.List;


import com.kh.cuddly.dto.OrdersDetailDto;


public interface OrdersDetailDao {
	int sequence();
	void insert(OrdersDetailDto ordersDetailDto);
	OrdersDetailDto selectOne(int OrdersDetailNo);
	List<OrdersDetailDto> selectList();
	}

