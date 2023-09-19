package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.AddressDto;
@Component
public class AddressMapper implements RowMapper<AddressDto> {
	
	@Override
	public AddressDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AddressDto addressDto = new AddressDto();
		addressDto.setAddressNo(rs.getInt("address_no"));
		addressDto.setMemberId(rs.getString("member_id"));
		addressDto.setAddressName(rs.getString("address_name"));
		addressDto.setAddressContact(rs.getString("address_contact"));
		addressDto.setAddressPost(rs.getString("address_post"));
		addressDto.setAddressAddr1(rs.getString("address_addr1"));
		addressDto.setAddressAddr2(rs.getString("address_addr2"));
		addressDto.setAddressComent(rs.getString("address_coment"));
		addressDto.setAddressDefault(rs.getString("address_default"));
		return addressDto;
}
}
