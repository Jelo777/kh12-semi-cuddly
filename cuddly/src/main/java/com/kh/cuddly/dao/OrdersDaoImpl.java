package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.OrdersDto;

@Repository
public class OrdersDaoImpl implements OrdersDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	
	@Override
	public int sequence() {
		String sql = "select orders_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(OrdersDto ordersDto) {
		String sql = "insert into orders("
				+ "orders_no, member_id, address_no, orders_price, orders_payment "
				+ ") values (?, ?, ?, ?, ?)";
		Object[] data = {
				ordersDto.getOrdersNo(), ordersDto.getMemberId(),
				ordersDto.getAddressNo(), ordersDto.getOrdersPrice(), 
				ordersDto.getOrdersPayment()
		};
		jdbcTemplate.update(sql, data);
	}
		
}

