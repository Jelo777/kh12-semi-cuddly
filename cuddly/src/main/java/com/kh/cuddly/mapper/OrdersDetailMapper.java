package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrdersDetailDto;

@Component
public class OrdersDetailMapper implements RowMapper<OrdersDetailDto>{

	@Override
	public OrdersDetailDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersDetailDto ordersDetailDto = new OrdersDetailDto();
		ordersDetailDto.setOrdersDetailNo(rs.getInt("orders_detail_no"));
		ordersDetailDto.setOrdersNo(rs.getInt("orders_no"));
		ordersDetailDto.setOptionNo(rs.getInt("option_no"));
		ordersDetailDto.setProductNo(rs.getInt("product_no"));
		ordersDetailDto.setOrdersDetailCount(rs.getInt("orders_detail_count"));
		ordersDetailDto.setOrdersDetailPrice(rs.getInt("orders_detail_price"));
		
		return ordersDetailDto;
	}
}
