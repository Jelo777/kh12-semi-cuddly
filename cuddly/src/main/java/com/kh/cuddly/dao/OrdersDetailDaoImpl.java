package com.kh.cuddly.dao;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.OrderDetailJoinDto;
import com.kh.cuddly.dto.OrdersDetailDto;
import com.kh.cuddly.mapper.OrderDetailJoinMapper;
import com.kh.cuddly.mapper.OrdersDetailMapper;



@Repository
public class OrdersDetailDaoImpl implements OrdersDetailDao{


	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersDetailMapper ordersDetailMapper;
	
	@Autowired
	private OrderDetailJoinMapper orderDetailjoinMapper;
	
	
	
	@Override
	public int sequence() {
		String sql = "select orders_detail_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}


	@Override
	public void insert(OrdersDetailDto ordersDetailDto) {
		String sql = "insert into orders_detail("
				+ "orders_detail_no, orders_no, option_no, product_no, orders_detail_count, orders_detail_price"
				+ ") values(?, ?, ?, ?, ?, ?)";
		
		Object[] data = {
				ordersDetailDto.getOrdersDetailNo(),
				 ordersDetailDto.getOrdersNo(),
		            ordersDetailDto.getOptionNo(),
		            ordersDetailDto.getProductNo(),
		            ordersDetailDto.getOrdersDetailCount(),
		            ordersDetailDto.getOrdersDetailPrice()
		};
		
		jdbcTemplate.update(sql, data);
		}


	@Override
	public List<OrderDetailJoinDto> detailList(int ordersNo) {
		String sql = "select * from detail_order where orders_no=?";
		
		Object[] data = {ordersNo};
		
	    return jdbcTemplate.query(sql, orderDetailjoinMapper, data);
		}


	@Override
	public List<OrderDetailJoinDto> memberOrdersList(String memberId) {
		
		String sql = "select * from detail_order where member_id=?";
		
		Object[] data = {memberId};
		
		return jdbcTemplate.query(sql, orderDetailjoinMapper,data);
		
	}	
	}




