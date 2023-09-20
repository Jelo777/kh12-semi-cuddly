package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.WishlistDto;

public interface WishlistDao {
	int sequence();
	void insert(WishlistDto wishlistDto);
	WishlistDto selectOne(int WishlistNo);	
	List<WishlistDto> selectList();
	void delete(int wishlistNo);
}
