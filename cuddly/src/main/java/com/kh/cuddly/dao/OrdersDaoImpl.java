package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.MemberDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.mapper.OrdersMapper;


@Repository
public class OrdersDaoImpl implements OrdersDao{

	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersMapper ordersMapper;
	
	
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

	@Override
	public OrdersDto selectOne(int ordersNo) {
		String sql = "select * from orders where orders_no = ?";
		Object[] data = {ordersNo};
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public boolean update(OrdersDto ordersDto) {
		String sql = "update orders "
				+ "set "
				+ "orders_price=?, "
				+ "orders_payment=?, "
				+ "orders_date=sysdate "
				+ "where orders_no=?";
		Object[] data = {
				ordersDto.getOrdersPrice(), ordersDto.getOrdersPayment(),
				ordersDto.getOrdersDate(), ordersDto.getOrdersNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}


}


