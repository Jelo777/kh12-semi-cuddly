package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.AddressDto;

public interface AddressDao {
	int sequence();
	void insert(AddressDto addressDto);
	AddressDto selectOne(String memberId);
	List<AddressDto>selectList();
	void changeDefault(String memberId);
}
