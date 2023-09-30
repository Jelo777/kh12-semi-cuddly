package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrderDetailJoinDto;

@Component
public class OrderDetailJoinMapper implements RowMapper<OrderDetailJoinDto>{

	@Override
	public OrderDetailJoinDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		OrderDetailJoinDto orderDetailDto = new OrderDetailJoinDto();
		
		orderDetailDto.setCreatorName(rs.getString("creator_name"));
		orderDetailDto.setOrdersDate(rs.getDate("orders_date"));
		orderDetailDto.setOrdersDetailCount(rs.getInt("orders_detail_count"));
		orderDetailDto.setOrdersDetailNo(rs.getInt("orders_detail_no"));
		orderDetailDto.setOrdersDetailPrice(rs.getInt("orders_detail_price"));
		orderDetailDto.setOrdersNo(rs.getInt("orders_no"));
		orderDetailDto.setProductName(rs.getString("product_name"));
		orderDetailDto.setProductNo(rs.getInt("product_no"));
		orderDetailDto.setProductOptionName(rs.getString("product_option_name"));
		orderDetailDto.setMemberId(rs.getString("member_id"));
		orderDetailDto.setOrdersPrice(rs.getInt("orders_price"));
		
		
		return orderDetailDto;
	}

}
