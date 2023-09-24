package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.MemberListDto;

@Component
public class MemberListMapper implements RowMapper<MemberListDto>{

	@Override
	public MemberListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberListDto memberListDto = new MemberListDto();
		memberListDto.setMemberId(rs.getString("member_id"));
		memberListDto.setMemberName(rs.getString("member_name"));
		memberListDto.setMemberContact(rs.getString("member_contact"));
		memberListDto.setMemberEmail(rs.getString("member_email"));
		memberListDto.setMemberLevel(rs.getString("member_level"));
		memberListDto.setMemberTotalprice(rs.getInt("member_totalprice"));
		memberListDto.setMemberJoin(rs.getDate("member_join"));
		return memberListDto;
	}

}
