package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);	
	
	void connectMain(int productNo, int attachNo);
	void connectDetail(int productNo, int attachNo);

	ProductDto selectOne(int productNo);
	List<ProductDto> selectList(PaginationVO vo);
	
	
	
	
	
	
	int countList(PaginationVO vo);

}
