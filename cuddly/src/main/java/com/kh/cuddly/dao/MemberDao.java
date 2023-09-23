package com.kh.cuddly.dao;

import java.util.List;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MemberListDto;

public interface MemberDao {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	boolean updateMemberPw(String memberId, String changePw);
	boolean updateMemberInfo(MemberDto memberDto);
	boolean updateMemberLevel(MemberDto memberDto);//관리자용 회원 등급수정
	boolean delete(String memberId);
	MemberDto selectOneByEmail(String memberEmail);

	int countList(PaginationVO vo);
	List<MemberListDto> selectByPage(PaginationVO vo);//관리자용 회원리스트 조회
	
}
