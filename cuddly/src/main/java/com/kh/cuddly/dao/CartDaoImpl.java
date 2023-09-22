package com.kh.cuddly.dao;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.cuddly.dto.CartDto;
import com.kh.cuddly.mapper.CartMapper;


@Repository
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
	public void insert(CartDto cartDto) {
		String sql = "insert into cart("
				+ "cart_no,member_id,option_no,cart_count,cart_price"
				+  ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				cartDto.getCartNo(),cartDto.getMemberId(),cartDto.getOptionNo(),cartDto.getCartCount(),cartDto.getCartPrice()
		};
		jdbcTemplate.update(sql,data);
	}

	 @Override
	    public List<CartDto> selectCartList() {
	        String sql = "SELECT c.*, p.product_name " +
	                     "FROM cart c " +
	                     "JOIN product_option po ON c.option_no = po.product_option_no " +
	                     "JOIN product p ON po.product_no = p.product_no";
	        return jdbcTemplate.query(sql, cartMapper);
	    }
	
}

