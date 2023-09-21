package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.CreatorProductDto;

public class CreatorProductMapper implements RowMapper<CreatorProductDto>{

	@Override
	public CreatorProductDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CreatorProductDto creatorProductDto = new CreatorProductDto();
		creatorProductDto.setCreatorNo(rs.getInt("creator_no"));
		creatorProductDto.setProductNo(rs.getInt("product_no"));
		return creatorProductDto;
	}
}
