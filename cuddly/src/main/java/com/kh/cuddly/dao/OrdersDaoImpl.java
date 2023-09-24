package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.OrdersDto;
import com.kh.cuddly.dto.OrdersProductDto;
import com.kh.cuddly.mapper.OrdersMapper;
import com.kh.cuddly.mapper.OrdersProductMapper;


@Repository
public class OrdersDaoImpl implements OrdersDao{

	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersMapper ordersMapper;
	
	@Autowired
	private OrdersProductMapper ordersProductMapper;
	
	
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
	public OrdersDto selectOne(String memberId) {
	    String sql =  "SELECT m.member_name, m.member_contact, m.member_email " +
                "FROM orders o " +
                "JOIN member m ON o.member_id = m.member_id " +
                "WHERE o.orders_no = ?";
	    Object[] data = {memberId};
	    List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
	    return list.isEmpty() ? null : list.get(0);
	}



	@Override
	public List<OrdersDto> selectList() {
		String sql = "select * from orders_list order by orders_detail_no desc";
		return jdbcTemplate.query(sql, ordersMapper);
	}
	
	@Override
	public OrdersProductDto viewProduct(int cartNo) {
		
		String sql = "select * from three_join where cart_no = ?";
		
		Object[] data= {cartNo};
		
		List<OrdersProductDto> list = jdbcTemplate.query(sql, ordersProductMapper, data);
	    return list.isEmpty() ? null : list.get(0);
	}
	
	
	@Override
	public List<OrdersDto> selectOneByMemberOrders(String memberId) {//회원별 구매내역
		String sql = "select * from orders "
				+ "inner join member on orders.member_id = member.member_id "
				+ "where orders.member_id = ?";
		Object[] data = {memberId};
		
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list;
	}
	
	
	
}


