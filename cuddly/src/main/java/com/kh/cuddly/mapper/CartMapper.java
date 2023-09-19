package com.kh.cuddly.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.kh.cuddly.dto.CartDto;

public class CartMapper implements RowMapper<CartDto>{

	@Override
	public CartDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CartDto cartDto = new CartDto();
		cartDto.setCartNo(rs.getInt("cart_no"));
		cartDto.setCartCount(rs.getInt("cart_count"));
		cartDto.setCartPrice(rs.getInt("cart_price"));
		cartDto.setCartDate(rs.getDate("cart_date"));
		return cartDto;
	}
}
