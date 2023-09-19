package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.CategoryDto;

@Component
public class CategoryMapper implements RowMapper<CategoryDto>{
	
	@Override
	public CategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CategoryDto categoryDto = new CategoryDto();
		categoryDto.setCategoryNo(rs.getInt("category_no"));
		categoryDto.setCategoryName(rs.getString("category_name"));
		return categoryDto;
	}
}
