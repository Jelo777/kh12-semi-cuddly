package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ProductListDto;

@Component
public class ProductListMapper implements RowMapper<ProductListDto>{
	
	@Override
	public ProductListDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProductListDto productListDto = new ProductListDto();
		productListDto.setProductNo(rs.getInt("product_no"));
		productListDto.setProductName(rs.getString("product_name"));
		productListDto.setProductPrice(rs.getInt("product_price"));
		productListDto.setProductDate(rs.getDate("product_date"));
		productListDto.setProductItem(rs.getString("product_item"));
		productListDto.setCreatorName(rs.getString("creator_name"));
		return productListDto;
	}
}
