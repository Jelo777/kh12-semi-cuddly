package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.CreatorDto;

public interface CreatorDao {
	int sequence();
	void insert(CreatorDto creatorDto);
	boolean isNewCreator(String creatorName);
	
	
	CreatorDto selectOneByProductNo(int productNo);//상품과 연결된 크리에이터 검색
	CreatorDto selectOne(String creatorName);
	CreatorDto selectOne(int creatorNo);
	List<CreatorDto> selectList();
	List<CreatorDto> selectList(String creatorName);
}
