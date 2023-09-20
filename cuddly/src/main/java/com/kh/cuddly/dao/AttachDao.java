package com.kh.cuddly.dao;

import com.kh.cuddly.dto.AttachDto;

public interface AttachDao {
	int sequence();
	void insert(AttachDto attachDto);
	AttachDto selectOne(int attachNo);
	
}
