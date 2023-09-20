package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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
		String sql = "insert into orders ("
	            + "orders_no, member_id, address_no, orders_price, orders_payment "
	            + ") values (?, ?, ?, ?, ?)";
		 Object[] data = {
		            ordersDto.getOrdersNo(), ordersDto.getMemberId(), ordersDto.getAddressNo(), 
		            ordersDto.getOrdersPrice(), ordersDto.getOrdersPayment()
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
	public List<OrdersDto> selectList() {
		String sql = "select * from orders_list order by orders_detail_no desc";
		return jdbcTemplate.query(sql, ordersMapper);
	}
}


