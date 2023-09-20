package com.kh.cuddly.dao;

import com.kh.cuddly.dto.ProductOptionDto;

public interface ProductOptionDao {
	
	int sequence();
	void insert(ProductOptionDto productOptionDto);
}
