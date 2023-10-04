package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.ProductListDto;
import com.kh.cuddly.dto.WishlistDto;

public interface WishlistDao {
	void insert(WishlistDto wishlistDto);
	boolean delete(WishlistDto wishlistDto);
	boolean check(WishlistDto wishlistDto);
	int count(int productNo);
	List<ProductListDto> wishlistByMemberId(String memberId);
}
