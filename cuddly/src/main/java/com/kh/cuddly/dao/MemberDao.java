package com.kh.cuddly.dao;

import com.kh.cuddly.dto.MemberDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	
}
