package com.kh.cuddly.dao;

import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.dto.WishlistDto;

public interface CartDao {
	int sequence();
	void insert(CartDto CartDto);
}
