package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrdersDetailDto;


public interface OrdersDetailDao {
	int sequence();
	void insert(OrdersDetailDto ordersDetailDto);
	List<OrderDetailJoinDto> detailList (int ordersNo);
	List<OrderDetailJoinDto> memberOrdersList(String memberId);
	}

