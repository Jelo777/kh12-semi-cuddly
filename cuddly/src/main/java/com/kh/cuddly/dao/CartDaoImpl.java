package com.kh.cuddly.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.cuddly.dto.CartDto;

public class CartDaoImpl implements CartDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public int sequence() {
		String sql = "select cart_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	@Override
	public void insert(CartDto CartDto) {
		String sql = "insert into cart("
				+ "cart_no, cart_count, cart_price, cart_date"
				+  ") values(?, ?, ?, ?)";
		Object[] data = {
				CartDto.getCartNo(), CartDto.getCartCount(), CartDto.getCartPrice(), CartDto.getCartDate()
		};
		jdbcTemplate.update(sql,data);
	}

}
