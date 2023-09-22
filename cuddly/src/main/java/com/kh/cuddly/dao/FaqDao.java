package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.FaqDto;


public interface FaqDao {
	
	void insert(FaqDto faqDto);
	int sequence();
	FaqDto selectOne(int faqNo);
	List<FaqDto> selectList();
	boolean update(FaqDto faqDto);
	boolean delete(int faqNo);
	List<FaqDto> selectList(String type, String keyword);
	List<FaqDto> selectCategory(String category);
}