package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.VO.PaginationVO;
import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.MemberListDto;
import com.kh.cuddly.mapper.MemberListMapper;
import com.kh.cuddly.mapper.MemberMapper;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private MemberListMapper memberListMapper;

	@Override
	public void insert(MemberDto memberDto) {
		String sql="insert into member("
					+ "member_id, member_name, member_pw, "
					+ "member_contact, member_email, member_birth) "
					+ "values(?, ?, ? ,?, ?, ?)";
		Object[] data= {
				memberDto.getMemberId(),memberDto.getMemberName(), 
				memberDto.getMemberPw(), memberDto.getMemberContact(), 
				memberDto.getMemberEmail(), memberDto.getMemberBirth()
				
		};
		jdbcTemplate.update(sql,data);
	}

	@Override
	public MemberDto selectOne(String memberId) {
		String sql="select * from member where member_id =?";
		Object[] data= {
				memberId
		};
		List<MemberDto> list=jdbcTemplate.query(sql, memberMapper,data);
		return list.isEmpty() ? null: list.get(0);
	}
	
	@Override
	public boolean updateMemberPw(String memberId, String changePw) {
		String sql="update member "
					+ "set member_pw=?, member_udate=sysdate "
					+ "where member_id=?";
		Object[] data= {changePw, memberId};
		return jdbcTemplate.update(sql,data)>0;
	}
	
	@Override
	public boolean updateMemberInfo(MemberDto memberDto) {
		String sql="update member set "
					+ "member_contact =?, member_email=?, "
					+ "member_birth =? where member_id= ?";
		Object[] data= {
				memberDto.getMemberContact(), memberDto.getMemberEmail(), 
				memberDto.getMemberBirth(), memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql,data)>0;
	}
	
	@Override
	public boolean delete(String memberId) {
		String sql="delete member where member_id =?";
		Object[] data= {memberId};
		return jdbcTemplate.update(sql,data)>0;
	}
	@Override
	public MemberDto selectOneByEmail(String memberEmail) {
		String sql="select * from member where member_email=?";
		Object[] data= {memberEmail};
		List<MemberDto> list=jdbcTemplate.query(sql, memberMapper,data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<MemberListDto> selectList() {//관리자용 회원리스트 조회
		String sql = "select * from member order by member_join desc";
		return jdbcTemplate.query(sql, memberListMapper);
	}
	
	@Override
	public List<MemberListDto> selectListBySearch(String type, String keyword) {//회원리스트 검색일때 리스트
		String sql = "select * from member where instr("+type+", ?) > 0 order by member_join desc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, memberListMapper, data);
	}

	@Override
	public int countList(PaginationVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	
}
