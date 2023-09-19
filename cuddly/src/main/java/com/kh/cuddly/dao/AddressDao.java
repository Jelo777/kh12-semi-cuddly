package com.kh.cuddly.dao;

import com.kh.cuddly.dto.AddressDto;

public interface AddressDao {
	int sequence();
	void insert(AddressDto addressDto);
	
}
