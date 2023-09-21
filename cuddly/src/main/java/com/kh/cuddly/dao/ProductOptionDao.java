package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.ProductOptionDto;

public interface ProductOptionDao {
	
	int sequence();
	void insert(ProductOptionDto productOptionDto);
	List<ProductOptionDto> selectListByProductNo(int productNo);
}
