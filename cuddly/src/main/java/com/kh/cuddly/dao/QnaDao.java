package com.kh.cuddly.dao;

import com.kh.cuddly.dto.QnaDto;

public interface QnaDao {
	
	void insert(QnaDto qnaDto);
	int sequence();
	boolean update(QnaDto qnaDto);
	QnaDto selectOne(int qnaNo);
}
