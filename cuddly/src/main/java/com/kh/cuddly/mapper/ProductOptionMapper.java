package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.ProductOptionDto;

@Component
public class ProductOptionMapper implements RowMapper<ProductOptionDto>{

	@Override
	public ProductOptionDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProductOptionDto productOptionDto = new ProductOptionDto();
		productOptionDto.setProductOptionNo(rs.getInt("product_option_no"));
		productOptionDto.setProductNo(rs.getInt("product_no"));
		productOptionDto.setProductOptionName(rs.getString("product_option_name"));
		productOptionDto.setProductOptionStock(rs.getInt("product_option_stock"));
		return productOptionDto;
	}
}
