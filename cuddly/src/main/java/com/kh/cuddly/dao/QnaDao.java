package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.AttachDto;
import com.kh.cuddly.dto.QnaDto;

public interface QnaDao {
	
	void insert(QnaDto qnaDto);
	int sequence();
	boolean update(QnaDto qnaDto);
	QnaDto selectOne(int qnaNo);
	List<QnaDto> selectList();
	AttachDto findImage(int productNo);
	
}
