package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.OrdersProductDto;

public interface CartDao {
	int sequence();
	void insert(CartDto CartDto);
	int price(int optionNo);
	List<OrdersProductDto> selectCartList(PaginationVO vo,String memberId);
	boolean cartDelete(int cartNo);
	int countList(PaginationVO vo,String memberId);

	CartDto selectOne(int cartNo);
}
