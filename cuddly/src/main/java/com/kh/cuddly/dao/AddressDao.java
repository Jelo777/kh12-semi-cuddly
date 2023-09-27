package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.dto.AddressDto;

public interface AddressDao {
	int sequence();
	void insert(AddressDto addressDto);
	AddressDto selectOne(String memberId);
	AddressDto selectOneByNo(int addressNo);
	List<AddressDto>selectList(String memberId);
	void changeDefault(String memberId);
	boolean delete(int addressNo);
	boolean update(AddressDto addressDto);
	boolean updateComenet(int addrNo, String addrComent);
}
