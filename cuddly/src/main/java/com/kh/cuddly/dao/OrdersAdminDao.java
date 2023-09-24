package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.OrdersAdminDto;

public interface OrdersAdminDao {
	List<OrdersAdminDto> selectList(String memberId);
}
