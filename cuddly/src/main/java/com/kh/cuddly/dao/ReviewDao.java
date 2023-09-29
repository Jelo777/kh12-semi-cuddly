package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ProductDto;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.dto.ReviewInfoDto;

public interface ReviewDao {
	
	void insert(ReviewDto reviewDto);
	int sequence();
	void connect(int reviewNo, int attachNo);
	AttachDto findImage(int reviewNo);
	List<ReviewInfoDto> selectMemberList(String memberId,PaginationVO vo);
	float reviewAvg (int productNo);
	ProductDto productInfo(int productNo);
	List<ReviewDto> selectListByProduct(int productNo);
	boolean delete(int reviewNo);
	ReviewDto selectOne(int reviewNo);
	boolean update(ReviewDto reviewDto);
	boolean checkReviewExistence(String memberId, int productNo);
	List<ReviewDto> list(PaginationVO vo);
	int countAllList(PaginationVO vo);
	int countMemberList(PaginationVO vo,String memberId);

}
