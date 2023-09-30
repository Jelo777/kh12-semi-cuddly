package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.ProductListVO;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;

public interface ProductDao {
	int sequence();//시퀀스번호
	void insert(ProductDto productDto);//상품등록	
	
	void connectMain(int productNo, int attachNo);//메인사진 등록
	void connectDetail(int productNo, int attachNo);//상세사진 등록

	ProductDto selectOne(int productNo);//상품번호로 상품상세조회
	
	List<ProductDto> selectList(ProductListVO vo);//상품리스트/ 정렬 포함
	List<ProductDto> selectListByCreator(ProductListVO vo);//크리에이터별 상품/ 정렬 
	List<ProductDto> selectListByProductItem(ProductListVO vo);//품목별 정렬

	int countList(ProductListVO vo);//페이징을 위한 상품 개수 가져오기
	
	AttachDto findProductMainImage(int productNo);//상품 메인 이미지 찾기
	AttachDto findProductDetailImage(int productNo);//상품 상세 이미지 찾기
	

}