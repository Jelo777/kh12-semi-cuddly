package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto> {

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberName(rs.getString("member_name"));
		memberDto.setMemberPw(rs.getString("member_pw"));
		memberDto.setMemberContact(rs.getString("member_contact"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberLevel(rs.getString("member_level"));
		memberDto.setMemberTotalprice(rs.getInt("member_totalprice"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberUdate(rs.getDate("member_udate"));
		return memberDto;
	}

}
