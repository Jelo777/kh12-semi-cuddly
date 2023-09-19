package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.OrdersDetailDto;


public class OrdersDetailMapper implements RowMapper<OrdersDetailDto>{{

}

@Override
public OrdersDetailDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	OrdersDetailDto ordersDetailDto = new OrdersDetailDto();
	ordersDetailDto.setOrdersDetailNo(rs.getInt("orders_detail_no"));
	ordersDetailDto.setOrdersDetailCount(rs.getInt("orders_detail_count"));
	ordersDetailDto.setOrdersDetailPrice(rs.getInt("orders_detail_price"));
	return ordersDetailDto;
	}
}
