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
	    public List<CartDto> selectCartList() {
	        String sql = "SELECT c.*, p.product_name " +
	                     "FROM cart c " +
	                     "JOIN product_option po ON c.option_no = po.product_option_no " +
	                     "JOIN product p ON po.product_no = p.product_no";
	        return jdbcTemplate.query(sql, cartMapper);
	    }
	
	
	//조인없이 장바구니만 조회하는 구문
//	@Override
//    public List<CartDto> selectCartList() {
//        String sql = "select * from cart order by cart_no asc";
//        return jdbcTemplate.query(sql, cartMapper);
//    }

}


