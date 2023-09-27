package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.FaqlistVO;
import com.kh.cuddly.dto.FaqDto;





public interface FaqDao {
	
	void insert(FaqDto faqDto);
	int sequence();
	FaqDto selectOne(int faqNo);
	List<FaqDto> selectList();
	boolean update(FaqDto faqDto);
	boolean delete(int faqNo);
	List<FaqDto> selectList(String category, String keyword);
	List<FaqDto> selectCategory(String category);
	int countList(FaqlistVO vo);
	List<FaqDto> selectListByPage(FaqlistVO vo);
	List<FaqDto> selectListByTitle(String keyword);
	List<FaqDto> selectList2(int faqNo);
	
}