package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.mapper.OrdersDetailMapper;

public class OrdersDetailDaoImpl implements OrdersDetailDao{


	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersDetailMapper ordersDetailMapper;
	
	
	@Override
	public int sequence() {
		String sql = "select orders_detail_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}


	@Override
	public void insert(OrdersDetailDto ordersDetailDto) {
		String sql = "insert into orders_detail("
				+ "orders_detail_no, orders_detail_count, orders_detail_price"
				+ ") values(?, ?, ?)";
		Object[] data = {
				ordersDetailDto.getOrdersDetailNo(), ordersDetailDto.getOrdersDetailCount(), ordersDetailDto.getOrdersDetailPrice()
		};
		jdbcTemplate.update(sql, data);
		}


	@Override
	public OrdersDetailDto selectOne(int ordersDetailNo) {
		String sql = "select * from ordersDetail where orderDetail_no = ?";
		Object[] data = {ordersDetailNo};
		List<OrdersDetailDto> list = jdbcTemplate.query(sql, ordersDetailMapper, data);
		return list.isEmpty() ? null : list.get(0);
		
	}
		
	}




