package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrdersProductDto;

@Component
public class OrdersProductMapper implements RowMapper<OrdersProductDto>{

	@Override
	public OrdersProductDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		OrdersProductDto ordersProductDto = new OrdersProductDto();
		
		ordersProductDto.setProductNo(rs.getInt("product_no"));
		ordersProductDto.setProductOptionNo(rs.getInt("product_option_no"));
		ordersProductDto.setProductName(rs.getString("product_name"));
		ordersProductDto.setProductPrice(rs.getInt("product_price"));
		ordersProductDto.setProductOptionName(rs.getString("product_option_name"));
		ordersProductDto.setProductOptionStock(rs.getInt("product_option_stock"));
		ordersProductDto.setCreatorName(rs.getString("creator_name"));
		
		return ordersProductDto;
		
	}

}
