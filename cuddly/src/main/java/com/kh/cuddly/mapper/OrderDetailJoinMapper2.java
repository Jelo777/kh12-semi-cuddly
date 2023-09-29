package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.cuddly.dto.OrderDetailJoinDto2;

@Component
public class OrderDetailJoinMapper2 implements RowMapper<OrderDetailJoinDto2>{

	@Override
	public OrderDetailJoinDto2 mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		OrderDetailJoinDto2 orderDetailDto2 = new OrderDetailJoinDto2();
		
		orderDetailDto2.setCreatorName(rs.getString("creator_name"));
		orderDetailDto2.setOrdersDate(rs.getDate("orders_date"));
		orderDetailDto2.setOrdersDetailCount(rs.getInt("orders_detail_count"));
		orderDetailDto2.setOrdersDetailNo(rs.getInt("orders_detail_no"));
		orderDetailDto2.setOrdersDetailPrice(rs.getInt("orders_detail_price"));
		orderDetailDto2.setOrdersNo(rs.getInt("orders_no"));
		orderDetailDto2.setProductName(rs.getString("product_name"));
		orderDetailDto2.setProductNo(rs.getInt("product_no"));
		orderDetailDto2.setProductOptionName(rs.getString("product_option_name"));
		orderDetailDto2.setMemberId(rs.getString("member_id"));
		orderDetailDto2.setOrderCount(rs.getInt("order_count")-1);
		orderDetailDto2.setTwo(rs.getInt("order_count")>1);
		orderDetailDto2.setOrdersPrice(rs.getInt("orders_price"));
		
		
		
		return orderDetailDto2;
	}

}
