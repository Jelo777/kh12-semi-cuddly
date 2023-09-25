package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.ReviewDto;
import com.kh.cuddly.dto.ReviewInfoDto;

public interface ReviewDao {
	
	void insert(ReviewDto reviewDto);
	int sequence();
	void connect(int reviewNo, int attachNo);
	AttachDto findImage(int reviewNo);
	List<ReviewInfoDto> selectMemberList(String memberId);
	float reviewAvg (int productNo);
	List<ReviewDto> memberList(String memberId);

}
