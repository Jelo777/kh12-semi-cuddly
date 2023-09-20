package com.kh.cuddly.dao;

import com.kh.cuddly.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);	
	
	void connectMain(int productNo, int attachNo);
	void connectDetail(int productNo, int attachNo);
}
