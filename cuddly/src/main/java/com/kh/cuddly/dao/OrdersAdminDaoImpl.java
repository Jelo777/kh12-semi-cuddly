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
		String sql = "select  "
				+"p.product_no, "
				+ "o.orders_date, "
				+ "p.product_name, "
				+ "p.product_price, "
				+ "po.product_option_name, "
				+ "od.orders_detail_count, "
				+ "c.creator_name, "
				+ "od.orders_detail_no "
				+ "from  "
				+ "orders o, orders_detail od, product_option po, product p, creator_product cp, creator c "
				+ "where "
				+ "o.orders_no = od.orders_no  "
				+ "and "
				+ "od.orders_no = po.product_option_no  "
				+ "and "
				+ "p.product_no = po.product_no  "
				+ "and "
				+ "cp.product_no = p.product_no  "
				+ "and "
				+ "c.creator_no = cp.creator_no "
				+"and o.member_id = ?";
		Object[] data = {memberId};
		
		return jdbcTemplate.query(sql, ordersAdminMapper, data);
	}

}
