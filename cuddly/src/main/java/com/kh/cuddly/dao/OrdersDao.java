package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;


public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto selectOne(String memberId);
	
	List<OrdersDto> selectList();
	OrdersProductDto viewProduct(int ordersNo);
	
	List<OrderDetailJoinDto> selectListOrders(String memberId);
	
	List<OrdersDto> selectOneByMemberOrders(String memberId);//회원관리페이지구매내역(Dao에 필요한 sql문이 달라서 추가)
}
