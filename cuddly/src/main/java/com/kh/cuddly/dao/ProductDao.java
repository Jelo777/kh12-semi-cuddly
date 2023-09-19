package com.kh.cuddly.dao;

import com.kh.cuddly.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);	
}
