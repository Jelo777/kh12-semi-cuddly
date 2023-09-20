package com.kh.cuddly.dao;

import com.kh.cuddly.dto.CategoryDto;

public interface CategoryDao {

	int sequence();
	void insert(CategoryDto categoryDto);
}
