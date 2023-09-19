package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.mapper.MemberMapper;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberMapper memberMapper;


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

}
