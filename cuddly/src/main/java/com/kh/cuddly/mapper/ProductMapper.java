package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ProductDto;

@Component
public class ProductMapper implements RowMapper<ProductDto>{
	
	@Override
	public ProductDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProductDto productDto = new ProductDto();
		productDto.setProductNo(rs.getInt("product_no"));
		productDto.setProductName(rs.getString("product_name"));
		productDto.setProductPrice(rs.getInt("product_price"));
		productDto.setProductDate(rs.getDate("product_date"));
		return productDto;
	}
}
