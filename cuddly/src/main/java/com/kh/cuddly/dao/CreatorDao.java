package com.kh.cuddly.dao;

import com.kh.cuddly.dto.CreatorDto;

public interface CreatorDao {
	int sequence();
	void insert(CreatorDto creatorDto);
}
