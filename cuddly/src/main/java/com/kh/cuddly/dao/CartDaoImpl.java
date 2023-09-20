package com.kh.cuddly.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.mapper.CartMapper;

public class CartDaoImpl implements CartDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CartMapper cartMapper;
	
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

	@Override
	public CartDto selectOne(int cartNo) {
		String sql = "select * from cart where cart_no = ?";
		Object[] data = {cartNo};
		List<CartDto> list = jdbcTemplate.query(sql, cartMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

}
