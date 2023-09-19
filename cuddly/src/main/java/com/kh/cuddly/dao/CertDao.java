package com.kh.cuddly.dao;

import com.kh.cuddly.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	boolean deleteOver5min();
	CertDto selectOne(String certEmail);
	CertDto selectOneIn5min(String certEmail);
}
