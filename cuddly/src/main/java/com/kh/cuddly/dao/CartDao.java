package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.WishlistDto;

public interface CartDao {
	int sequence();
	void insert(CartDto CartDto);
	List<CartDto> selectCartList();

}
