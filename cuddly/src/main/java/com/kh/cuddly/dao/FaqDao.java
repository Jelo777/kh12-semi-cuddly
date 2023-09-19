package com.kh.cuddly.dao;

import com.kh.cuddly.dto.FaqDto;

public interface FaqDao {
	
	void insert(FaqDto faqDto);
	int sequence();

}
