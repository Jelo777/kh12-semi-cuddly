package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrdersAdminDto;

@Component
public class OrdersAdminMapper implements RowMapper<OrdersAdminDto>{

	@Override
	public OrdersAdminDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersAdminDto ordersAdminDto = new OrdersAdminDto();
		ordersAdminDto.setProductNo(rs.getInt("product_no"));
		ordersAdminDto.setOrdersDate(rs.getDate("orders_date"));
		ordersAdminDto.setProductName(rs.getString("product_name"));
		ordersAdminDto.setProductPrice(rs.getInt("product_price"));
		ordersAdminDto.setProductOptionName(rs.getString("product_option_name"));
		ordersAdminDto.setOrdersDetailCount(rs.getInt("orders_detail_count"));
		ordersAdminDto.setCreatorName(rs.getString("creator_name"));
		ordersAdminDto.setOrdersDetailNo(rs.getInt("orders_detail_no"));
		return ordersAdminDto;
	}

}
