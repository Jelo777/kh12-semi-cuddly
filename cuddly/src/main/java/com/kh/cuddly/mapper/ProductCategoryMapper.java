package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ProductCategoryDto;

@Component
public class ProductCategoryMapper implements RowMapper<ProductCategoryDto>{

	@Override
	public ProductCategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProductCategoryDto productCategoryDto = new ProductCategoryDto();
		productCategoryDto.setCategoryNo(rs.getInt("category_no"));
		productCategoryDto.setProductNo(rs.getInt("product_no"));
		return productCategoryDto;
	}
}
