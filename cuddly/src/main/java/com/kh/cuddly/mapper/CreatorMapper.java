package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.CreatorDto;

@Component
public class CreatorMapper implements RowMapper<CreatorDto>{
	
	@Override
	public CreatorDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CreatorDto creatorDto = new CreatorDto();
		creatorDto.setCreatorNo(rs.getInt("creator_no"));
		creatorDto.setProductNo(rs.getInt("product_no"));
		creatorDto.setCreatorName(rs.getString("creator_name"));
		return creatorDto;
	}
}
