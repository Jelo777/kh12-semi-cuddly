package com.kh.cuddly.dao;

import com.kh.cuddly.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	boolean deleteOver10min();
	CertDto selectOne(String certEmail);
	CertDto selectOneIn10min(String certEmail);
}
