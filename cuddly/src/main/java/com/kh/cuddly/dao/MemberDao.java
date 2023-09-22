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
	boolean delete(String memberId);
	MemberDto selectOneByEmail(String memberEmail);

	List<MemberListDto> selectList();//관리자용 회원리스트 조회
	List<MemberListDto> selectListBySearch(String type, String keyword);//회원리스트 검색일때 리스트
	
	int countList(PaginationVO vo);
	
}
