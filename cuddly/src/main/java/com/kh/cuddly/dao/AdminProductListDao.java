package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AdminProductListDto;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;

public interface AdminProductListDao {
	List<AdminProductListDto> selectList(PaginationVO vo);
	
	AttachDto findProductMainImage(int productNo);//상품 메인 이미지 찾기
	
	int countList(PaginationVO vo);
}
