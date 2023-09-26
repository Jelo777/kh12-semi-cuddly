package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.AdminProductListDto;

@Component
public class AdminProductListMapper implements RowMapper<AdminProductListDto>{

	@Override
	public AdminProductListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminProductListDto adminProductListDto = new AdminProductListDto();
		adminProductListDto.setOptionCount(rs.getInt("option_count"));
		adminProductListDto.setProductNo(rs.getInt("product_no"));
		adminProductListDto.setProductName(rs.getString("product_name"));
		adminProductListDto.setProductDate(rs.getDate("product_date"));
		adminProductListDto.setCreatorName(rs.getString("creator_name"));
		return adminProductListDto;
	}

}
