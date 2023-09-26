package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.OrdersAdminDto;
import com.kh.cuddly.mapper.OrdersAdminMapper;

@Repository
public class OrdersAdminDaoImpl implements OrdersAdminDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private OrdersAdminMapper ordersAdminMapper;
	
	@Override
	public List<OrdersAdminDto> selectList(String memberId) {
		String sql = "select "
				+ "o.orders_no, "
				+ "(select count(*) from orders_detail "
				+ "where orders_detail.orders_no = o.orders_no) as orders_count, "
				+ "o.orders_date, "
				+ "od.orders_detail_no, "
				+ "p.product_name, "
				+ "c.creator_name, "
				+ "po.product_option_name, "
				+ "od.orders_detail_count, "
				+ "od.orders_detail_price, "
				+ "o.member_id, "
				+ "p.product_no "
				+ "from orders o "
				+ "inner join orders_detail od ON o.orders_no = od.orders_no "
				+ "inner join product_option po ON od.option_no = po.product_option_no "
				+ "inner join product p ON po.product_no = p.product_no "
				+ "inner join creator_product cp ON p.product_no = cp.product_no "
				+ "inner join creator c ON cp.creator_no = c.creator_no "
				+ "where member_id = ? "
				+ "GROUP BY o.orders_no, o.orders_date, od.orders_detail_no, p.product_name, "
				+ "c.creator_name, po.product_option_name, od.orders_detail_count, od.orders_detail_price, o.member_id, p.product_no";
		Object[] data = {memberId};
		
		return jdbcTemplate.query(sql, ordersAdminMapper, data);
	}

}
