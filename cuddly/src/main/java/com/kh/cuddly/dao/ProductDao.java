package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;

public interface ProductDao {
	int sequence();
	void insert(ProductDto productDto);	
	
	void connectMain(int productNo, int attachNo);
	void connectDetail(int productNo, int attachNo);

	ProductDto selectOne(int productNo);
	List<ProductDto> selectList(PaginationVO vo);
	
	AttachDto findImage(int productNo);//상품수정 페이지에 찍어줄 이미지 찾기
	
	
	
	
	
	
	int countList(PaginationVO vo);

}
