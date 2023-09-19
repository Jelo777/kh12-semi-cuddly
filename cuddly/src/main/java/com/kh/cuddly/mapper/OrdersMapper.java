package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrdersDto;


@Component
public class OrdersMapper implements RowMapper<OrdersDto>{

	@Override
	public OrdersDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersDto ordersDto = new OrdersDto();
		ordersDto.setOrdersNo(rs.getInt("orders_no"));
		ordersDto.setOrdersPrice(rs.getInt("orders_price"));
		ordersDto.setOrdersPayment(rs.getString("orders_payment"));
		ordersDto.setOrdersDate(rs.getDate("orders_date"));
		return ordersDto;
	}
}
