package com.kh.cuddly.dao;

import com.kh.cuddly.dto.WishlistDto;

public interface WishlistDao {
	int sequence();
	void insert(WishlistDto wishlistDto);
	
}
