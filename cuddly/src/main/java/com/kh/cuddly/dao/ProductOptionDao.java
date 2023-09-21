package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.ProductOptionDto;

public interface ProductOptionDao {
	
	int sequence();
	void insert(ProductOptionDto productOptionDto);
	List<ProductOptionDto> selectListByProductNo(int productNo);
	
	int update(ProductOptionDto productOptionDto);//옵션수정
	boolean findOptionName(ProductOptionDto productOptionDto);//옵선추가에서 중복확인
	
}
